import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:productadd/src/model/Barcode.dart';
// import '../model/AlertDialog.dart';

// class AllProduct {
//   final String barcode;
//   final String quantity;
//   AllProduct({
//     required this.barcode,
//     required this.quantity,
//   });

//   static List<dynamic> allProduct() async {
//     try {
//       String url = "https://store-project.f5.si/database/api/all.php";

//       final resp = await http.get(Uri.parse(url));

//       if (resp.statusCode != 200) {
//         print(resp.statusCode);
//         print(resp.body);
//         // return;
//       }
//       dynamic jsonObjects = jsonDecode(resp.body);
//       return jsonObjects;
//     } catch (e) {
//       print(e);
//       return -1;
//     }
//   }
// }
