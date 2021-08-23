import 'package:flutter/material.dart';


class NotifyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通知について"),
      ),
      body: Column(children: [
        Container(child: Text("自分への回答が届いた時")),
        Container(child: Text("自分の回答へ返信が届いた時")),
      ],)
    );
  }
}