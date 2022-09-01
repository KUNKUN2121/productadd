import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import '../model/Barcode.dart';
import '../api/boolProduct.dart';

class NewAddPage extends StatefulWidget {
  @override
  _NewAddPageState createState() => _NewAddPageState();
}

class _NewAddPageState extends State {
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
        title: Text('新商品の追加'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  child: Text('スキャン'),
                  onPressed: () => scanQrCode(),
                ),
                SizedBox(height: 20),
              ],
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
    final go = boolProduct(qrCode);
    go.then((value) {
      print(value);
      // 既存のものなし
      if (value == false) {
        Navigator.of(context).pushNamed("/ProductAdd", arguments: qrCode);
      }
      // 既存のものあり
      if (value == true) {
        print('追加済みの商品');
      }
      // エラー
      if (value == null) {
        print('エラー');
      }
      return;
    });
  }
}
