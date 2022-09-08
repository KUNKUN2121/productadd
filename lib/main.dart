import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';

///最初の画面
import 'package:productadd/src/pages/mainpage.dart';
//在庫追加
import 'package:productadd/src/pages/AddPages/AddPage.dart';
import 'package:productadd/src/pages/AddPages/AddPage2.dart';
import 'package:productadd/src/pages/AddPages/ConfirmPage.dart';
//在庫管理
import 'package:productadd/src/pages/mgtpage.dart';
//新規商品追加
import 'package:productadd/src/pages/RegisterPages/NewAddPage.dart';
import 'package:productadd/src/pages/RegisterPages/NewPage.dart';

Future<void> main() async {
  // Flutter Engineの機能を使うので有効化
  WidgetsFlutterBinding.ensureInitialized();

  // 画面の向きを固定
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // main 関数内で非同期処理を呼び出すための設定
  WidgetsFlutterBinding.ensureInitialized();

  // デバイスで使用可能なカメラのリストを取得
  final cameras = await availableCameras();

  // 利用可能なカメラのリストから特定のカメラを取得
  final firstCamera = cameras.first;

  // 取得できているか確認
  print(firstCamera);

// void main() {
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
      home: const MainPage(),
      routes: {
        //AddPage1
        "/MainAddPage": (BuildContext context) => MainAddPage(),
        //AddPage2
        "/AddPage2": (BuildContext context) => AddPage2(),
        //ConfirmPage
        "/ConfirmPage": (BuildContext context) => ConfirmPage(),
        //商品管理
        "/mgt": (BuildContext context) => Mgt(),
        //新商品追加
        "/NewAddPage": (BuildContext context) => NewAddPage(),
        //新商品追加2
        "/ProductAdd": (BuildContext context) => RegisterItemPage(),
      },
    );
  }
}
