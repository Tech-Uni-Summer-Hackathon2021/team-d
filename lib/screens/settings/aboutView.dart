import 'package:flutter/material.dart';


class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("このアプリについて"),
      ),
      body: Center(child: Column(children: [
        Text("バージョン"),
        Text("利用規約"),
        Text("プライバシーポリシー"),
        Text("法的表示"),
      ],))
    );
  }
}