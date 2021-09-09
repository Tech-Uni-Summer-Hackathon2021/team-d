import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawa/picker/genre_picker.dart';
import 'package:sawa/screens/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../content.dart';
import '../form_questions.dart';


class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();
}
void getName() async{
  var preferences = await SharedPreferences.getInstance();
  FirebaseFirestore.instance.collection("user").doc(preferences.getString("start")).get().then((value) {
    String user_name=value.data()['name'];
  print(user_name);
  return user_name;
  });
}

class _PostViewState extends State<PostView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // onChangedは入力されている文字が変更するたびに呼ばれます
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
            String major=value.data()['major'];
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostPage(user_name,defaultImage,major)),
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





