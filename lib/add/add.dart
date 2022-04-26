import 'package:flutter/material.dart';

class Add extends StatelessWidget {
  const Add({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('追加です'),
      ),
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
                    return const Add();
                  }),
                );
              },
              child: Image.asset('assets/images/add.png'),
            ),
          ],
        ),
      ),
    );
  }
}
