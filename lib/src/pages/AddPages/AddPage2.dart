import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productadd/src/api/RegisterPost.dart';
import 'package:provider/provider.dart';

import 'package:productadd/src/pages/AddPages/AddPage.dart';
import 'package:productadd/src/model/Barcode.dart';

class AddPage2 extends StatefulWidget {
  //const AddPage2({Key? key}) : super(key: key);
  @override
  State<AddPage2> createState() => _AddPage2State();
}

Future<Barcode> productInfoClass(String barcode) async {
  Barcode Productinfo = await Barcode.addProduct(barcode, -1, -1);
  // await new Future.delayed(new Duration(seconds: 3));
  return Productinfo;
}

///
String? barcode;
int? quantity;
bool flg = false;

class _AddPage2State extends State<AddPage2> {
  ///
  // String tempimg = "https://jmva.or.jp/wp-content/uploads/2018/07/noimage.png";
  String noimage = 'https://jmva.or.jp/wp-content/uploads/2018/07/noimage.png';
  String productname = '';
  @override
  Widget build(BuildContext context) {
    if (flg == false) {
      QrCodeQuantity qrCodeQuantity =
          ModalRoute.of(context)!.settings.arguments as QrCodeQuantity;
      barcode = qrCodeQuantity.qrcode;
      quantity = qrCodeQuantity.quantity;
      flg = true;
    }

    ///個数上げ下げ
    void _incrementquantity(int value) {
      // print(value);
      setState(() {
        quantity = quantity! + value;
        if (quantity! <= 0) {
          quantity = 0;
          return;
        }
        if (quantity! > 199) {
          quantity = 199;
          return;
        }
      });
    }

    // String barcode = '1';
    // final go = productInfoClass(barcode!);
    // go.then((value) {
    //   productName = value.name;
    //   productImg = value.imgURL;
    //   print('hey1');
    //   setState(() {});
    // });

    // if (barcode! == null) {}
    final _widgetCache = UpFixedWidget();

    print(barcode! + 'a');

    ///https://zenn.dev/mstn_/articles/c4d89d5aa64a5c
    return WillPopScope(
      // WillPopScopeコンポーネントで囲う
      onWillPop: () async {
        // ここで任意の処理
        flg = false;
        print('helloooo');
        return true; // trueを返すと前の画面へ遷移
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('個数設定'),
        ),
        body: SingleChildScrollView(
          child: Stack(children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),

                  /// 商品名
                  FutureBuilder(
                    future: productInfoClass(barcode!),
                    builder: (BuildContext context,
                        AsyncSnapshot<Barcode> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child:
                              Text('エラーが発生しました。' + snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasData) {
                        productname = snapshot.data!.name;
                        return Text(
                          snapshot.data!.name,
                          style: TextStyle(fontSize: 30),
                        );
                      } else {
                        return Text("エラーが発生しました。",
                            style: TextStyle(fontSize: 30));
                      }
                    },
                  ),
                  Text(
                    '${barcode}',
                    style: TextStyle(fontSize: 20),
                  ),

                  /// 画像
                  Container(
                    height: 200,
                    child: FutureBuilder(
                      future: productInfoClass(barcode!),
                      builder: (BuildContext context,
                          AsyncSnapshot<Barcode> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child:
                                Text('エラーが発生しました。' + snapshot.error.toString()),
                          );
                        }
                        if (snapshot.hasData) {
                          return Image.network(
                            snapshot.data!.imgURL,
                          );
                        } else {
                          return const Text('エラーが発生しました。');
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _incrementquantity(-10);
                          },
                          child: Text(
                            '-10',
                            style: TextStyle(fontSize: 20),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            _incrementquantity(-1);
                          },
                          child: Text(
                            '-1',
                            style: TextStyle(fontSize: 20),
                          )),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                        ),
                        width: 100,
                        child: Text(
                          '${quantity}',
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _incrementquantity(1);
                          },
                          child: Text(
                            '+1',
                            style: TextStyle(fontSize: 20),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            _incrementquantity(10);
                          },
                          child: Text(
                            '+10',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
////////

                  /// 登録画面

                  ElevatedButton(
                    child: Text(
                      "確定",
                      style: TextStyle(fontSize: 45),
                    ),
                    onPressed: () {
                      addProductContents(barcode!);
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  ///削除
                  ElevatedButton(
                    child: Text(
                      "削除",
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: () {
                      removeProductContents(barcode!);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  removeProductContents(String barcode) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("本当に削除しますか？"),
          content: Text("この商品を削除します。"),
          actions: <Widget>[
            // ボタン領域
            ElevatedButton(
                child: Text("キャンセル"), onPressed: () => Navigator.pop(context)),
            ElevatedButton(
                child: Text("削除する"),
                onPressed: () {
                  flg = false;
                  for (int i = 0; i < products.length; i++) {
                    if (products[i].barcode == barcode) {
                      products.removeAt(i);
                      flg = false;
                      Navigator.pop(context);
                      Navigator.pop(context);
                      return;
                    }
                  }
                  flg = false;
                  Navigator.pop(context);
                  Navigator.pop(context);

                  return;
                }),
          ],
        );
      },
    );
  }

  Future addProductContents(String addqrcode) async {
    Barcode addProduct =
        await Barcode.addProduct(addqrcode, quantity!, productsindex);
    // Barcode addProduc22 = Barcode(name: productname,barcode: barcode.toString(),imgURL:,quantity: quantity!,id:productsindex);
    // print(productsindex);

    /// [products]に同じのがあったらreturn
    for (int i = 0; i < products.length; i++) {
      if (addProduct.barcode == products[i].barcode) {
        products[i].quantity = quantity!;
        flg = false;
        Navigator.of(context).pop();
        return;
      }

      ///同じ商品だったらreturn
    }
    if (addProduct.price == -400) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("この商品は登録されていません。"),
            content:
                Text("この商品は登録されていません。登録処理をしてください\nコード ${addProduct.barcode}"),
            actions: <Widget>[
              // ボタン領域
              ElevatedButton(
                  child: Text("キャンセル"),
                  onPressed: () => Navigator.pop(context)),
              ElevatedButton(
                  child: Text("登録"),
                  onPressed: () {
                    flg = false;
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed("/ProductAdd",
                        arguments: addProduct.barcode);
                  }),
            ],
          );
        },
      );
    }
    if (quantity! <= 0) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("個数エラー"),
            content: Text("登録する個数は1個以上である必要があります。"),
            actions: <Widget>[
              ElevatedButton(
                  child: Text("閉じる"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        },
      );
      return;
    }
    // ここで追加
    // print(addProduct);
    productsindex++;
    //products.add(addProduct);
    flg = false;
    // products.insert(0, addProduct);
    products.add(addProduct);
    Navigator.of(context).pop();
  }
}

Future<String> test() async {
  await new Future.delayed(new Duration(seconds: 3));
  String a = 'hello';
  // await new Future.delayed(new Duration(seconds: 3));
  return a;
}

/// リビルドを発生させたくない Widget
class UpFixedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: test(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('エラーが発生しました。' + snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          return Text(
            snapshot.data!,
            style: TextStyle(fontSize: 30),
          );
        } else {
          return Text("エラーが発生しました。", style: TextStyle(fontSize: 30));
        }
      },
    );
  }
}
