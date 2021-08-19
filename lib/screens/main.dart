import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sawa/screens/auth/auth.dart';
import 'routes/postIndexView.dart';
import 'routes/settingView.dart';
import 'routes/userView.dart';

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
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '大学生のための質問教室'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



var _routes = 
[PostIndexView(), 
 UserView(),
 SettingView()
];

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
      void _onItemTapped(int index) {
        setState(() {
          _selectedIndex = index;
        });
      }

    return Scaffold(
      appBar: AppBar(
        title: Text('大学生のための質問教室'),
      ),
      body: _routes.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
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
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
      
      
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}