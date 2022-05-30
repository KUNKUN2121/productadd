import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:math' as math;

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("在庫追加"),
        backgroundColor: Colors.green,
      ),
      //右のバー
      // drawer: Drawer(child: Center(child: Text("Drawer"))),

      //Bodyここから

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // FloatingActionButton(
            //   onPressed: _shuffle,
            //   child: Icon(Icons.shuffle),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('+'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: const Text('-'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),

      //ここまで
    );
  }
}
