import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:productadd/src/pages/ConfirmPage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../model/Barcode.dart';
import '../RegisterPages/NewAddPage.dart';

class MainAddPage extends StatefulWidget {
  @override
  _MainAddPageState createState() => _MainAddPageState();
}

class _MainAddPageState extends State {
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

  ///[products]初期化
  List<Barcode> products = [];

  ///[products]の個数を記録しておくやつ。
  int productsindex = 0;

  ///qrCode初期化
  String qrCode = '0';

  //imgURL初期化
  String productURL = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('バーコードスキャン'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text(
                    'スキャン',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () => scanQrCode(),
                ),
                SizedBox(height: 20),

                /// テスト用 >>>
                // ElevatedButton(
                //   onPressed: () async {
                //     addProductContents('4902102072618');
                //     setState(() {});
                //   },
                //   child: Text('テスト追加'),
                // ),
                SizedBox(height: 20),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        left: 10,
                        right: 10.0,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmPage(
                                        products: products,
                                      )));
                        },
                        child: const Text('続行する'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
    setState(() {
      this.qrCode = qrCode;
      this.productURL = qrCode;
    });
    if (qrCode == '-1') {
      return;
    }
    addProductContents(qrCode);
  }

  Future addProductContents(String addqrcode) async {
    Barcode addProduct = await Barcode.addProduct(addqrcode, productsindex);
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
                ElevatedButton(
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
              ElevatedButton(
                  child: Text("キャンセル"),
                  onPressed: () => Navigator.pop(context)),
              ElevatedButton(
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
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    controller: TextEditingController(text: "${quantity}"),
                    onChanged: (input) {
                      print('First text field: $input');
                      var numTry = int.tryParse(input);
                      if (numTry == null) {
                        print('すうちいれろ');
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text("数値を入力してください"),
                              content: Text("数値以外が入力されました。修正してください。"),
                              actions: <Widget>[
                                ElevatedButton(
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
                      for (int i = 0; i < products.length; i++) {
                        print(products[i].id);
                        if (products[i].id == id) {
                          print('これじゃね？${products[i].name}');
                          products[i].quantity = numTry;
                          // setState(() {});
                        }
                      }
                    },
                  )),
              // Icon(Icons.cancel)
              IconButton(onPressed: () {}, icon: Icon(Icons.plus_one)),
              IconButton(
                onPressed: () {
                  _deleteitem(id);
                },
                icon: Icon(Icons.cancel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
