import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawa/screens/auth/auth.dart';
import 'package:sawa/screens/routes/postView.dart';
import 'package:flutter/cupertino.dart';
TextEditingController _nameController = TextEditingController();
TextEditingController _ageController = TextEditingController();
TextEditingController _majorController = TextEditingController();
TextEditingController _genderController = TextEditingController();
final myFocusNode = FocusNode();
final _firestore = FirebaseFirestore.instance;
String user_name;
String user_age;
String user_major;
String user_gender;

class ProfileSetView extends StatelessWidget {

  ProfileSetView(this.uid) ;
  final String uid;
  @override
  final _profile = GlobalKey <FormState>();
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('大学生のための質問教室'),
          actions: <Widget>[
      IconButton(
      icon: Text("保存"),
    onPressed: () async {
        print(uid);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('完了'),
            content: Text('プロフィールを更新しました'),
            actions: <Widget>[
              FlatButton(
                child: Text("確認"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
      _firestore.collection("user").add(
        {
          "name": user_name,
          "age": user_age,
          "major": user_major,
          "gender":user_gender,
          "uid":uid
        },
      );
    }

      ),
      ],
      ),
      body: Stack(
          key: _profile,
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
        controller: _nameController,
        onFieldSubmitted: (value) {
          print(value);
        },
        onChanged: (value) async{
          user_name = value;
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
        controller: _majorController,
        onChanged: (value) async{
          user_major = value;
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
        controller: _ageController,
        onChanged: (value) async{
          user_age = value;
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
        controller: _genderController,
        onChanged: (value) async{
          user_gender = value;
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
