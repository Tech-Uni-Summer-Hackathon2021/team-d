import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawa/screens/auth/auth.dart';



class ProfileSetView extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('大学生のための質問教室'),

      ),
      body: Stack(
      children: [
      Column(
    children: [
    Expanded(
    flex:5,
    child:Container(
    width: double.infinity,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [Colors.white,Colors.white],
    ),
    ),
    child: Column(
    children: [
    SizedBox(height: 25.0,),
    CircleAvatar(
    radius: 65.0,
    backgroundImage: AssetImage('assets/naruo.jpg'),
    backgroundColor: Colors.white,
    ),
      SizedBox(height: 10.0,),
        TextButton(onPressed: () {}, child: Text('プロフィール画像を変更')),
      TextFormField(

        onSaved: (value) async{
          // questions_title = value;
        },
        enabled: true,
        style: TextStyle(color: Colors.black,fontSize: 18),
        obscureText: false,
        maxLines:1 ,
        decoration: const InputDecoration(
          hintText: '　名前',
        ),
      ),
      TextFormField(

        onSaved: (value) async{
          // questions_title = value;
        },
        enabled: true,
        style: TextStyle(color: Colors.black,fontSize: 18),
        obscureText: false,
        maxLines:1 ,
        decoration: const InputDecoration(
          hintText: '　学部',
        ),
      ),
      TextFormField(

        onSaved: (value) async{
          // questions_title = value;
        },
        enabled: true,
        style: TextStyle(color: Colors.black,fontSize: 18),
        obscureText: false,
        maxLines:1 ,
        decoration: const InputDecoration(
          hintText: '　学年',
        ),
      ),
      TextFormField(

        onSaved: (value) async{
          // questions_title = value;
        },
        enabled: true,
        style: TextStyle(color: Colors.black,fontSize: 18),
        obscureText: false,
        maxLines:1 ,
        decoration: const InputDecoration(
          hintText: '　性別',
        ),
      ),
    ]

    ),
    )
      )
    ],
    )
    ]
      )
    );
  }
}
