import 'package:flutter/material.dart';
import 'package:productadd/src/api/AllProduct.dart';
import 'dart:convert';
import 'package:http/http.dart';

class Mgt extends StatefulWidget {
  const Mgt({Key? key}) : super(key: key);

  @override
  State<Mgt> createState() => _MgtState();
}

class _MgtState extends State<Mgt> {
  var data;
  Future<void> getData() async {
    String url = 'https://store-project.f5.si/database/api/all.php';
    try {
      var result = await get(Uri.parse(url));
      if (result.statusCode == 200) {
        print('respok');
        data = json.decode(result.body);
        print(data.length);
        int length = data.length - 1;
        for (int i = 0; i < length; i++) {
          print(data[i]['itemname']);
        }
        // data = json.decode(result.body);
        // print(data);
        // print(data['barnum']);
        // var jsonResponse = result(response);
      }
    } catch (e) {
      print('error');
    }
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品管理'),
      ),
      backgroundColor: Colors.blueGrey[300],
      body: Column(
        children: [
          Container(
            color: Colors.red,
            width: 100,
          ),
          Text('作成中...'),
          ElevatedButton(
              onPressed: () async {
                String url = 'https://store-project.f5.si/database/api/all.php';
                try {
                  var result = await get(Uri.parse(url));
                  if (result.statusCode == 200) {
                    print('respok');
                    data = json.decode(result.body);
                    print(data.length);
                    int length = data.length - 1;
                    for (int i = 0; i < length; i++) {
                      print(data[i]['itemname']);
                    }
                    // data = json.decode(result.body);
                    // print(data);
                    // print(data['barnum']);
                    // var jsonResponse = result(response);
                  }
                } catch (e) {
                  print('error');
                }
              },
              child: Text('hello')),
          FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                //futureで設定した処理が終わっていれば
                return Align(
                  child: Text(snapshot.data[2]['itemname']),
                  alignment: Alignment.topCenter,
                );
              } else {
                return Align(
                  child: Text('2秒待機'),
                  alignment: Alignment.topCenter,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
