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
  //barnum = 前の画面から
  //quantity = 0だよね追加だから
  var _itemname = TextEditingController();
  var _category = TextEditingController();
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
      String category = _category.text;
      String price = _price.text;
      Future<int> go = Register.registerPost(
          item, barcode.toString(), category, price, tempimg);
      go.then((value) {
        print("れすぽんすこーど ${value}");
        int responsecode = value;
      });
      //Navigator.of(context).pushNamed("/MainAddPage");
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
              Text('${barcode}'),
              Text('商品名'),
              TextField(
                // controller: TextEditingController(text: '${quantity}'),
                controller: _itemname,
              ),
              Text('カテゴリー'),
              TextField(
                // controller: TextEditingController(text: '${quantity}'),
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                controller: _category,
              ),
              Text('価格'),
              TextField(
                // controller: TextEditingController(text: '${quantity}'),
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                controller: _price,
              ),

              ///https://flutter.keicode.com/basics/textcontroller.php

              ElevatedButton(
                child: Text('撮影'),
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
                  print('LOG:RegisterPage続行');
                },
              ),

              ElevatedButton(
                  child: Text('続行する'),
                  onPressed: () {
                    if (imgFlg == false) {
                      print('imgflg');
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text("画像が撮影されていません。"),
                            content: Text("NO IMAGEで続行しますか？"),
                            actions: <Widget>[
                              FlatButton(
                                  child: Text("続行"),
                                  onPressed: () {
                                    imgFlg == true;
                                  }),
                              FlatButton(
                                  child: Text("キャンセル"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ],
                          );
                        },
                      );
                      registerPost();
                      return;
                    }
                    registerPost();
                  }),
              // ElevatedButton(
              //   child: Text('続行'),
              //   onPressed: () {
              //     Future<int> go = Register.registerPost('test', 2525, _image);
              //   },
              // ),
            ],
          )),
        ]),
      ),
    );
  }
}
