import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class PostPage extends StatefulWidget {

  @override

  _PostPagePageState createState() => _PostPagePageState();
}

class _PostPagePageState extends State<PostPage> {
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
      body: Form(
          key: _form,
    child: Column(
        children:[
          TextFormField(
          controller: _textEditingControllerTitle,
 
        onFieldSubmitted: (value) {
          print(value);
        },
            onSaved: (value) async{
              questions_title = value;
            },
            enabled: true,
          style: TextStyle(color: Colors.black,fontSize: 18),
          obscureText: false,
          maxLines:1 ,
          decoration: const InputDecoration(
            hintText: '　質問タイトル',
          ),
        ),
          TextFormField(
            controller: _textEditingController,
            enabled: true,
            maxLength: 330,
            maxLengthEnforced: true,
            style: TextStyle(color: Colors.black,fontSize: 18),
            minLines:15,
            maxLines:15,
            onFieldSubmitted: (value) {
              print(value);
            },
            onSaved: (value) async{
              questions_content = value;
            },
            decoration: const InputDecoration(
              hintText: '　投稿内容を記載してください',

            ),
          ),
          FlatButton(
            //投稿ボタン
            child: Text('投稿'),
            onPressed: () async{
              _form.currentState.save();
              print(questions_title);
              print(questions_content);
              _firestore.collection("forms").add(
                {"title": questions_title, "content": questions_content},
              );
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => PostPage()),
              );
            },
          ),
        ]
    )
      ),
    );
  }
}