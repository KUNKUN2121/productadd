import 'package:flutter/material.dart';
import 'package:productadd/src/api/AllProduct.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Mgt extends StatefulWidget {
  const Mgt({Key? key}) : super(key: key);

  @override
  State<Mgt> createState() => _MgtState();
}

class _MgtState extends State<Mgt> {
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
        ],
      ),
    );
  }
}
