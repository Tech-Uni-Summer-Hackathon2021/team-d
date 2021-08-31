import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../main.dart';
//質問投稿のぺージ
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
  //質問にidを付与するためのforms_id
  int count=0;
  //countする
  void _incrementCounter(){
    setState(() {
      count++;
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
      count = prefs.getInt('count');
    });
  }

  void _setCounterValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('count', count);
  }

  Future<void> stopFiveSeconds() async {
    int _counter = 0;
    while(true) {
      await Future.delayed(Duration(seconds: 2));
      _counter++;
      Navigator.of(context).pop("/home");
    }
  }

  final _form = GlobalKey<FormState>();
  //ここからが画面
  Widget build(BuildContext context) {
    return Scaffold(
      //上の画面
      appBar: AppBar(
          title: Text("投稿フォーム"),
          actions: <Widget>[
            IconButton(
              icon: Text("投稿"),
              //押した時の処理
              onPressed: () async {
                _form.currentState.save();
                if(questions_title?.isEmpty ?? true) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('注意'),
                        content: Text('タイトルと投稿内容を記述してください。'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("確認"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    },
                  );
                }
                else if(questions_content?.isEmpty ?? true){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('注意'),
                        content: Text('タイトルと投稿内容を記述してください。'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("確認"),
                            onPressed: () => Navigator.pop(context),
                          ),

                        ],
                      );
                    },
                  );
                }
                else{
                  stopFiveSeconds();
                  _incrementCounter();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('投稿'),
                        content: Text('投稿が完了しました！'),
                        actions: <Widget>[
                          FlatButton(
                              child: Text("確認"),
                              onPressed: (){

                              }
                          ),
                        ],
                      );
                    },
                  );
                  void getTodayDate() async {
                    initializeDateFormatting('ja');
                    var format = new DateFormat.yMMMd('ja');
                    var date = format.format(new DateTime.now());
                    _firestore.collection("forms").add(
                      {
                        "title": questions_title,
                        "content": questions_content,
                        "id": count,
                        "days":date
                      },
                    );
                  }
                  getTodayDate();
                }
              },
            )
          ]
      ),
      //bodyであり、質問内容やタイトルを打ち込む場所
      body: Form(
          key: _form,
          child: Column(
              children:[
                //titleのTextField
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
                //質問内容のTextField
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
              ]
          )
      ),
    );
  }
}


