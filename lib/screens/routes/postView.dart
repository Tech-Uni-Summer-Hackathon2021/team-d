import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawa/screens/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../content.dart';
import '../form_questions.dart';

void getName() async{
  var preferences = await SharedPreferences.getInstance();
  FirebaseFirestore.instance.collection("user").doc(preferences.getString("start")).get().then((value) {
    String user_name=value.data()['name'];
  print(user_name);
  return user_name;
  });
}

class PostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
      children:[
        Row(
      children:[
       Container(
         height: 40,  // サイズ指定しないと表示されない
         margin:EdgeInsets.only(top:18,left:20),
          width: 130,
          child: Text("　新着",
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          height: 40,  // サイズ指定しないと表示されない
          margin:EdgeInsets.only(top:18,left:50),
          width:180,
          child: Text("　ジャンルを選択する",
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.right,
          ),
        ),
       ]
      ),

        Flexible(
      child:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("forms").snapshots(),
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
                      subtitle: Text(document.data()['title']),
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
        SafeArea(child: Column(

        mainAxisAlignment: MainAxisAlignment.end,
        children:[
            Container(
    margin:EdgeInsets.only(left: 300.0,bottom: 30),
        child:FloatingActionButton (

        onPressed: () async{
          var preferences = await SharedPreferences.getInstance();
          FirebaseFirestore.instance.collection("user").doc(preferences.getString("start")).get().then((value) {
            String user_name=value.data()['name'];
            String defaultImage=value.data()['avatar_image_path'];
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostPage(user_name,defaultImage)),
            );
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
            )
        ]
    )
        )
    ]
    )
    );

  }
}





