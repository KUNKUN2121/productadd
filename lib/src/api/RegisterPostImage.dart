import 'package:http/http.dart' as http;
import 'package:productadd/main.dart';
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
    print('写真アップロード');
    // 設定
    // String url = apiURL + "square.php";
    String url = "https://store-project.f5.si/database/api/square.php";

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
        return 'error_${resp.statusCode}';
      }

      // print(resp.body);
      print('レスポンスOK');
      Map<String, dynamic> data = jsonDecode(resp.body);
      String imgurl = data["msg"];
      print(imgurl);
      return imgurl;
    } catch (e) {
      print(e);
      return 'error_500';
    }
  }
}
