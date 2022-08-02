import 'package:http/http.dart' as http;
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

  static Future<int> registerPost(
      String itemName, int barcode, File uploadimage) async {
    // 設定
    String url = "https://store-project.f5.si/database/api/register.php";
    List regierstItem = [];

    try {
      ///[registerpost] を Json に変換

      //画像変換
      List<int> imageBytes = uploadimage.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      //
      regierstItem.add([itemName, barcode]);
      String jsonBarcode = jsonEncode(regierstItem);
      Map<String, String> headers = {'content-type': 'application/json'};
      String body = jsonBarcode;

      // http.Response resp =
      //     await http.post(Uri.parse(url), headers: headers, body: {
      //   'image': baseimage,
      // });
      String itemname = '商品名';
      String barnum = '12345';
      var resp = await http.post(Uri.parse(url), body: {
        'itemname': itemname,
        'barnum': barnum,
        'quantity': '0',
        'category': '1',
        'price': '1',
        'image': baseimage,
      });

      if (resp.statusCode != 200) {
        print('RegisterPost Error Code : ${resp.statusCode}');
        return resp.statusCode;
      }
      print(resp.body);
      print('レスポンスOK');
      return 200;
    } catch (e) {
      print(e);
      return 500;
    }
  }
}
