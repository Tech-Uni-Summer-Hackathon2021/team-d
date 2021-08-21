import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  int forms_id=0;
  void _incrementCounter(){
    setState(() {
      forms_id++;
      _setCounterValue();
    });
  }
  void initState() {
    super.initState();
    _getCounterValue();
  }

  void _getCounterValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      forms_id = prefs.getInt('id');
    });
  }

  void _setCounterValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', forms_id);
  }

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
            _incrementCounter();

              _form.currentState.save();
              if(0 < questions_title.length&&0 < questions_content.length) {
                _firestore.collection("forms").add(
                  {
                    "title": questions_title,
                    "content": questions_content,
                    "id": forms_id
                  },
                );
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => PostPage()),
                );
              }
            },
          ),
        ]
    )
      ),
    );
  }
}