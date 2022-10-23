import 'package:http/http.dart' as http;
import 'package:productadd/main.dart';
import 'dart:convert';
import 'dart:io';

import 'package:productadd/src/model/Barcode.dart';

class Change {
  final int barcode;
  final int quantity;
  Change({
    required this.quantity,
    required this.barcode,
  });

  static Future<int> changePostQuantity(
    int barnum,
    int quantity,
  ) async {
    // 設定
    String url = apiURL + "changePostQuantity.php";
    try {
      var resp = await http.post(Uri.parse(url), body: {
        'barnum': barnum,
        'quantity': quantity,
      });

      if (resp.statusCode != 200) {
        print('RegisterPost Error Code : ${resp.statusCode}');
        return resp.statusCode;
      }
      // print(resp.body);
      print('レスポンスOK');
      return 200;
    } catch (e) {
      print(e);
      return 500;
    }
  }

  static Future<int> changePostMore(
    int barnum,
    int quantity,
  ) async {
    // 設定
    String url = apiURL + "changePost.php";
    try {
      var resp = await http.post(Uri.parse(url), body: {
        'barnum': barnum,
        'quantity': quantity,
      });

      if (resp.statusCode != 200) {
        print('RegisterPost Error Code : ${resp.statusCode}');
        return resp.statusCode;
      }
      // print(resp.body);
      print('レスポンスOK');
      return 200;
    } catch (e) {
      print(e);
      return 500;
    }
  }
}
