import 'package:http/http.dart' as http;
import 'dart:convert';

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

  static void request() async {
    //json test https://www.educative.io/answers/how-to-convert-a-list-to-a-json-string-in-dart

    List colors = [
      [4549131970255, 999],
      [4549131970258, 999],
    ];
    String jsonColors = jsonEncode(colors);
    print(jsonColors);

    // String url = "https://jsonplaceholder.typicode.com/posts";
    String url = "https://store-project.f5.si/database/api/input.php";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = jsonColors;

    http.Response resp =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (resp.statusCode != 201) {
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
    // setState(() {
    //   _content = resp.body;
    // });
  }
}
