import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sawa/screens/profileSetting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../favoriteQ.dart';
import '../myQuestions.dart';
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
  TextEditingController _myQuestions = TextEditingController();
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
    var list = <int>[];
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
                      colors: [Colors.white,Colors.white],
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
                                      color:Colors.black,
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
                            color:Colors.black,
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
                  elevation: 7.0,
                  color:Colors.white,
    child: Container(
    decoration: BoxDecoration(
    // 枠線
    border: Border.all(color: Colors.black87, width: 0.3),
    // 角丸
    borderRadius: BorderRadius.circular(8),
    ),

                  child: Padding(
                    padding:EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
          ),

          ),
          Column(
            children:[
          Column(
          children:[
          Container(
          height: 40,  // サイズ指定しないと表示されない
            margin:EdgeInsets.only(top:360,left:30),
            width: 300,
            child: Text("投稿した質問     いいねした質問",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
            ),
          ),
    GestureDetector(

    child:Container(
      decoration: BoxDecoration(
        border: const Border(
          left: const BorderSide(
            color: Colors.black,
            width: 0.7,
          ),
          top: const BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
          right: const BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
          bottom: const BorderSide(
            color: Colors.black,
            width: 0.2,
          ),
        ),
      ),
            child:TextFormField(
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => myQuestions()),
                );
              },
              enabled: true,
              readOnly: true,
              style: TextStyle(color: Colors.black,fontSize: 18),
              maxLines:1,
              decoration: const InputDecoration(
                hintText: '    投稿した質問',
              ),
            ),
    )
    )
        ],
      ),
            GestureDetector(
              child:Container(
                decoration: BoxDecoration(
                  border: const Border(
                    left: const BorderSide(
                      color: Colors.black,
                      width: 0,
                    ),
                    top: const BorderSide(
                      color: Colors.black,
                      width: 0.5,
                    ),
                    right: const BorderSide(
                      color: Colors.black,
                      width: 0.5,
                    ),
                    bottom: const BorderSide(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                ),
                child:TextFormField(
                  controller: _myQuestions,
                  onTap:() async {
                    final userRef= FirebaseFirestore.instance.collection('favorite').where('uid', isEqualTo:uid);
                    userRef.get().then((snapshot) {
                      final List <int> ids=[];
                      snapshot.docs.forEach((doc) {
                        ids.add(doc.data()["id"]);
                      });
                      print(ids);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => favoriteQ(ids)),
                      );
                    });


                  },
                  enabled: true,
                  readOnly: true,
                  style: TextStyle(color: Colors.black,fontSize: 18),
                  maxLines:1,
                  decoration: const InputDecoration(
                    hintText: '    いいねした質問',
                  ),
                ),
              )
            )
      ]
    )
    ]
      )
    );

  }


}