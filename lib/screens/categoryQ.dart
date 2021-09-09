import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawa/picker/genre_picker.dart';
import 'package:sawa/screens/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'content.dart';



class category extends StatefulWidget {
  @override
  category(this.categoryName);
  final String categoryName;
  _categoryState createState() => _categoryState();

}

class _categoryState extends State<category> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('カテゴリ別'),
        ),
        body:Column(
            children:[
              Container(
                margin:EdgeInsets.only(top:10,bottom:8),
                decoration: BoxDecoration(
                    border: const Border(
                      top: const BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    )
                ),
                child:GestureDetector(
                  child:TextField(
                    readOnly: true,
                    onTap: () {
                    },
                    decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.grey),
                      hintText: "検索条件を決める",
                    ),
                  ),
                ),
              ),

              Flexible(
                child:StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("forms").where(
                      'title', isEqualTo:widget.categoryName).snapshots(),
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
                                subtitle: Text(document.data()['days']+"   "+document.data()['user_major']),
                              ),
                              onTap: () {
                                Navigator.push(
                                  //画面遷移
                                  context,
                                  MaterialPageRoute(builder: (context) => ContentPage(document.data()['content'],document.data()['documentID'],document.data()['days'])),
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





