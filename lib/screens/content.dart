import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'main.dart';
class ContentPage extends StatefulWidget {
  @override

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Q＆A"),
          actions: <Widget>[
            IconButton(
                icon: Text("投稿"),
                onPressed: () async {
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
      body: Column(
          key: _reply,
          children: [

            Card(
              child: ListTile(
                subtitle: Text(widget.days),
                title: Text(widget.content),
              ),
            ),
            Container(
              width: double.infinity,
              child: Text("　回答",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
            ),
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
                      return Card(
                        //tapの処理
                        //質問内容等
                        child: ListTile(

                          title: Text(document.data()['reply']),
                          subtitle: Text(document.data()['reply_days']),
                          //ここに名前かジャンルを入れる
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),

            SafeArea(child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                    autofocus: true,
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


    );
  }
}