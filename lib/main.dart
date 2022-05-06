import 'package:flutter/material.dart';
import 'add/main.dart';
import 'mgt/mgt.dart';
import 'template/header.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '在庫管理システム',
      //テーマ設定
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      //ホーム読み込み
      home: const WidgetsView(),
    );
  }
}

class WidgetsView extends StatelessWidget {
  const WidgetsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar読み込み
      appBar: Header(),

      body: Center(
        child: Column(
          children: [
            // Text('Tesst'),

            //在庫追加

            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) {
            //         return const Add();
            //       }),
            //     );
            //   },
            //   child: const Text('在庫追加'),
            // ),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: const Text('在庫管理'),
            // ),

            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return Add();
                  }),
                );
              },
              child: Image.asset('assets/images/add.png'),
            ),

            //在庫管理

            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return const Mgt();
                  }),
                );
              },
              child: Image.asset('assets/images/mgg.png'),
            ),
            //以上

            //カメラ
          ],
        ),
      ),
    );
  }
}
