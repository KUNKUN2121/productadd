import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../model/Barcode.dart';
import '../api/Post.dart';

class ConfirmPage extends StatelessWidget {
  final List<Barcode> products;
  const ConfirmPage({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('確認画面'),
      ),
      body: Stack(children: [
        Column(
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     print('aa');
            //     print(products.first.barcode);
            //   },
            //   child: Text('テスト追加'),
            // ),
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
              child: Row(children: [
                ElevatedButton(
                  onPressed: () {
                    print('戻るボタン');
                  },
                  child: Text('戻る'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final go = PostRequest.postMethod(products);
                    go.then((value) {
                      if (value == 0) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text("在庫追加完了"),
                              content: Text("在庫追加完了しました。\n メインページに戻ります。"),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text("閉じる"),
                                    onPressed: () {
                                      Navigator.popUntil(
                                          context, (route) => route.isFirst);
                                    }),
                              ],
                            );
                          },
                        );
                        return;
                      }
                      if (value != 0) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text("エラー"),
                              content: Text(
                                  "エラーが発生しました。最初からやり直してください。\n ErrorCode: ${value}"),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text("閉じる"),
                                    onPressed: () {
                                      Navigator.popUntil(
                                          context, (route) => route.isFirst);
                                    }),
                              ],
                            );
                          },
                        );
                      }
                      print(value);
                    });
                  },
                  child: Text('続行'),
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
                child: Text('${quantity}'),
                // child: TextField(
                //   keyboardType: TextInputType.numberWithOptions(
                //       signed: true, decimal: true),
                //   controller: TextEditingController(text: '${quantity}'),
                // ),
              ),
              // Icon(Icons.cancel)
              IconButton(onPressed: () {}, icon: Icon(Icons.cancel)),
            ],
          ),
        ),
      ),
    );
  }
}
