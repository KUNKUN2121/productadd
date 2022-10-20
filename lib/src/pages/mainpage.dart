import 'package:flutter/material.dart';
import 'package:productadd/main.dart';
import 'package:productadd/src/model/QRScan/QRScanner.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("メインページ"),
        backgroundColor: HexColor('ea2f46'),
      ),
      //右のバー
      drawer: Drawer(child: Center(child: Text("ドロワーダヨーン"))),

      //Bodyここから
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getCard(
              title: "在庫追加",
              description: "バーコードをスキャンして在庫追加します。",
              icon: Icons.add_box_sharp,
              key: const Key("add"),
              onPressed: () {
                Navigator.of(context).pushNamed("/MainAddPage");
              },
            ),
            getCard(
              title: "新商品追加",
              description: "新商品の追加を行います",
              icon: Icons.manage_search,
              key: const Key("new"),
              onPressed: () {
                Navigator.of(context).pushNamed("/NewAddPage");
              },
            ),
            getCard(
              title: "在庫管理",
              description: "在庫状況、在庫削除などを行います。",
              icon: Icons.manage_search,
              key: const Key("mgt"),
              onPressed: () {
                Navigator.of(context).pushNamed("/mgt");
              },
            ),
            getCard(
              title: "ヘルプ",
              description: "test",
              icon: Icons.help,
              key: const Key("test-2"),
              onPressed: () {
                // Navigator.of(context)
                //     .pushNamed("/ProductAdd", arguments: 4903333187560);
                // Navigator.of(context).pushNamed("/HelpMainPage");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MobilerScaner()),
                );
              },
            ),
          ],
        ),
        //ここまで
      ),
    );
  }

  Card getCard({
    required String title,
    required String description,
    required IconData icon,
    required Key key,
    required Function()? onPressed,
  }) {
    return Card(
      key: key,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 100.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50.0,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                    ),
                    Text(
                      description,
                      softWrap: true,
                    ),
                    const Divider(),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        //参考：https://zenn.dev/enoiu/articles/6b754d37d5a272#elevatedbutton%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6
                        style: ElevatedButton.styleFrom(
                          onPrimary: Theme.of(context).colorScheme.onPrimary,
                          primary: Theme.of(context).colorScheme.primary,
                          backgroundColor: HexColor('ea2f46'),
                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                        onPressed: onPressed,
                        child: const Text("開く"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


// class MainPage extends StatelessWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //AppBar読み込み
//       appBar: Header(),

//       body: Center(
//         child: Column(
//           children: [
//             // Text('Tesst'),

//             //在庫追加

//             // ElevatedButton(
//             //   onPressed: () {
//             //     Navigator.of(context).push(
//             //       MaterialPageRoute(builder: (context) {
//             //         return const Add();
//             //       }),
//             //     );
//             //   },
//             //   child: const Text('在庫追加'),
//             // ),
//             // ElevatedButton(
//             //   onPressed: () {},
//             //   child: const Text('在庫管理'),
//             // ),

//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) {
//                     return Add();
//                   }),
//                 );
//               },
//               child: Image.asset('assets/images/add.png'),
//             ),

//             //在庫管理

//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) {
//                     return const Mgt();
//                   }),
//                 );
//               },
//               child: Image.asset('assets/images/mgg.png'),
//             ),
//             //以上

//             //カメラ
//           ],
//         ),
//       ),
//     );
//   }
// }
