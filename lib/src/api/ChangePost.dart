// import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:productadd/main.dart';
import 'dart:convert';
import 'dart:io';

import 'package:productadd/src/model/Barcode.dart';
import 'package:productadd/src/pages/AddPages/AddPage2.dart';
import 'package:productadd/src/pages/mgt/ItemSetting.dart';

class Change {
  final int barcode;
  final String name;
  Change({
    required this.name,
    required this.barcode,
  });

  static Future<int> changePostQuantity(String barnum, String quantity) async {
    // 設定
    String url = apiURL + "changePostQuantity.php";
    // String url = testURL + "changePostQuantity.php";
    print(url);
    try {
      var resp = await http.post(Uri.parse(url), body: {
        'barnum': barnum,
        'quantity': quantity,
        'moreinfo': '0',
      });

      if (resp.statusCode != 200) {
        print('RegisterPost Error Code : ${resp.statusCode}');
        return resp.statusCode;
      }
      print(resp.body);
      print('レスポンスOK');
      return 200;
    } catch (e) {
      print(e);
      return 500;
    }
  }

  static Future<int> changePostInfo(
    String barnum,
    String cngIemname,
    String cngPrice,
    String cngCategory,
    String cngImgUrl,
  ) async {
    // 設定
    String url = apiURL + "changePostQuantity.php";
    // String url = testURL + "changePostQuantity.php";
    print(url);

    ///　変更処理
    print(
        'barnum ${barnum} , cngIemname ${cngIemname} , cngPrice ${cngPrice} , cngCategory ${cngCategory} cngImgUrl ${cngImgUrl}');
    try {
      var resp = await http.post(Uri.parse(url), body: {
        'barnum': barnum,
        'itemname': cngIemname,
        'price': cngPrice,
        'category': cngCategory,
        'image': cngImgUrl,
        'moreinfo': '1',
      });

      if (resp.statusCode != 200) {
        print('RegisterPost Error Code : ${resp.statusCode}');
        return resp.statusCode;
      }
      print(resp.body);
      print('レスポンスOK');
      return 200;
    } catch (e) {
      print(e);
      return 500;
    }
  }

  /// 削除アイテム
  static Future<int> deleteitem(
    String barnum,
  ) async {
    // 設定
    String url = apiURL + "changePostQuantity.php";

    ///　変更処理
    try {
      var resp = await http.post(Uri.parse(url), body: {
        'barnum': barnum,
        'delete': 'true',
      });
      print('godelte');
      if (resp.statusCode != 200) {
        print('RegisterPost Error Code : ${resp.statusCode}');
        return resp.statusCode;
      }
      return 200;
    } catch (e) {
      print(e);
      return 500;
    }
  }
}
