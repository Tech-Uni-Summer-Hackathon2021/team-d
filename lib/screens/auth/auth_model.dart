// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sawa/screens/main.dart';
//
// import '../settingView.dart';
// import 'auth.dart';
//
//
// class AuthModel extends ChangeNotifier {
//   User _user;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   AuthModel() {
//     final User _currentUser = _auth.currentUser;
//
//     if (_currentUser != null) {
//       _user = _currentUser;
//       notifyListeners();
//     }
//   }
//
//   User get user => _user;
//   bool get loggedIn => _user != null;
//
//
//   //エラーハンドリング付け足す
//   Future<bool> login(String email, String password) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       _user = result.user;
//       notifyListeners();
//       return true;
//     } catch (error) {
//       print(error.toString());
//       return false;
//     }
//   }
//
//   Future<bool> signup(String email, String password) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       _user = result.user;
//       notifyListeners();
//       return true;
//     } catch (error) {
//       print(error.toString());
//       return false;
//     }
//   }
//
//   Future<void> logout() async {
//     _user = null;
//     await _auth.signOut();
//     notifyListeners();
//   }
// }
// //明日やる main.dartのどこかに入れる
// // class _LoginCheck extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     // ログイン状態に応じて、画面を切り替える
// //     //AuthModelで一括管理
// //     final bool _loggedIn = context.watch<AuthModel>().loggedIn;
// //     return _loggedIn
// //         ? RootWidget()
// //         : AuthScreen();
// //   }
// // }
// Future<void> judge_login() async {
//   final User user = await FirebaseAuth.instance.currentUser;
//   final String uid = user.uid.toString();
//   //uidをどう使うか
//
//   if (uid == null) {
//
//     BuildContext context;
//     Navigator.of(context).pushReplacementNamed("/login");
//
//   }
//   else {
//
//   }
// }