import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:productadd/src/pages/ConfirmPage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../model/Barcode.dart';
import '../RegisterPages/NewAddPage.dart';

///[products]初期化
List<Barcode> products = [];

///[products]の個数を記録しておくやつ。
int productsindex = 0;

class MainAddPage extends StatefulWidget {
  @override
  _MainAddPageState createState() => _MainAddPageState();
}

class _MainAddPageState extends State {
  ///qrCode初期化
  String qrCode = '0';

//imgURL初期化
  String productURL = '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('入荷処理'),
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
                    onPressed: () => scanQrCode(),
                  ),
                ),
              ),
              Expanded(
                child: ListView(children: [
                  for (int i = 0; i < products.length; i++) ...{
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
    // addProductContents(qrCode);
    await Navigator.of(context).pushNamed(
      "/AddPage2",
      arguments: QrCodeQuantity(qrcode: qrCode, quantity: 0),
    );
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
          constraints: const BoxConstraints(minHeight: 120.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 55,
                height: 55,
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
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                    ),
                    Text(
                      barcode,
                      softWrap: true,
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: Container(
                    alignment: Alignment.center,
                    // color: Colors.green[50],
                    child: Text(
                      '${quantity}',
                      style: TextStyle(fontSize: 40),
                    )),
              ),
              SizedBox(
                height: 30,
                width: 20,
                child: Container(
                    // color: Colors.red,
                    child: Text(
                  '個',
                  style: TextStyle(fontSize: 20),
                )),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  print(id);
                  print(products[id].name);
                  await Navigator.of(context).pushNamed(
                    "/AddPage2",
                    arguments: QrCodeQuantity(
                        qrcode: products[id].barcode,
                        quantity: products[id].quantity),
                  );
                  setState(() {});
                },
                child: Text('変更'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
