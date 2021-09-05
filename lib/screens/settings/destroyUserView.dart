import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';







class DestroyUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("アカウント削除"),
      ),
      body: Center(child: Column(
        children: [
          Text("本当にアカウントを削除しますがよろしいですか？"),
          Text("アプリ内のデータは全て消失します。"),
          RaisedButton(
            child: const Text('Button'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      title: Text('警告'),
                      content: Text('本当にデータを削除をしますか'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("いいえ"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        FlatButton(
                            child: Text("はい"),
                            onPressed: () async{
                              await FirebaseAuth.instance.currentUser.delete();
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.remove('start');
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: Text("お願い"),
                                      content: Text('新たにデータを作成するには再起動してください'),
                                  );
                                },
                              );
                            }
                        ),
                      ]
                  );
                },
              );



            },
            splashColor: Colors.purple,
          ),
        ],)
      )
    );
  }
}