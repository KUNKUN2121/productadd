import 'package:flutter/material.dart';
import 'package:productadd/src/pages/AddPages/AddPage.dart';

class CompletePage extends StatelessWidget {
  // final List<Barcode> products;
  const CompletePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.green[100], // 背景色設定
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: const Text('登録完了', style: TextStyle(color: Colors.black)),
        //   backgroundColor: Color.fromARGB(255, 99, 255, 130),
        // ),
        body: Stack(children: [
          Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Container(
                child: Text(
                  '登録完了しました！',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(height: 20),
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
              ElevatedButton(
                onPressed: () {
                  products = [];
                  print('戻るボタン');
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text('ホームに戻る', style: TextStyle(fontSize: 25)),
              ),
              SizedBox(
                height: 50,
              )
            ],
          )
        ]),
      ),
    );
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
                  color: Colors.green[50],
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
