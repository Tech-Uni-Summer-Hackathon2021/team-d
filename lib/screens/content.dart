import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sawa/screens/main.dart';

class ContentPage extends StatefulWidget {
  @override

  ContentPage(this.content);
  final String content;
  _ContentPagePageState createState() => _ContentPagePageState();
}


final _firestore = FirebaseFirestore.instance;
class _ContentPagePageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("投稿フォーム"),
      ),
        body: Card(
    child: ListTile(

        title: Text(widget.content),
    //ここに名前かジャンルを入れる

    ),
        )
      );
  }
}