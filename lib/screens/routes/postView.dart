import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawa/screens/auth/auth.dart';
import '../content.dart';
import '../form_questions.dart';


class PostView extends StatelessWidget {
  @override
  final user_name="匿名";
  final String defaultImage ="https://firebasestorage.googleapis.com/v0/b/summerhackathon2021-23986.appspot.com/o/user_icon%2Fdefault.png?alt=media&token=2e1a0e9f-41eb-41f8-8c2d-40467c5d6277";


  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
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
                      title: Text(document.data()['content']),
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
      floatingActionButton: FloatingActionButton (

//ここの処理を考える
        onPressed: () async{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostPage(user_name,defaultImage)),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}





