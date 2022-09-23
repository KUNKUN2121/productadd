import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:productadd/src/pages/AddPages/ConfirmPage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../model/Barcode.dart';
import '../RegisterPages/NewAddPage.dart';
import '../../api/boolProduct.dart';
import 'package:productadd/main.dart';

///[products]初期化
List<Barcode> products = [];

///[products]の個数を記録しておくやつ。
int productsindex = 0;

class MainAddPage extends StatefulWidget {
  @override
  _MainAddPageState createState() => _MainAddPageState();
}

class _MainAddPageState extends State {
  bool _isLoading = false;

  ///qrCode初期化
  String qrCode = '0';

//imgURL初期化
  String productURL = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '入荷処理',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: HexColor('ea2f46'),
      ),
      body: Stack(
        children: [
          //スライドウィンド
          Column(
            children: <Widget>[
              SizedBox(
                height: 100.0,
                child: Center(
                  child: ElevatedButton(
                    child: Text(
                      'スキャン',
                      style: TextStyle(fontSize: 30),
                    ),
                    onPressed: () async {
                      await scanQrCode();
                      print('OK??2');
                    },
                  ),
                ),
              ),

              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0; i < products.length; i++) ...{
                      addListCard(
                        title: products[i].name,
                        barcode: products[i].barcode,
                        quantity: products[i].quantity,
                        imgURL: products[i].imgURL,
                        id: products[i].id,
                      )
                    },
                    // Text('hello'),
                  ],
                ),
              ),
              //ボタン参照
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: Container(
              //     margin: const EdgeInsets.only(
              //       top: 20,
              //       left: 10,
              //       right: 10.0,
              //     ),
              //     child: ElevatedButton(
              //       onPressed: () {
              //         if (products.length == 0) {
              //           return;
              //         }
              //         Navigator.of(context).pushNamed("/ConfirmPage");
              //       },
              //       child: const Text('続行する'),
              //     ),
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        products = [];
                        setState(() {});
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(HexColor('ea2f46')),
                      ),
                      child: const Text(
                        'クリア',
                        style: TextStyle(
                            // color: Color.fromARGB(255, 128, 3, 3),
                            fontSize: 25),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          // primary: HexColor('ea2f46'), //背景色
                          ),
                      onPressed: () {
                        if (products.length == 0) {
                          return;
                        }
                        Navigator.of(context).pushNamed("/ConfirmPage");
                      },
                      child: const Text('続行', style: TextStyle(fontSize: 25)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isLoading)
            const Opacity(
              opacity: 0.7,
              child: ModalBarrier(
                dismissible: false,
                color: Colors.black,
              ),
            ),
          if (_isLoading) const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }

  Future scanQrCode() async {
    setState(() {
      _isLoading = true;
    });
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
      '#EB394B',
      'キャンセル',
      false,
      ScanMode.BARCODE,
    );
    if (!mounted) return;
    setState(() {
      this.qrCode = qrCode;
    });
    if (qrCode == '-1') {
      return;
    }

    /// [products]に同じのがあったらreturn
    for (int i = 0; i < products.length; i++) {
      if (qrCode == products[i].barcode) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("同じ商品が読み込まれています。"),
              content: Text(
                  "この商品はすでに読み込まれています。\n読み込み一覧を確認してください。\n商品名 : ${products[i].name}\nコード ${qrCode}"),
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
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }
    final go = boolProduct(qrCode);
    go.then((value) async {
      print(value);
      // データベースあり
      if (value == true) {
        await Navigator.of(context).pushNamed("/AddPage2",
            arguments: QrCodeQuantity(qrcode: qrCode, quantity: 0));
        print('OK1??');
      }
      // エラー
      if (value == null) {
        print('エラー');
      }
      // データベースに存在しない
      if (value == false) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("この商品は登録されていません。"),
              content: Text("この商品は登録されていません。登録処理をしてください\nコード ${qrCode}"),
              actions: <Widget>[
                // ボタン領域
                ElevatedButton(
                    child: Text("キャンセル"),
                    onPressed: () => Navigator.pop(context)),
                ElevatedButton(
                    child: Text("登録"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushNamed("/ProductAdd", arguments: qrCode);
                    }),
              ],
            );
          },
        );
      }

      setState(() {
        _isLoading = false;
      });
    });
  }

  Card addListCard({
    required String title,
    required String barcode,
    required int quantity,
    required String imgURL,
    required int id,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 120.0),
          ///////
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  child: Row(
                    children: [
                      // 商品画像画像
                      Container(
                        width: 55,
                        height: 55,
                        child: Image.network(imgURL),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      // 商品名バーコード
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                // softWrap: false,
                              ),
                              Text(
                                barcode,
                                softWrap: true,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 個数 変更ボタン
              Align(
                alignment: Alignment.bottomCenter, //右寄せの指定
                child: Container(
                  alignment: Alignment.centerRight,
                  // color: Colors.green,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '${quantity}',
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              // color: Colors.blue,
                              child: Text(
                                '個',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        child: Text('変更'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          for (int i = 0; i < products.length; i++) {
                            if (products[i].barcode == barcode) {
                              await Navigator.of(context).pushNamed(
                                "/AddPage2",
                                arguments: QrCodeQuantity(
                                    qrcode: products[i].barcode,
                                    quantity: products[i].quantity),
                              );
                              setState(() {});
                            } else {
                              print('error');
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
