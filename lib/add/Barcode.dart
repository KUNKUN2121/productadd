import 'package:flutter/material.dart';

import 'CameraPage.dart';

import 'package:http/http.dart';

import 'dart:convert';

class Barcode {
  String? name;
  String? barcode;
  String? imgURL;
  String? price;
  String? category;
  //Key? key;

  Barcode({
    this.name,
    this.barcode,
    this.imgURL,
    this.price,
    this.category,
  });

  static Future<Barcode> addProduct(_barcode) async {
    String url =
        'https://store-project.f5.si/database/api/productName.php?barcode=$_barcode';
    print('url');
    try {
      var result = await get(Uri.parse(url));
      print('Response status: ${result.statusCode}');
      // レスポンス確認
      if (result.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(result.body);
        print('data');
        Barcode ThisProduct = Barcode(
          name: data['itemname'],
          barcode: data['barcode'],
          imgURL: data['imgURL'],
          category: data['category'],
          price: data['prise'],
        );
        return ThisProduct;
        // 登録なし
      } else if (result.statusCode == 400) {
        Barcode ThisProduct = Barcode(
          name: '-400',
          barcode: '-400',
          imgURL:
              'https://network.mobile.rakuten.co.jp/assets/img/product/iphone/iphone-13-pro/pht-device-16.png?220309-01',
          category: '-400',
          price: '-400',
        );
        return ThisProduct;
      } else {
        Barcode ThisProduct = Barcode(
          name: '内部エラー',
          barcode: '0',
          imgURL:
              'https://network.mobile.rakuten.co.jp/assets/img/product/iphone/iphone-13-pro/pht-device-16.png?220309-01',
          category: '0',
          price: '0',
        );
        return ThisProduct;
      }
    } catch (e) {
      print(e);
      print('error');
      Barcode ThisProduct = Barcode(
        name: '0',
        barcode: '0',
        imgURL:
            'https://network.mobile.rakuten.co.jp/assets/img/product/iphone/iphone-13-pro/pht-device-16.png?220309-01',
        category: '0',
        price: '0',
      );
      print(ThisProduct);
      return ThisProduct;
    }
  }
}
