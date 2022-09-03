import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productadd/src/api/RegisterPost.dart';

import 'package:productadd/src/pages/AddPages/AddPage.dart';
import 'package:productadd/src/model/Barcode.dart';

class AddPage2 extends StatefulWidget {
  //const AddPage2({Key? key}) : super(key: key);
  @override
  State<AddPage2> createState() => _AddPage2State();
}

class _AddPage2State extends State<AddPage2> {
  ///
  /// カテゴリー変更の際は
  ///

  ///
  ///

  int count = 10;
  int? isSelectedCategory = 1;
  //barnum = 前の画面から
  //quantity = 0だよね追加だから
  var _itemname = TextEditingController();
  var _price = TextEditingController();
  File _image = File("");
  final picker = ImagePicker();
  var imgFlg = false;
  String tempimg = "https://jmva.or.jp/wp-content/uploads/2018/07/noimage.png";

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        try {
          _image = File(pickedFile.path);
          imgFlg = true;
        } catch (e) {
          imgFlg = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final objbarcode = ModalRoute.of(context)?.settings.arguments;
    final barcode = ModalRoute.of(context)?.settings.arguments.toString();
    if (barcode == null) {}

    registerPost() {
      String item = _itemname.text;
      String category = isSelectedCategory.toString();
      String price = _price.text;
      Future<int> go = Register.registerPost(
          item, barcode.toString(), category, price, tempimg);
      go.then((value) {
        print("れすぽんすこーど ${value}");
        int responsecode = value;
        if (value == 200) {
          showDialog(
            //画面外の部分を押せないようにする。
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Text("追加しました"),
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                // Navigator.of(context).pushNamed("/MainAddPage");
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Text('閉じる')),
                        ],
                      )
                    ],
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            //画面外の部分を押せないようにする。
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Text("エラーが発生しました、"),
                children: [
                  Column(
                    children: [
                      Column(
                        children: [Text('現在登録することができません。errorcode{$value}')],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                // Navigator.of(context).pushNamed("/MainAddPage");
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Text('閉じる')),
                        ],
                      )
                    ],
                  ),
                ],
              );
            },
          );
        }
      });

      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => AddPage2()));
      print('LOG:RegisterPage続行');
    }

    print(barcode);
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
                Text(
                  'ここに商品名',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  '${barcode}',
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  height: 200,
                  child: Image.network(tempimg),
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

                /// 登録画面

                ElevatedButton(
                  child: Text(
                    "登録確認",
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    addProductContents(barcode!);
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
