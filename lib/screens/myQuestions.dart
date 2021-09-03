import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawa/picker/genre_picker.dart';
import 'package:sawa/screens/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'content.dart';


class myQuestions extends StatefulWidget {
  @override
  _myQuestionsState createState() => _myQuestionsState();

}

class _myQuestionsState extends State<myQuestions> {

  @override
  Widget build(BuildContext context) {
    final User user =  FirebaseAuth.instance.currentUser;
    final String uid = user.uid.toString();
    return Scaffold(
        appBar: AppBar(
          title: Text("自分の質問一覧"),
        ),
        body:Column(
            children:[

              Flexible(

                child:StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("forms").where(
                      'uid', isEqualTo:uid).orderBy('id', descending: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView(
                      children: snapshot.data.docs.map((DocumentSnapshot document) {
                        return Card(
                          //tapの処理
                            child:GestureDetector(
                              //質問内容等
                              child: ListTile(
                                title: Text(document.data()['content'], maxLines:1,),
                                subtitle: Text(document.data()['days']),
                              ),
                              onTap: () {
                                Navigator.push(
                                  //画面遷移
                                  context,
                                  MaterialPageRoute(builder: (context) => ContentPage(document.data()['content'],document.data()['id'],document.data()['days'])),
                                );
                              },
                            )
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ]
        )
    );

  }
}