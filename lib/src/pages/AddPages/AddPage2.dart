import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productadd/src/api/RegisterPost.dart';
import 'package:provider/provider.dart';

import 'package:productadd/src/pages/AddPages/AddPage.dart';
import 'package:productadd/src/model/Barcode.dart';

class AddPage2 extends StatefulWidget {
  //const AddPage2({Key? key}) : super(key: key);
  @override
  State<AddPage2> createState() => _AddPage2State();
}

Future<Barcode> productInfoClass(String barcode) async {
  Barcode Productinfo = await Barcode.addProduct(barcode, -1);
  // await new Future.delayed(new Duration(seconds: 3));
  return Productinfo;
}

///

class _AddPage2State extends State<AddPage2> {
  ///
  // String tempimg = "https://jmva.or.jp/wp-content/uploads/2018/07/noimage.png";
  String noimage = 'https://jmva.or.jp/wp-content/uploads/2018/07/noimage.png';

  @override
  Widget build(BuildContext context) {
    final barcode = ModalRoute.of(context)?.settings.arguments.toString();
    // final go = productInfoClass(barcode!);
    // go.then((value) {
    //   productName = value.name;
    //   productImg = value.imgURL;
    //   print('hey1');
    //   setState(() {});
    // });

    if (barcode == null) {}

    print(barcode! + 'a');
    return Scaffold(
      appBar: AppBar(
        title: Text('AddPage2'),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),

                /// 商品名
                FutureBuilder(
                  future: productInfoClass(barcode),
                  builder:
                      (BuildContext context, AsyncSnapshot<Barcode> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('エラーが発生しました。' + snapshot.error.toString()),
                      );
                    }
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.name,
                        style: TextStyle(fontSize: 30),
                      );
                    } else {
                      return Text("エラーが発生しました。",
                          style: TextStyle(fontSize: 30));
                    }
                  },
                ),
                Text(
                  '${barcode}',
                  style: TextStyle(fontSize: 20),
                ),

                /// 画像
                Container(
                  height: 200,
                  child: FutureBuilder(
                    future: productInfoClass(barcode),
                    builder: (BuildContext context,
                        AsyncSnapshot<Barcode> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child:
                              Text('エラーが発生しました。' + snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasData) {
                        return Image.network(
                          snapshot.data!.imgURL,
                        );
                      } else {
                        return const Text('エラーが発生しました。');
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('-10')),
                    ElevatedButton(onPressed: () {}, child: Text('-1')),
                    Container(
                      width: 100,
                      child: TextField(
                        // controller: TextEditingController(text: '${quantity}'),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        controller: TextEditingController(text: "45"),

                        /// デコレーション
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('+1')),
                    ElevatedButton(onPressed: () {}, child: Text('+10')),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
////////

                /// 登録画面

                ElevatedButton(
                  child: Text(
                    "登録確認",
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    addProductContents(barcode);
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Future addProductContents(String addqrcode) async {
    Barcode addProduct = await Barcode.addProduct(addqrcode, productsindex);
    print(productsindex);

    /// [products]に同じのがあったらreturn
    for (int i = 0; i < products.length; i++) {
      if (addProduct.barcode == products[i].barcode) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("同じ商品が読み込まれています。"),
              content: Text(
                  "この商品はすでに読み込まれています。\n読み込み一覧を確認してください。\n商品名 : ${products[i].name}\nコード ${addProduct.barcode}"),
              actions: <Widget>[
                ElevatedButton(
                    child: Text("閉じる"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            );
          },
        );
        return;
      }

      ///同じ商品だったらreturn
    }
    if (addProduct.price == -400) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("この商品は登録されていません。"),
            content:
                Text("この商品は登録されていません。登録処理をしてください\nコード ${addProduct.barcode}"),
            actions: <Widget>[
              // ボタン領域
              ElevatedButton(
                  child: Text("キャンセル"),
                  onPressed: () => Navigator.pop(context)),
              ElevatedButton(
                  child: Text("登録"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed("/ProductAdd",
                        arguments: addProduct.barcode);
                  }),
            ],
          );
        },
      );
      return;
    }
    // ここで追加
    print(addProduct);
    productsindex++;
    //products.add(addProduct);
    products.insert(0, addProduct);
    Navigator.of(context).pop();
  }
}
