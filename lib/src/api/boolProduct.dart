import 'package:http/http.dart';

Future<bool?> boolProduct(_barcode) async {
  String url =
      'https://store-project.f5.si/database/api/productName.php?barcode=$_barcode';
  try {
    var result = await get(Uri.parse(url));
    if (result.statusCode == 200) {
      return true;
      // 登録なされていない商品
    } else if (result.statusCode == 400) {
      return false;
    } else {
      return null;
    }
  } catch (e) {
    print(e);
    print('error');
    return null;
  }
}
