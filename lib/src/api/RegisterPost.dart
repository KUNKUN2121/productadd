import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:productadd/src/model/Barcode.dart';

class Register {
  final int barcode;
  final String name;
  Register({
    required this.name,
    required this.barcode,
  });

  static Future<int> registerPost(String itemName, int barcode) async {
    // 設定
    String url = "https://store-project.f5.si/database/api/register.php";
    List regierstItem = [];

    try {
      ///[registerpost] を Json に変換
      regierstItem.add([itemName, barcode]);
      String jsonBarcode = jsonEncode(regierstItem);
      Map<String, String> headers = {'content-type': 'application/json'};
      String body = jsonBarcode;

      http.Response resp =
          await http.post(Uri.parse(url), headers: headers, body: body);
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
