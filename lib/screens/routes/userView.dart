import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sawa/screens/profileSetting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../settingView.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen( {Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
    builder: (context) => const AuthScreen(),);
// const AuthScreen(this.user_name);
// final String user_name;
  @override

  _AuthScreenState createState() => _AuthScreenState();

}
class _AuthScreenState extends State<AuthScreen> {

  @override
  final _firestore = FirebaseFirestore.instance;
  // アカウント登録
  void registeUser() async {
    final User user = await FirebaseAuth.instance.currentUser;
    final String uid = user.uid.toString();
    await FirebaseAuth.instance.signInAnonymously().then((result) => {
      print("User id is ${result.user.uid}"),
      //ページ遷移
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileSetView(uid)),
      )
    });
  }

//プロフィール
  @override
  Widget build(BuildContext content) {
    final User user = FirebaseAuth.instance.currentUser;
    final String uid = user.uid.toString();
    return Scaffold(
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
                      colors: [Colors.orange,Colors.orange],
                    ),
                  ),
                  child: Column(
                      children: [
                        SizedBox(height: 25.0,),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("user").where(
                                'uid', isEqualTo: uid).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }
                              return Column(
                                children: snapshot.data.docs.map((
                                    DocumentSnapshot document) {
                                  return CircleAvatar(
                                    radius: 65.0,
                                    backgroundImage: NetworkImage(document.data()['avatar_image_path']),
                                    backgroundColor: Colors.white,
                                  );

                                }).toList(),
                              );
                            }
                        ),
                        SizedBox(height: 10.0,),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("user").where(
                                'uid', isEqualTo: uid).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }
                              return Column(
                                children: snapshot.data.docs.map((
                                    DocumentSnapshot document) {
                                  return Text(
                                    (document.data()['name']),
                                    style: TextStyle(
                                      color:Colors.white,
                                      fontSize: 15.0,
                                    ),
                                  );
                                }).toList(),
                              );
                            }
                        ),
                        SizedBox(height: 10.0,),
                        Text('Kwansei University',
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 15.0,
                          ),)
                      ]
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top:MediaQuery.of(context).size.height*0.25,
              left: 10.0,
              right: 10.0,

              child: Card(
                  color:Colors.white,
                  child: Padding(
                    padding:EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
//major

                        Container(
                          child: Column(
                              children: [
                                Text('学部',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.0
                                  ),),
                                SizedBox(height: 5.0,),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("user").where(
                                        'uid', isEqualTo: uid).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator());
                                      }
                                      return Column(
                                        children: snapshot.data.docs.map((
                                            DocumentSnapshot document) {
                                          return Text(
                                            (document.data()['major']),
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }
                                ),
                              ]),
                        ),
//age
                        Container(
                            child:Column(
                              children: [
                                Text('学年',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.0
                                  ),),
                                SizedBox(height: 5.0,),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("user").where(
                                        'uid', isEqualTo: uid).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator());
                                      }
                                      return Column(
                                        children: snapshot.data.docs.map((
                                            DocumentSnapshot document) {
                                          return Text(
                                            (document.data()['age']),
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }
                                ),
                              ],
                            )
                        ),
                        Container(
                          child: Column(
                              children: [
                                Text('性別',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.0
                                  ),),
                                SizedBox(height: 5.0,),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("user").where(
                                        'uid', isEqualTo: uid).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator());
                                      }
                                      return Column(
                                        children: snapshot.data.docs.map((
                                            DocumentSnapshot document) {
                                          return Text(
                                            (document.data()['gender']),
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }
                                ),
                              ]),
                        ),
                        Container(
                            child:Column(
                                children: [
                                  SizedBox(height: 1.0,),
                                  IconButton(
                                      icon: Icon(Icons.create_rounded),
                                      onPressed: () {
                                        registeUser();

                                      }

                                  ),
                                ]

                            )
                        ),
                      ],
                    ),
                  )
              )
          )
        ],

      ),
    );
  }


}