import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:productadd/pages/ConfirmPage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../model/Barcode.dart';
import '../api/Post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/AlertDialog.dart';
import 'RegisterPage.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
// class OldAdd extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

class MainAddPage extends StatefulWidget {
  @override
  _MainAddPageState createState() => _MainAddPageState();
}

class _MainAddPageState extends State {
  //TextField取得
  final valueController = TextEditingController();
  List<Barcode> products = [];

  Widget _firstitemadd() {
    if (products.length != 0) {
      return addListCard(
        title: products.first.name,
        barcode: products.first.barcode,
        imgURL: products.first.imgURL,
        quantity: products.first.quantity,
        id: products.first.id,
      );
    }

    return Text('スキャンを開始してください。');
  }

  void _deleteitem(id) {
    print(id);
    for (int i = 0; i < products.length; i++) {
      print(products[i].id);
      if (products[i].id == id) {
        print('object');
        products.removeAt(i);
        setState(() {});
      }
    }
  }

  ///[products]の個数を記録しておくやつ。
  int productsindex = 0;

  ///qrCode初期値
  String qrCode = '0';

  //imgURL初期値
  String productURL = '';
  @override
  Widget build(BuildContext context) {
    // final String productURL =
    //     'https://store-project.f5.si/img/' + qrCode + '.png';
    final String productURL =
        'https://network.mobile.rakuten.co.jp/assets/img/product/iphone/iphone-13-pro/pht-device-16.png?220309-01';
    return Scaffold(
      appBar: AppBar(
        title: Text('バーコードスキャン'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Image(image: NetworkImage(productURL)),
                Text(
                  '$qrCode',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text('スキャン'),
                  onPressed: () => scanQrCode(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    /* ボタンがタップされた時の処理 */
                    products.insert(0,
                        (await Barcode.addProduct(2424242424, productsindex)));
                    setState(() {});
                  },
                  child: Text('テスト追加'),
                ),
                ElevatedButton(
                  onPressed: () {
                    //Navigator.of(context).pushNamed("/MainAddPage");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterItemPage()));
                    print('LOG:画面水ボタン');
                  },
                  child: Text('画面推移テスト'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    print(products.length);
                  },
                  child: Text('print test'),
                ),
              ],
            ),
          ),
          //スライドウィンド
          SlidingUpPanel(
            panel: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100.0,
                    child: Center(
                      child: _firstitemadd(),
                    ),
                  ),
                  Expanded(
                    child: ListView(children: [
                      for (int i = 1; i < products.length; i++) ...{
                        addListCard(
                          title: products[i].name,
                          barcode: products[i].barcode,
                          quantity: products[i].quantity,
                          imgURL: products[i].imgURL,
                          id: products[i].id,
                        )
                      }
                    ]),
                  ),
                  //ボタン参照
                  _bottomButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //ボタン

  Widget _bottomButtons() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 10,
        right: 10.0,
      ),
      child: Row(children: [
        ElevatedButton(
          onPressed: () {
            //print('aaa');
            //_request();
            // print(PostRequest.postMethod(products));
            // print('hello');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ConfirmPage(
                          products: products,
                        )));
          },
          child: Text('続行する'),
        ),
      ]),
    );
  }

  Future scanQrCode() async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
      '#EB394B',
      'キャンセル',
      false,
      ScanMode.BARCODE,
    );
    if (!mounted) return;
    //products.add(await Barcode.addProduct(this.qrCode));
    setState(() {
      this.qrCode = qrCode;
      this.productURL = qrCode;
    });
    if (qrCode == '-1') {
      return;
    }

    Barcode addProduct = await Barcode.addProduct(qrCode, productsindex);
    print(productsindex);

    /// [products]に同じのがあったらreturn
    for (int i = 0; i < products.length; i++) {
      if (addProduct.barcode == products[i].barcode) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("同じ商品が読み込まれています。"),
              content: Text(
                  "この商品はすでに読み込まれています。\n読み込み一覧を確認してください。\n商品名 : ${products[i].name}\nコード ${addProduct.barcode}"),
              actions: <Widget>[
                FlatButton(
                    child: Text("閉じる"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            );
          },
        );
        return;
      }

      ///同じ商品だったらreturn
    }
    if (addProduct.price == -400) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("この商品は登録されていません。"),
            content:
                Text("この商品は登録されていません。登録処理をしてください\nコード ${addProduct.barcode}"),
            actions: <Widget>[
              // ボタン領域
              FlatButton(
                  child: Text("キャンセル"),
                  onPressed: () => Navigator.pop(context)),
              FlatButton(
                  child: Text("登録"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed("/ProductAdd",
                        arguments: addProduct.barcode);
                  }),
            ],
          );
        },
      );
      return;
    }
    // ここで追加
    print(addProduct);
    productsindex++;
    //products.add(addProduct);
    products.insert(0, addProduct);
    setState(() {});
  }

  void _inputchange(String e) {
    setState(() {
      // _text = e;
      print(e);
      setState(() {});
    });
  }

  Card addListCard({
    required String title,
    required String barcode,
    required int quantity,

    //required IconData icon,
    required String imgURL,
    required int id,
    //required Function()? onPressed,
  }) {
    return Card(
      //key: key,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 100.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon(
              //   icon,
              //   size: 50.0,
              // ),
              Container(
                width: 50,
                height: 50,
                child: Image.network(imgURL),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                    ),
                    Text(
                      barcode,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              //Text('${quantity} 個'),
              SizedBox(
                  height: 50,
                  width: 50,
                  // child: Text('${quantity}'),
                  // child: TextField(
                  //   keyboardType: TextInputType.numberWithOptions(
                  //       signed: true, decimal: true),
                  //   controller: TextEditingController(text: '${quantity}'),
                  //   onChanged: _inputchange,
                  // ),
                  child: TextField(
                    // controller: TextEditingController(text: '${quantity}'),
                    controller: TextEditingController(text: "value"),
                    onChanged: _inputchange,
                  )),
              // Icon(Icons.cancel)
              IconButton(
                  onPressed: () {
                    _deleteitem(id);
                  },
                  icon: Icon(Icons.cancel)),
            ],
          ),
        ),
      ),
    );
  }
}
