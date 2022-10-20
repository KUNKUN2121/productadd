import 'package:http/http.dart' as http;
import 'package:productadd/main.dart';
import 'dart:convert';
import 'dart:io';

import 'package:productadd/src/model/Barcode.dart';

class Register {
  final int barcode;
  final String name;
  Register({
    required this.name,
    required this.barcode,
  });

  static Future<int> registerPost(String itemname, String barnum,
      String category, String price, String uploadimage) async {
    // 設定
    String url = apiURL + "register.php";
    List regierstItem = [];

    try {
      var resp = await http.post(Uri.parse(url), body: {
        'itemname': itemname,
        'barnum': barnum,
        'quantity': '0',
        'category': category,
        'price': price,
        'image': uploadimage,
      });

      if (resp.statusCode != 200) {
        print('RegisterPost Error Code : ${resp.statusCode}');
        return resp.statusCode;
      }
      // print(resp.body);
      print('レスポンスOK');
      print(uploadimage);
      return 200;
    } catch (e) {
      print(e);
      return 500;
    }
  }
}
