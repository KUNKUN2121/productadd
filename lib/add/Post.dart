import 'package:http/http.dart' as http;

import 'dart:convert';

void _request() async {
  String url = "https://httpbin.org/post";
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode({'name': 'moke'});

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
  // setState(() {
  //   _content = resp.body;
  // });
}
