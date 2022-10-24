// import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:productadd/main.dart';
import 'dart:convert';
import 'dart:io';

import 'package:productadd/src/model/Barcode.dart';

class Change {
  final int barcode;
  final String name;
  Change({
    required this.name,
    required this.barcode,
  });

  static Future<int> changePostQuantity(String barnum, String quantity) async {
    // 設定
    String url = apiURL + "changePostQuantity.php";
    // String url = testURL + "changePostQuantity.php";
    print(url);
    try {
      var resp = await http.post(Uri.parse(url), body: {
        'barnum': barnum,
        'quantity': quantity,
      });

      if (resp.statusCode != 200) {
        print('RegisterPost Error Code : ${resp.statusCode}');
        return resp.statusCode;
      }
      print('レスポンスOK');
      return 200;
    } catch (e) {
      print(e);
      return 500;
    }
  }
}