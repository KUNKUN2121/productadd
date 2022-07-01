import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'RegisterPost.dart';

class ProductAdd extends StatelessWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barcode = ModalRoute.of(context)?.settings.arguments;
    if (barcode == null) {}
    print(barcode);
    return Scaffold(
      appBar: AppBar(
        title: Text('商品登録'),
      ),
      body: Stack(children: [
        Center(
            child: Column(
          children: [
            Text('商品登録'),
            Text('名前設定'),
            Text('写真選択'),
            Text('${barcode}'),
            ElevatedButton(
              child: Text('続行する'),
              onPressed: () {
                Future<int> go = Register.registerPost('test', 2525);
                go.then((value) {
                  print("get ${value}");
                  int aa = value;
                });
                //Navigator.of(context).pushNamed("/MainAddPage");
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ProductAdd()));
                print('LOG:RegisterPage続行');
              },
            ),
          ],
        )),
      ]),
    );
  }
}
