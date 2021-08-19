
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../form_questions.dart';


class PostIndexView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostPage()),
              );
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("forms").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return Card(
                child: ListTile(
                  title: Text(document.data()['content']),
                  subtitle: Text(document.data()['title']),
                    //ここに名前かジャンルを入れる
                ),
              );
            }).toList(),
          );
        },
      )
    );
  }
}