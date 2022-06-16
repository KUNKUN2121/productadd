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
  var numJson = jsonEncode(numbers);

  static void request() async {
    //var body = new PostRequest(barcode: '1234', quantity: '大和賢一郎');
    String url = "https://httpbin.org/post";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({
      'barcode': '3333',
      'name': 'moke',
    });

    http.Response resp =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (resp.statusCode != 200) {
      // setState(() {
      //   int statusCode = resp.statusCode;
      //   _content = "Failed to post $statusCode";
      // });
      print('ok');
      return;
    }
    print('222');
    print(resp.body);
    // setState(() {
    //   _content = resp.body;
    // });
  }
}
