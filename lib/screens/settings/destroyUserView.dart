import 'package:flutter/material.dart';


class DestroyUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("アカウント削除"),
      ),
      body: Center(child: Column(
        children: [
          Text("本当にアカウントを削除しますがよろしいですか？"),
          Text("アプリ内のデータは全て消失します。")
        ],)
      )
    );
  }
}