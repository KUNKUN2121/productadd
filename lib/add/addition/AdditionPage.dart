import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductAdd extends StatelessWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barcode = ModalRoute.of(context)?.settings.arguments;
    if (barcode == null) {}
    print(barcode);
    return Scaffold(
      appBar: AppBar(
        title: Text('バーコードスキャン'),
      ),
      body: Stack(children: [
        Text('商品追加'),
        Text('${barcode}'),
      ]),
    );
  }
}
