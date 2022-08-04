import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:productadd/src/model/Barcode.dart';

class RegisterImage {
  final int barcode;
  final String name;
  RegisterImage({
    required this.name,
    required this.barcode,
  });

  static Future<String> registerImagePost(File uploadimage) async {
    // 設定
    String url = "https://store-project.f5.si/develop/base.php";
    List regierstItem = [];

    try {
      ///[registerpost] を Json に変換

      //画像変換
      List<int> imageBytes = uploadimage.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);

      var resp = await http.post(Uri.parse(url), body: {
        'image': baseimage,
      });

      if (resp.statusCode != 200) {
        print('RegisterPost Error Code : ${resp.statusCode}');
        return '${resp.statusCode}';
      }

      // print(resp.body);
      print('レスポンスOK');
      Map<String, dynamic> data = jsonDecode(resp.body);
      String imgurl = data["msg"];
      print(imgurl);
      return imgurl;
    } catch (e) {
      print(e);
      return '500';
    }
  }
}
