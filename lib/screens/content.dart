import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../main.dart';
class ContentPage extends StatefulWidget {
  @override
//main.dartから画面遷移された時の処理
  ContentPage(this.content, this.id, this.days);
  final String content;
  final int id;
  final String days;

  _ContentPagePageState createState() => _ContentPagePageState();
}

class _ContentPagePageState extends State<ContentPage> {
  TextEditingController _textEditingControllerReply = TextEditingController();
  String reply_content;
  String reply_days;
  final _firestore = FirebaseFirestore.instance;
  final _reply = GlobalKey<FormState>();

//ここからが画面
  @override
  Widget build(BuildContext context) {

    final User user =  FirebaseAuth.instance.currentUser;
    final String uid = user.uid.toString();

    return Scaffold(
      //上の画面

      appBar: AppBar(
          title: Text("Q＆A"),
          actions: <Widget>[
      Container(
        margin:EdgeInsets.only(right:15),
      child:IconButton(
      icon: const Icon(Icons.star),
    onPressed: (){

    }
      ),
      ),
            ElevatedButton(
          child: const Text("投稿"),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (reply_content?.isEmpty ?? true) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('入力エラー'),
                          content: Text('回答を入力してください'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("OK"),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else {
                    showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('完了'),
                        content: Text('投稿が完了しました！'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("確認"),
                              onPressed: (){
                                Navigator.popUntil(context, (route) => route.isFirst);
                              }
                          ),
                        ],
                      );
                    },
                  );
                    _textEditingControllerReply.clear();
                    void getTodayDate() async {
                      initializeDateFormatting('ja');
                      var format = new DateFormat.yMMMd('ja');
                      var date = format.format(new DateTime.now());
                      _firestore.collection("replies").add(
                        {
                          "reply": reply_content,
                          "reply_id": widget.id,
                          "reply_days":date
                        },
                      );
                    }
                    getTodayDate();
                  }
                  //ここに処理
                } ),
          ]
      ),
      //ここからがメイン画面_リプライを表示する
            body: GestureDetector(
              onTap: () {
                final FocusScopeNode currentScope = FocusScope.of(context);
                if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                  FocusManager.instance.primaryFocus.unfocus();
                }
              },
              child:Column(
          key: _reply,

          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("forms").where(
                  'id', isEqualTo:widget.id).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                   return Card(
                     clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                      radius: 26.0,
                        backgroundImage: NetworkImage(document.data()['user_image']),
                        backgroundColor: Colors.white,
                      ),
                            title: Text(document.data()['user_name'],style: TextStyle(color: Colors.black,fontSize: 18)),
                          ),
                          Container(
                            width: double.infinity,
                            child:  Text(widget.content,
                              style: TextStyle(color: Colors.black,fontSize: 18),textAlign: TextAlign.left,),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            //質問の下にある回答の処理
            Container(
              width: double.infinity,
              child: Text("　回答",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            //firebaseの処理
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("replies").where(
                    'reply_id', isEqualTo: widget.id).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView(
                    children: snapshot.data.docs.map((
                        DocumentSnapshot document) {
                      //リプライ部分
                      return Card(
                        child: ListTile(
                          title: Text(document.data()["reply"]),
                          subtitle: Text(document.data()["reply_days"]),
                          //ここに名前を入れる予定
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),

            //下の回答のTextField

        SafeArea(child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
            TextFormField(
                    enabled: true,
                    controller: _textEditingControllerReply,
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) async {
                      reply_content = value;
                    },
                    decoration: new InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: ('回答する'),
                      prefixIcon: Icon(Icons.face),
                    ),
                  ),

                ]
            ),)

          ]

      ),
            )
    );
  }
}