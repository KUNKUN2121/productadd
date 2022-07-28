import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../api/RegisterPost.dart';

class RegisterItemPage extends StatefulWidget {
  const RegisterItemPage({Key? key}) : super(key: key);

  @override
  State<RegisterItemPage> createState() => _RegisterItemPageState();
}

class _RegisterItemPageState extends State<RegisterItemPage> {
  // int _counter = 0;

  // void _incrementCounterplus() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  // void _incrementCounterminus() {
  //   setState(() {
  //     _counter--;
  //   });
  // }

  // void _incrementCounterplus10() {
  //   setState(() {
  //     _counter += 10;
  //   });
  // }

  // void _incrementCounterminus10() {
  //   setState(() {
  //     _counter -= 10;
  //   });
  // }

  // void _incrementCounterreset() {
  //   setState(() {
  //     _counter = 0;
  //   });
  // }

  String? isSelectedItem = '飲み物';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('flutter')),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5),
        child: AppBar(
          title: Text(
            'あああ',
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, //画面外タップを検知するために必要
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 40),
                  child: Image(
                      image: NetworkImage(
                          'https://store-project.f5.si/img/4901340017146.jpeg')),
                ),
              ),
              Container(
                width: double.infinity,
                child: SizedBox(
                  width: 100,
                  height: 90,
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                        hintText: '商品名を入力してください!!!!'),
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('カテゴリーを選択してください'),
                    //3
                    SizedBox(
                      width: 250,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.pink.withAlpha(50),
                        ),
                        //4
                        items: const [
                          //5
                          DropdownMenuItem(
                            child: Text('飲み物'),
                            value: '飲み物',
                          ),
                          DropdownMenuItem(
                            child: Text('食べ物'),
                            value: '食べ物',
                          ),
                          DropdownMenuItem(
                            child: Text('その他'),
                            value: 'その他',
                          ),
                        ],
                        //6
                        onChanged: (String? value) {
                          setState(() {
                            isSelectedItem = value;
                          });
                        },
                        //7
                        value: isSelectedItem,
                        isExpanded: true,
                      ),
                    ),
                    //     const SizedBox(
                    //   height: 32,
                    // ),
                    // Text('$isSelectedItem が選択されました。')
                  ],
                ),
              ),
              Container(
                child: Text('仕入れ価格'),
              ),
              Container(
                width: double.infinity,
                child: SizedBox(
                  width: 130,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(10),
                      fillColor: Colors.amber[50],
                      filled: true,
                      border: InputBorder.none,
                      suffix: Text('円'),
                      hintText: '仕入れ価格',
                    ),
                  ),
                ),
              ),
              Container(
                child: Text('販売価格'),
              ),
              Container(
                width: double.infinity,
                child: SizedBox(
                  width: 130,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(10),
                      fillColor: Colors.amber[50],
                      filled: true,
                      border: InputBorder.none,
                      suffix: Text('円'),
                      hintText: '販売価格',
                    ),
                  ),
                ),
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('確定'),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),

              // Container(
              //   child: Text('入庫する数を入力してください'),
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.blue),
              //   ),
              //   child: Text(
              //     '$_counter',
              //     style: TextStyle(fontSize: 50),
              //   ),
              // ),
              // Container(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       OutlinedButton(
              //         onPressed: _incrementCounterplus,
              //         child: const Text('+1'),
              //         style: OutlinedButton.styleFrom(
              //           primary: Colors.black,
              //           shape: const StadiumBorder(),
              //           side: const BorderSide(color: Colors.red),
              //         ),
              //       ),
              //       OutlinedButton(
              //         onPressed: _incrementCounterminus,
              //         child: const Text('-1'),
              //         style: OutlinedButton.styleFrom(
              //           primary: Colors.black,
              //           shape: const StadiumBorder(),
              //           side: const BorderSide(color: Colors.blue),
              //         ),
              //       ),
              //       OutlinedButton(
              //         onPressed: _incrementCounterplus10,
              //         child: const Text('+10'),
              //         style: OutlinedButton.styleFrom(
              //           primary: Colors.black,
              //           shape: const StadiumBorder(),
              //           side: const BorderSide(color: Colors.red),
              //         ),
              //       ),
              //       OutlinedButton(
              //         onPressed: _incrementCounterminus10,
              //         child: const Text('-10'),
              //         style: OutlinedButton.styleFrom(
              //           primary: Colors.black,
              //           shape: const StadiumBorder(),
              //           side: const BorderSide(color: Colors.blue),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //     OutlinedButton(
              //       onPressed: _incrementCounterreset,
              //       child: const Text('リセット'),
              //       style: OutlinedButton.styleFrom(
              //         primary: Colors.black,
              //         shape: const StadiumBorder(),
              //         side: const BorderSide(color: Colors.green),
              //       ),
              //     ),
              //   ]),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
