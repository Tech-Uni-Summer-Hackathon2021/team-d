import 'package:flutter/material.dart';


class InquiryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("お問い合わせ"),
      ),
      body: Center(child: Column(
        children: [
          Text("ご利用のOS"),
          Text("・iOS"),
          Text("・Android"),
          Text("・その他"),
          Text("ご意見の種別"),
          Text("・ご意見・ご要望"),
          Text("・不具合の報告"),
          Text("・その他"),
          Text("内容")
        ],
      ))
    );
  }
}