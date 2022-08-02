import 'package:flutter/material.dart';
import 'package:productadd/main.dart';
import 'package:productadd/main.dart';

class addPop extends StatelessWidget {
  const addPop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '在庫管理システム5',
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
      appBar: AppBar(
        title: Text('バーコードスキャン'),
      ),

      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return MyApp();
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
                    return const MyApp();
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
