import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'Barcode.dart';
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
    Barcode(
      name: 'コーラ',
      barcode: 4902102072618,
      imgURL: 'https://sm.r10s.jp/item/31/4902102073431.jpg',
      Price: 200,
      Category: 'hello',
      //key: const Key("product-1"),
    ),
    Barcode(
      name: 'ファンタ',
      barcode: 2,
      imgURL: 'https://sm.r10s.jp/item/31/4902102073431.jpg',
      Price: 200,
      Category: 'hello',
      //key: const Key("product-2"),
    ),
    Barcode(
      name: 'iPhone',
      barcode: 3,
      imgURL:
          'https://network.mobile.rakuten.co.jp/assets/img/product/iphone/iphone-13-pro/pht-device-16.png?220309-01',
      Price: 200,
      Category: 'hello',
      //key: const Key("product-3"),
    ),
  ];

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
                // Container(
                //     width: 200,
                //     child: TextField(
                //       //入力情報取得
                //       onSubmitted: (value) async {
                //         print(value);

                //         products.add(await Barcode.addProduct(4549131970258));

                //         setState(() {});
                //       },
                //       //キーボード数字
                //       keyboardType: TextInputType.number,
                //       //後ろの文字
                //       decoration: InputDecoration(hintText: '郵便番号入力'),
                //     )),
                ElevatedButton(
                  onPressed: () async {
                    /* ボタンがタップされた時の処理 */
                    products.add(await Barcode.addProduct(4549131970258));
                  },
                  child: Text('click here'),
                )
              ],
            ),
          ),
          //スライドウィンド
          SlidingUpPanel(
            panel: Column(
              children: [
                Column(
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
                  }).toList(), //リストにするよ。
                ),
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
