import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:productadd/src/api/RegisterPost.dart';

class RegisterItemPage extends StatefulWidget {
  //const registerItemPage({Key? key}) : super(key: key);
  @override
  State<RegisterItemPage> createState() => _RegisterItemPageState();
}

class _RegisterItemPageState extends State<RegisterItemPage> {
  File _image = File("");
  final picker = ImagePicker();
  var imgFlg = false;

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
                // 参考 https://minpro.net/future-value
                Future<int> go = Register.registerPost('test', 2525, _image);
                go.then((value) {
                  print("れすぽんすこーど ${value}");
                  int responsecode = value;
                });
                //Navigator.of(context).pushNamed("/MainAddPage");
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => registerItemPage()));
                print('LOG:RegisterPage続行');
              },
            ),
            ElevatedButton(
              child: Text('撮影'),
              onPressed: getImage,
            ),
            ElevatedButton(
              child: Text('decode'),
              onPressed: () {
                List<int> imageBytes = _image.readAsBytesSync();
                String baseimage = base64Encode(imageBytes);
                print("OK");
                log(baseimage);
                print("OK");
              },
            ),
            // ElevatedButton(
            //   child: Text('続行'),
            //   onPressed: () {
            //     Future<int> go = Register.registerPost('test', 2525, _image);
            //   },
            // ),
          ],
        )),
      ]),
    );
  }
}
