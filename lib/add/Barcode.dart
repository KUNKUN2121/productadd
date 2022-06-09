import 'package:flutter/material.dart';

import 'CameraPage.dart';

class Barcode {
  String? name;
  int? barcode;
  String? imgURL;
  Key? key;

  Barcode({this.name, this.barcode, this.imgURL, this.key});

  static Future<Barcode> getProcutImg(String barcode) async {
    Barcode result = Barcode(barcode: 1, imgURL: 'a');
    return result;
  }
}
