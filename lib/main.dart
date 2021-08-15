import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sawa/signup.dart';

void main() async{
  //アプリ起動時に処理したいので追記
  WidgetsFlutterBinding.ensureInitialized();
//Firebaseの初期化（同期）
  await Firebase.initializeApp();
//MyApp()をProviderScopeでラップして、アプリ内のどこからでも全てのプロバイダーにアクセスできるようにする。
  runApp(ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('サンプル'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () {
          print("click");
        },
      ),
    );
  }
}
