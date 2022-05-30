import 'package:flutter/material.dart';
import 'add/main.dart';
import 'mgt/mgt.dart';
import 'template/header.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

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
