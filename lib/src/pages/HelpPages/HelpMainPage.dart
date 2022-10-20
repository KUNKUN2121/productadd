import 'package:flutter/material.dart';

class HelpMainPage extends StatefulWidget {
  const HelpMainPage({Key? key}) : super(key: key);

  @override
  State<HelpMainPage> createState() => _HelpMainPageState();
}

class _HelpMainPageState extends State<HelpMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HelpPage'),
      ),
      backgroundColor: Colors.blueGrey[300],
      body: Container(
        color: Colors.yellow[50],
      ),
    );
  }
}
