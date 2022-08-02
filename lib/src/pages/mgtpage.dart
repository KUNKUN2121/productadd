import 'package:flutter/material.dart';

class Mgt extends StatelessWidget {
  const Mgt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品管理'),
      ),
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
