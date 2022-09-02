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
                      child: Text('戻る'),
                    ),
                    ElevatedButton(
                      child: Text('続行する'),
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
                                    ElevatedButton(
                                        child: Text("閉じる"),
                                        onPressed: () {
                                          Navigator.popUntil(context,
                                              (route) => route.isFirst);
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
                                    ElevatedButton(
                                        child: Text("閉じる"),
                                        onPressed: () {
                                          Navigator.popUntil(context,
                                              (route) => route.isFirst);
                                        }),
                                  ],
                                );
                              },
                            );
                          }
                          print(value);
                        });
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
      //key: key,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 100.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              SizedBox(
                height: 50,
                width: 50,
                child: Text('${quantity}'),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.cancel)),
            ],
          ),
        ),
      ),
    );
  }
}
