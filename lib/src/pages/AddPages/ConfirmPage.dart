import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:productadd/src/pages/AddPages/Complete.dart';
import '../../model/Barcode.dart';
import '../../api/Post.dart';
import 'package:productadd/src/pages/AddPages/AddPage.dart';
import 'package:productadd/src/pages/AddPages/ConfirmPage.dart';

class ConfirmPage extends StatelessWidget {
  // final List<Barcode> products;
  const ConfirmPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('確認画面', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 255, 238, 87),
      ),
      body: Stack(children: [
        Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              child: Text(
                '下記を追加します',
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
                        print('戻るボタン');
                        Navigator.of(context).pop();
                      },
                      child: Text('戻る', style: TextStyle(fontSize: 25)),
                    ),
                    ElevatedButton(
                      child: Text(
                        '追加',
                        style: TextStyle(fontSize: 25),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text("本当に追加しますか？"),
                              content: Text(
                                "追加をタップすると在庫追加します。",
                                style: TextStyle(fontSize: 15),
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // ボタン領域
                                    ElevatedButton(
                                        child: Text("キャンセル"),
                                        onPressed: () =>
                                            Navigator.pop(context)),
                                    ElevatedButton(
                                      child: Text(
                                        "追加する",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      onPressed: () {
                                        final go =
                                            PostRequest.postMethod(products);
                                        go.then(
                                          (value) {
                                            if (value == 0) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CompletePage()),
                                              );
                                              return;
                                            }
                                            if (value != 0) {
                                              showDialog(
                                                //画面外の部分を押せないようにする。
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                    title: Text("エラー"),
                                                    content: Text(
                                                        "エラーが発生しました。最初からやり直してください。\n ErrorCode: ${value}"),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                          child: Text("閉じる"),
                                                          onPressed: () {
                                                            Navigator.popUntil(
                                                                context,
                                                                (route) => route
                                                                    .isFirst);
                                                          }),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                            print(value);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ]),
            )
          ],
        )
      ]),
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
