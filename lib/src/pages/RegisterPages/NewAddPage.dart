import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:productadd/src/api/RegisterPost.dart';
import 'package:productadd/src/api/RegisterPostImage.dart';

class RegisterItemPage extends StatefulWidget {
  //const registerItemPage({Key? key}) : super(key: key);
  @override
  State<RegisterItemPage> createState() => _RegisterItemPageState();
}

class _RegisterItemPageState extends State<RegisterItemPage> {
  ///
  /// カテゴリー変更の際は
  ///[isSelectedCategoryName]と[DropdownButton]を変更してください
  ///
  List<String> isSelectedCategoryName = ["ドリンク", "おにぎり", "ぱん", "筆記用具", "その他"];

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
    final barcode = ModalRoute.of(context)?.settings.arguments;
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
      //     MaterialPageRoute(builder: (context) => registerItemPage()));
      print('LOG:RegisterPage続行');
    }

    print(barcode);
    return Scaffold(
      appBar: AppBar(
        title: Text('商品登録'),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Center(
            child: Column(
              children: [
                Text('商品登録'),
                Container(
                  height: 200,
                  child: Image.network(tempimg),
                ),
                ElevatedButton(
                  child: Text(
                    '商品写真を撮影',
                    style: TextStyle(fontSize: 20),
                  ),
                  // onPressed: getImage,
                  onPressed: () async {
                    await getImage();
                    // カメラキャンセルしたさいにreturn
                    if (imgFlg == false) {
                      return;
                    }
                    Future<String> go = RegisterImage.registerImagePost(_image);
                    go.then((value) {
                      print("れすぽんすこーど ${value}");
                      String responsecode = value;
                      tempimg = value;
                      setState(() {});
                    });
                    print('LOG:カメラ撮影');
                  },
                ),
                Text(
                  'コード : ${barcode}',
                  style: TextStyle(fontSize: 20),
                ),

                /// 商品名

                TextField(
                    controller: _itemname,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.edit),
                      labelText: '商品名',
                    )),

                /// 価格

                TextField(
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    controller: _price,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.currency_yen),
                      labelText: '販売価格',
                    )),

                /// カテゴリー

                Text('カテゴリー'),
                // TextField(
                //   // controller: TextEditingController(text: '${quantity}'),
                //   keyboardType: TextInputType.numberWithOptions(
                //       signed: true, decimal: true),
                //   controller: _category,
                // ),
                DropdownButton(
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                  items: const [
                    DropdownMenuItem(
                      child: Text('ドリンク'),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text('おにぎり'),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text('パン'),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text('筆記用具'),
                      value: 4,
                    ),
                    DropdownMenuItem(
                      child: Text('その他'),
                      value: 5,
                    ),
                  ],
                  //6
                  onChanged: (int? value) {
                    print(value);
                    setState(() {
                      isSelectedCategory = value;
                    });
                  },
                  //7
                  value: isSelectedCategory,
                ),

                ///https://flutter.keicode.com/basics/textcontroller.php
                ///

                ElevatedButton(
                    child: Text(
                      "登録確認",
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: () {
                      showDialog(
                        //画面外の部分を押せないようにする。
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: Text("以下の商品を登録します。"),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Image.network(tempimg),
                                    Row(
                                      children: [
                                        Text('商品名：',
                                            style: TextStyle(fontSize: 17)),
                                        Flexible(
                                          child: Text(
                                            _itemname.text,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('バーコード：',
                                            style: TextStyle(fontSize: 17)),
                                        Text(barcode.toString(),
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('カテゴリー：',
                                            style: TextStyle(fontSize: 17)),
                                        Text(
                                            isSelectedCategoryName[
                                                isSelectedCategory! - 1],
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('価格設定：',
                                            style: TextStyle(fontSize: 17)),
                                        Text("¥" + _price.text,
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('閉じる')),
                                        ElevatedButton(
                                            onPressed: () {
                                              registerPost();
                                            },
                                            child: Text('続行する')),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
