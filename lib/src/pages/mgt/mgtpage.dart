// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:productadd/main.dart';
import 'package:productadd/src/api/AllProduct.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:productadd/src/pages/mgt/ItemSetting.dart';
import 'package:productadd/src/model/Barcode.dart';

class Mgt extends StatefulWidget {
  const Mgt({Key? key}) : super(key: key);

  @override
  State<Mgt> createState() => _MgtState();
}

class _MgtState extends State<Mgt> {
  var data;

  Future<List> getData(String order) async {
    // カテゴリー
    String goURL = apiURL +
        'all.php' +
        '?order=${order}&category=${category}&search=${search}';
    print(goURL);
    try {
      var result = await get(Uri.parse(goURL));
      if (result.statusCode == 200) {
        data = json.decode(result.body);
        int length = data.length - 1;
        for (int i = 0; i < length; i++) {
          // print(data[i]['itemname']);
        }
      }
      return data;
    } catch (e) {
      print('error');
      print(e);
      List aa = [];
      return aa;
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      _scrollPosition = _scrollController.position.pixels;
    });
    super.initState();

    // getData();
  }

  List CategoryName = [
    ["すべて"],
    ["ドリンク"],
    ["おにぎり"],
    ["パン"],
    ["筆記用具"],
    ["その他"],
  ];
  @override
  String? order = 'itemname';
  String? category = '0';
  String? search = '';
  double _scrollPosition = 0;

  /// コントローラ
  final TextEditingController _seachController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('商品管理'),
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/MainPage", (r) => false);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        // backgroundColor: Color.fromARGB(255, 158, 174, 255),
        body: SafeArea(
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              // 並び替え

              Container(
                child: Row(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DropdownButton(
                                items: const [
                                  DropdownMenuItem(
                                    child: Text('名前順'),
                                    value: 'itemname',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('在庫 多い順'),
                                    value: '-quantity',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('在庫 少ない順'),
                                    value: 'quantity',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('変更順'),
                                    value: '-updated_at',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('作成 新しい順'),
                                    value: '-created_at',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('作成 古い順'),
                                    value: 'created_at',
                                  ),
                                ],
                                onChanged: (String? value) {
                                  _scrollPosition = 0;
                                  setState(() {
                                    print('isSelected ${order} value ${value}');
                                    order = value;
                                  });
                                },
                                value: order,
                              ),
                            ]),

                        //カテゴリ

                        DropdownButton(
                          items: const [
                            DropdownMenuItem(
                              child: Text('すべて'),
                              value: '0',
                            ),
                            DropdownMenuItem(
                              child: Text('ドリンク'),
                              value: '1',
                            ),
                            DropdownMenuItem(
                              child: Text('おにぎり'),
                              value: '2',
                            ),
                            DropdownMenuItem(
                              child: Text('パン'),
                              value: '3',
                            ),
                            DropdownMenuItem(
                              child: Text('筆記用具'),
                              value: '4',
                            ),
                            DropdownMenuItem(
                              child: Text('その他'),
                              value: '5',
                            ),
                          ],
                          onChanged: (String? value) {
                            setState(() {
                              print('isSelected ${category} value ${value}');
                              category = value;
                            });
                          },
                          value: category,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      child: Text(
                        "更新",
                        style: TextStyle(fontSize: 17),
                      ),
                      onPressed: () {
                        setState(() {
                          print(_scrollPosition);
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, //色
                    width: 3.0, //太さ
                  ),
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                        child: (Icon(Icons.qr_code_scanner)),
                        onPressed: () async {
                          var result = await Navigator.of(context)
                              .pushNamed('/QRScanner');
                          print(result);
                          if (result == null) {
                            return;
                          }
                          search = '';
                          search = result.toString();
                          _seachController.text = result.toString();
                          setState(() {});
                        }),
                    SizedBox(width: 10),
                    Flexible(
                      child: TextFormField(
                          // バーコード読み取りの値入力
                          // initialValue: search,
                          controller: _seachController,
                          decoration: const InputDecoration(
                            labelText: 'クリックで検索します',
                            // icon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            // serach に 変更した内容代入
                            search = value;
                            setState(() {
                              _scrollPosition = 0;
                            });
                          }),
                    ),
                  ],
                ),
              ),

              FutureBuilder(
                future: getData(order!),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    /// スクロール移動
                    Future.delayed(Duration(microseconds: 500), () {
                      _scrollController.animateTo(
                        _scrollPosition,
                        duration: Duration(milliseconds: 1),
                        curve: Curves.linear,
                      );
                    });

                    return Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return addListCard(
                              title: snapshot.data![index]['itemname'],
                              barcode:
                                  snapshot.data![index]['barnum'].toString(),
                              quantity:
                                  int.parse(snapshot.data![index]['quantity']),
                              // imgURL: snapshot.data![index]['imgURL'],
                              imgURL: snapshot.data![index]['imgURL'],
                              price: snapshot.data![index]['price'],
                              category: snapshot.data![index]['category'],
                              id: 1);
                        },
                      ),
                    );
                  } else {
                    return Text("エラーが発生しました。", style: TextStyle(fontSize: 30));
                  }
                },
              ),
            ],
          )),
        )

        // Center(
        //   child:
        // ),
        );
  }

  Card addListCard({
    required String title,
    required String barcode,
    required String price,
    required int quantity,
    required String imgURL,
    required String category,
    required int id,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 120.0),
          ///////
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  child: Row(
                    children: [
                      // 商品画像画像
                      Container(
                        width: 55,
                        height: 55,
                        child: Image.network(imgURL),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      // 商品名バーコード
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                // softWrap: false,
                              ),
                              Text(
                                barcode,
                                softWrap: true,
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '${price}円',
                                softWrap: true,
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                CategoryName[int.parse(category)].toString(),
                                softWrap: true,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 個数 変更ボタン
              Align(
                alignment: Alignment.bottomCenter, //右寄せの指定
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Row(children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${quantity}',
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  // color: Colors.blue,
                                  child: Text(
                                    '個',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ]),
                            ),
                            ElevatedButton(
                              child: Text('変更'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                onPrimary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                // print(imgURL);
                                await Navigator.of(context)
                                    .pushNamed(
                                  "/mgtItemSetting",
                                  arguments: QrCodeQuantity(
                                      qrcode: barcode,
                                      quantity: quantity,
                                      price: int.parse(price),
                                      category: category),
                                )
                                    .then((value) {
                                  // 再描画
                                  setState(() {});
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
