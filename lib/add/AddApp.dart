import 'package:flutter/material.dart';
import 'add_list_page.dart';

class AddApp extends StatelessWidget {
  const AddApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //タイトル
      title: '商品追加',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AddListPage(),
    );
  }
}
