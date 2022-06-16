import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'Barcode.dart';
import 'Post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class OldAdd extends StatefulWidget {
  @override
  _OldAddState createState() => _OldAddState();
}

class _OldAddState extends State {
  List<Barcode> products = [
    // Barcode(
    //   name: 'コーラ',
    //   barcode: '4902102072618',
    //   imgURL: 'https://sm.r10s.jp/item/31/4902102073431.jpg',
    //   price: '200',
    //   category: 'hello',
    //   //key: const Key("product-1"),
    // ),
    // Barcode(
    //   name: 'ファンタ',
    //   barcode: 2,
    //   imgURL: 'https://sm.r10s.jp/item/31/4902102073431.jpg',
    //   Price: 200,
    //   Category: 'hello',
    //   //key: const Key("product-2"),
    // ),
    // Barcode(
    //   name: 'iPhone',
    //   barcode: '3',
    //   imgURL:
    //       'https://network.mobile.rakuten.co.jp/assets/img/product/iphone/iphone-13-pro/pht-device-16.png?220309-01',
    //   price: '200',
    //   category: 'hello',
    //   //key: const Key("product-3"),
    // ),
  ];
  var postBarcode = [];
  String qrCode = '0';
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
                SizedBox(height: 10),
                Text('個数 X個 ＋'),
                getCard(
                  title: "商品１",
                  description: "00000000000000",
                  icon: Icons.cake_outlined,
                  key: const Key("product-0"),
                  onPressed: () {},
                ),
                ElevatedButton(
                  onPressed: () async {
                    /* ボタンがタップされた時の処理 */
                    products.add(await Barcode.addProduct(4549131970258));
                    print(products);
                    setState(() {});
                  },
                  child: Text('click here'),
                )
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
                      child: Text("件読み込みました"),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: products.map((productsloop) {
                        return Column(
                          children: [
                            testCard(
                              title: '${productsloop.name}',
                              description: '${productsloop.barcode}',
                              imgURL: '${productsloop.imgURL}',
                              //key: Key('${productsloop.key}'),
                              //icon: Icons.abc
                            ),
                          ],
                        );
                      }).toList(),
                    ),
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
  void _request() async {
    String url = "https://httpbin.org/post";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({'name': 'moke'});

    http.Response resp =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (resp.statusCode != 200) {
      // setState(() {
      //   int statusCode = resp.statusCode;
      //   _content = "Failed to post $statusCode";
      // });
      print('ok');
      return;
    }
    print('222');
    print(resp.body);
    // setState(() {
    //   _content = resp.body;
    // });
  }

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
            print('aaa');
            _request();
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
    postBarcode.add(qrCode);
    products.add(await Barcode.addProduct(qrCode));
    setState(() {});
  }
}

Card getCard({
  required String title,
  required String description,
  required IconData icon,
  required Key key,
  required Function()? onPressed,
}) {
  return Card(
    key: key,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 100.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50.0,
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
                    description,
                    softWrap: true,
                  ),
                  const Divider(),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: OutlinedButton(
                  //     //参考：https://zenn.dev/enoiu/articles/6b754d37d5a272#elevatedbutton%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6
                  //     style: ElevatedButton.styleFrom(
                  //       onPrimary: Theme.of(context).colorScheme.onPrimary,
                  //       primary: Theme.of(context).colorScheme.primary,
                  //     ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  //     onPressed: onPressed,
                  //     child: const Text("開く"),
                  //   ),
                  // )
                ],
              ),
            ),
            Text("個数"),
            Icon(Icons.cancel)
          ],
        ),
      ),
    ),
  );
}

Card testCard({
  required String title,
  required String description,
  //required IconData icon,
  required String imgURL,
  //required Key key,
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
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                  Text(
                    description,
                    softWrap: true,
                  ),
                  const Divider(),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: OutlinedButton(
                  //     //参考：https://zenn.dev/enoiu/articles/6b754d37d5a272#elevatedbutton%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6
                  //     style: ElevatedButton.styleFrom(
                  //       onPrimary: Theme.of(context).colorScheme.onPrimary,
                  //       primary: Theme.of(context).colorScheme.primary,
                  //     ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  //     onPressed: onPressed,
                  //     child: const Text("開く"),
                  //   ),
                  // )
                ],
              ),
            ),
            Text("個数"),
            Icon(Icons.cancel)
          ],
        ),
      ),
    ),
  );
}
