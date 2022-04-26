import 'package:flutter/material.dart';

class Add extends StatelessWidget {
  const Add({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('追加です'),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
