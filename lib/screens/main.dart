import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'content.dart';
import 'form_questions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sawa/screens/auth/auth.dart';
import 'auth/auth.dart';
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


class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('大学生のための質問教室'),
      ),

      body: StreamBuilder<QuerySnapshot>(
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
    title: Text(document.data()['content']),
      //ここに名前かジャンルを入れる
      subtitle: Text(document.data()['title']),
    ),
        onTap: () {
      print(document.data()['id']);
      Navigator.push(
        //画面遷移
        context,
        MaterialPageRoute(builder: (context) => ContentPage(
            document.data()['content'],
            document.data()['id'],
        )
        ),
      );
        },
      )
    );
    }).toList(),
    );
    },
    ),


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
      ),

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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}



