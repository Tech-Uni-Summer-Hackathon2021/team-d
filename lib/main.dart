import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sawa/screens/form_questions.dart';
import 'screens/auth/auth_model.dart';
import 'screens/routes/postView.dart';
import 'screens/routes/userView.dart';
import 'screens/settingView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sawa/screens/auth/auth.dart';
import 'screens/auth/auth.dart';
import 'dart:async';
import 'screens/auth/auth_model.dart';
import 'package:provider/provider.dart';
import 'screens/profileSetting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      //ルーティングここで画面遷移先決めれます。他でもできるのでどちらでも
      routes:<String, WidgetBuilder>{
        "/home":(BuildContext context) => MyHomePage(),
        "/setting":(BuildContext context) =>SettingView(),
        "/profile":(BuildContext context) =>AuthScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget{

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    var routes =[PostView(), AuthScreen()];
    return Scaffold (
//appBarは上のタイトルが表示されているものです
      appBar: AppBar(
        title: Text('大学生のための質問教室'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            //IconButtonを押した時の処理
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingView()),
              );
            },
          ),
        ],
      ),

      body: routes[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        //下のボタン
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            title: Text('投稿'),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('ユーザー'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );

  }

}
