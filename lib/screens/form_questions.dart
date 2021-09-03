import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sawa/picker/genre_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../main.dart';
//質問投稿のぺージ
class PostPage extends StatefulWidget {
  @override
  _PostPagePageState createState() => _PostPagePageState();
  PostPage(this.user_name,this.defaultImage,this.major);
  final String user_name;
  final String defaultImage;
  final String major;
}
class _PostPagePageState extends State<PostPage> {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingControllerTitle = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
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
      await Future.delayed(Duration(seconds: 1));
      _counter++;
      Navigator.of(context).pop("/home");
    }
  }

  String _selectedGenre = "授業";
  String _initial = "選択";
  void _onSelectedItemChanged_genre(int index) {
    setState(() {
      _selectedGenre = genreList[index];
    });
  }
  void picker_genre() {
    Widget _pickerGenre(String str) {
      return Text(
        str,
        style: const TextStyle(fontSize: 32),
      );
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CupertinoButton(
                    child: Text("戻る"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    child: Text("決定"),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _initial = _selectedGenre;
                        questions_title=_initial;
                        _textEditingControllerTitle.text=questions_title;
                      });
                    },
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: CupertinoPicker(
                  itemExtent: 40,
                  children: genreList.map(_pickerGenre).toList(),
                  onSelectedItemChanged: _onSelectedItemChanged_genre,
                ),
              )
            ],
          ),
        );
      },
    );
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
                FocusScope.of(context).unfocus();
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
                else if(questions_content.length>=10){
                  final User user = await FirebaseAuth.instance.currentUser;
                  final String uid = user.uid.toString();
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
                        "days":date,
                        "uid":uid,
                        "user_name":widget.user_name,
                        "user_image":widget.defaultImage,
                        "user_major":widget.major
                      },
                    );
                  }
                  getTodayDate();
                }
                else if(questions_content.length<10){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('注意'),
                        content: Text('10文字以上入力してください'),
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
              },
            )
          ]
      ),
      //bodyであり、質問内容やタイトルを打ち込む場所
    body: GestureDetector(
    onTap: () {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
    FocusManager.instance.primaryFocus.unfocus();
    }
    },
      child: Form(
          key: _form,
          child: Column(
              children:[
                //titleのTextField
            GestureDetector(
                child: TextFormField(
                  controller: _textEditingControllerTitle,
                  readOnly: true,
                  onTap:(){
                    picker_genre();
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
    )
    );

  }
}


