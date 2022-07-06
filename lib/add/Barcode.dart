import 'package:http/http.dart';

import 'dart:convert';

class Barcode {
  String name;
  String barcode;
  int quantity;
  String imgURL;
  int price;
  String category;

  //Key? key;

  Barcode({
    required this.name,
    required this.barcode,
    required this.quantity,
    required this.imgURL,
    required this.price,
    required this.category,
  });

  static Future<Barcode> addProduct(_barcode) async {
    String url =
        'https://store-project.f5.si/database/api/productName.php?barcode=$_barcode';
    try {
      var result = await get(Uri.parse(url));
      //print('Response status: ${result.statusCode}');
      // レスポンス確認
      if (result.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(result.body);
        // print('data');
        // print(data['itemname']);
        // print(data['barcode']);
        // print(data['imgURL']);
        // print(data['category']);
        // print(data['price']);
        Barcode ThisProduct = Barcode(
          name: data['itemname'],
          barcode: data['barcode'],
          quantity: 1,
          imgURL: data['imgURL'],
          category: data['category'],
          price: data['price'],
        );
        return ThisProduct;
        // 登録なし
      } else if (result.statusCode == 400) {
        Barcode ThisProduct = Barcode(
          name: 'nullproduct',
          barcode: _barcode,
          imgURL:
              'https://network.mobile.rakuten.co.jp/assets/img/product/iphone/iphone-13-pro/pht-device-16.png?220309-01',
          category: '-400',
          price: -400,
          quantity: -400,
        );
        return ThisProduct;
      } else {
        Barcode ThisProduct = Barcode(
          name: '内部エラー',
          barcode: '0',
          imgURL:
              'https://network.mobile.rakuten.co.jp/assets/img/product/iphone/iphone-13-pro/pht-device-16.png?220309-01',
          category: '0',
          price: 0,
          quantity: 0,
        );
        return ThisProduct;
      }
    } catch (e) {
      print(e);
      print('error');
      Barcode ThisProduct = Barcode(
        name: '-1',
        barcode: '-1',
        imgURL:
            'https://network.mobile.rakuten.co.jp/assets/img/product/iphone/iphone-13-pro/pht-device-16.png?220309-01',
        category: '-1',
        price: -1,
        quantity: -1,
      );
      //print(ThisProduct);
      return ThisProduct;
    }
  }
}
