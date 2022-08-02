import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:productadd/src/model/Barcode.dart';
import '../model/AlertDialog.dart';

class PostRequest {
  final String barcode;
  final String quantity;
  PostRequest({
    required this.barcode,
    required this.quantity,
  });

  static Future<int> postMethod(_postBarcode) async {
    try {
      String url = "https://store-project.f5.si/database/api/input.php";

      // Post用List
      List postBarcode = [];
      for (int i = 0; i < _postBarcode.length; i++) {
        String barcodeloop;
        int quantityloop;
        barcodeloop = _postBarcode[i].barcode;
        quantityloop = _postBarcode[i].quantity;
        postBarcode.add([barcodeloop, quantityloop]);
      }

      // print(postBarcode);

      //postBarcode を Json に変換
      String jsonBarcode = jsonEncode(postBarcode);
      Map<String, String> headers = {'content-type': 'application/json'};
      String body = jsonBarcode;

      http.Response resp =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (resp.statusCode != 200) {
        print(resp.statusCode);
        print(resp.body);
        print('エラー');
      }
      print(resp.body);
      print('レスポンスOK');
      return 0;
    } catch (e) {
      print(e);
      return -1;
    }
  }
}
