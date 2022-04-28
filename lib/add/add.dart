import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  String qrCode = '0';
  String productURL = '';
  @override
  Widget build(BuildContext context) {
    final String productURL =
        'https://tech.ru-kun.net/upload/up/' + qrCode + '.jpg';
    return Scaffold(
      appBar: AppBar(
        title: Text('バーコードスキャン'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: NetworkImage(productURL)),
            Text(
              '$qrCode',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('スキャン'),
              onPressed: () => scanQrCode(),
            ),
            SizedBox(height: 10),
            Text('個数 X個 ＋'),
            //Card
          ],
        ),
      ),
    );
  }

  Future scanQrCode() async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
      '#EB394B',
      'キャンセル',
      true,
      ScanMode.BARCODE,
    );
    if (!mounted) return;

    setState(() {
      this.qrCode = qrCode;
      this.productURL = qrCode;
    });
  }
}
