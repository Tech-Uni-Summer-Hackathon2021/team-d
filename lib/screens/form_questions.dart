import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sawa/screens/main.dart';


class PostPage extends StatefulWidget {

  @override
  _PostPagePageState createState() => _PostPagePageState();
}

class _PostPagePageState extends State<PostPage> {
  _onSubmitted(String content){
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    posts.add({
      "content": content
    });

    /// 入力欄をクリアにする
    _textEditingController.clear();
    _textEditingControllerTitle.clear();
  }
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingControllerTitle = TextEditingController();
  @override
  final myFocusNode = FocusNode();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("投稿フォーム"),
      ),
      body: Container(
      width: double.infinity,
    child: Column(
        children:[
          TextField(
          controller: _textEditingControllerTitle,
          onSubmitted: _onSubmitted,
          enabled: true,
          style: TextStyle(color: Colors.black),
          obscureText: false,
          maxLines:1 ,
          decoration: const InputDecoration(
            hintText: '　質問タイトル',

          ),
        ),
          TextField(
            controller: _textEditingController,
            onSubmitted: _onSubmitted,
            enabled: true,
            maxLength: 330, // 入力数
            maxLengthEnforced: true, // 入力上限になったときに、文字入力を抑制するか
            style: TextStyle(color: Colors.black,fontSize: 18),
            obscureText: false,
            minLines:15,
            maxLines:15,
            decoration: const InputDecoration(
              hintText: '　投稿内容を記載してください',

            ),
          ),
        ]
    )
      ),
    );
  }
}