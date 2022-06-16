import 'package:flutter/material.dart';

import 'CameraPage.dart';

import 'package:http/http.dart';

import 'dart:convert';

class Barcode {
  String? name;
  int? barcode;
  String? imgURL;
  int? Price;
  String? Category;
  //Key? key;

  Barcode({
    this.name,
    this.barcode,
    this.imgURL,
    this.Price,
    this.Category,
  });

  static Future<Barcode> addProduct(int _barcode) async {
    String url =
        'https://store-project.f5.si/database/api/productName.php?barcode=$_barcode';
    print('url');
    try {
      var result = await get(Uri.parse(url));
      Map<String, dynamic> data = jsonDecode(result.body);
      //print('data');
      // Barcode ThisProduct = Barcode(
      //   name: data['itemname'],
      //   barcode: data['barcode'],
      //   imgURL: data['imgURL'],
      //   Category: data['category'],
      //   Price: data['price'],
      // );
      print(data);
      print(data['itemname']);
      print(data['barcode']);
      print(data['imgURL']);
      Barcode ThisProduct = Barcode(
        name: '0',
        barcode: 0,
        imgURL: '0',
        Category: '0',
        Price: 0,
      );
      return ThisProduct;
    } catch (e) {
      print(e);
      print('error');
      Barcode ThisProduct = Barcode(
        name: '0',
        barcode: 0,
        imgURL: '0',
        Category: '0',
        Price: 0,
      );
      print(ThisProduct);
      return ThisProduct;
    }
  }
}
