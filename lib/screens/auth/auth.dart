// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../main.dart';
//
// class AuthScreen extends StatefulWidget {
//   const AuthScreen({Key key}) : super(key: key);
//
//   static MaterialPageRoute get route => MaterialPageRoute(
//     builder: (context) => const AuthScreen(),
//   );
//
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> {
//   @override
//   final _firestore = FirebaseFirestore.instance;
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//     _saveCounter(_counter);
//   }
//
//   // 今のカウントを保存する
//   _saveCounter(int count) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     await pref.setInt("count", count);
//   }
//   _readCounter() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     setState(() {
//       var data = pref.getInt("count");
//       if (data != null) {
//         _counter = data;
//       }
//     });
//   }
//
//   void initState() {
//     super.initState();
//     _readCounter();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   // アカウント登録
//   void registeUser() async {
//     await FirebaseAuth.instance.signInAnonymously().then((result) => {
//       print("User id is ${result.user.uid}"),
//       //ページ遷移
//     Navigator.of(context).pushReplacementNamed("/home")
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('大学生のための質問教室'),
//         ),
//         body: Container(
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 40.0),
//               Container(
//                 height: 200,
//               ),
//               TextFormField(
//                 onSaved: (value) async{
//
//                 },
//                 enabled: true,
//                 style: TextStyle(color: Colors.black,fontSize: 18),
//
//                 maxLines:1 ,
//                 decoration: const InputDecoration(
//                   hintText: 'name',
//                 ),
//               ),
//               TextFormField(
//                 onSaved: (value) async{
//
//                 },
//                 enabled: true,
//                 style: TextStyle(color: Colors.black,fontSize: 18),
//                 maxLines:1 ,
//                 decoration: const InputDecoration(
//                   hintText: 'major',
//                 ),
//               ),
//               TextFormField(
//                 onSaved: (value) async{
//
//                 },
//                 enabled: true,
//                 style: TextStyle(color: Colors.black,fontSize: 18),
//                 obscureText: false,
//                 maxLines:1 ,
//                 decoration: const InputDecoration(
//                   hintText: 'grade',
//                 ),
//               ),
//               RaisedButton(
//                 padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
//                 onPressed: () {
//                   _incrementCounter();
//                   _firestore.collection("user").add(
//                     {
//                      'count':_counter
//                     },
//                   );
//                   registeUser();
//                 },
//                 child: Text('匿名ログイン',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold)),
//                 color: Colors.orange,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }