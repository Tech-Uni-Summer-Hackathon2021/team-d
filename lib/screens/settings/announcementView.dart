import 'package:flutter/material.dart';


class AnnouncementView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("お知らせ"),
      ),
      body: Center(child: Column(children: [
        Text("祝！しゅわしゅわ β版 リリース！！！"),
        Text("わーい"),
        Text("万歳！！"),
        Text("待ってました！！！"),
      ],))
    );
  }
}