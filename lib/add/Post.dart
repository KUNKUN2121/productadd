import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:productadd/add/Barcode.dart';

class PostRequest {
  final String barcode;
  final String quantity;
  PostRequest({
    required this.barcode,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        'id': barcode,
        'name': quantity,
      };
  List<int> numbers = [1, 2, 3, 4, 5];
  //var numJson = jsonEncode(numbers);

  static Future postMethod(_barcode) async {
    String jsonBarcode = jsonEncode(_barcode);
    String url = "https://store-project.f5.si/database/api/input.php";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = jsonBarcode;

    http.Response resp =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (resp.statusCode != 200) {
      // setState(() {
      //   int statusCode = resp.statusCode;
      //   _content = "Failed to post $statusCode";
      // });
      print(resp.statusCode);
      print(resp.body);
      print('エラー');
      return;
    }
    print(resp.body);
    print('レスポンスOK');
  }
}
