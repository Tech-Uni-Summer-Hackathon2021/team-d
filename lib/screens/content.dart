import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sawa/screens/main.dart';


class ContentPage extends StatefulWidget {

  @override

  _ContentPagePageState createState() => _ContentPagePageState();
}

class _ContentPagePageState extends State<ContentPage> {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingControllerTitle = TextEditingController();

  final _firestore = FirebaseFirestore.instance;
  final myFocusNode = FocusNode();
  String questions_title;
  String questions_content;
  final _form = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("投稿フォーム"),
      ),
     
          );
  }
}