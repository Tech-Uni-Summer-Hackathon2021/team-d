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
TextEditingController _textEditingControllerReply = TextEditingController();
class _ContentPagePageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Q＆A"),
          actions: <Widget>[
      IconButton(
      icon: Text("投稿"),
      onPressed: () => setState(() {
      }),
    ),
    ]
      ),
      body: Stack(
          children: [
          Card(
          child: ListTile(
            subtitle: Text("  yoshiki"),
              title: Text(widget.content),
          //ここに名前かジャンルを入れる
          ),
              ),
    SafeArea(child:Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[
          TextFormField(
            autofocus: true,
            style: new TextStyle(
              fontSize: 20.0,
              color: Colors.black,

            ),
            controller: _textEditingControllerReply,
            decoration: new InputDecoration(
              border: OutlineInputBorder(),
             hintText: ('回答する'),
              prefixIcon: Icon(Icons.face),

            ),
          ),
        ]
    ) ,)

          ]
        ),
      );
  }
}


// return TextField(
// autofocus: true,
// style: new TextStyle(
// fontSize: 20.0,
// color: Colors.black,
// ),
// controller: _controller,
// decoration: new InputDecoration(
// border: InputBorder.none,
// hintText: 'コメントを追加',
// ),
// ),