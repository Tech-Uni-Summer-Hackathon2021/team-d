import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sawa/screens/profileSetting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../settingView.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
    builder: (context) => const AuthScreen(),
  );

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  final _firestore = FirebaseFirestore.instance;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _saveCounter(_counter);
  }
  Future<String> inputData() async {
    final User user = await FirebaseAuth.instance.currentUser;
    final String uid = user.uid.toString();
    return uid;
  }
  // 今のカウントを保存する
  _saveCounter(int count) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt("count", count);
  }
  _readCounter() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var data = pref.getInt("count");
      if (data != null) {
        _counter = data;
      }
    });
  }

  void initState() {
    super.initState();
    _readCounter();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
  Widget build(BuildContext context) {
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
    CircleAvatar(
    radius: 65.0,
    backgroundImage: AssetImage('assets/naruo.jpg'),
    backgroundColor: Colors.white,
    ),
    SizedBox(height: 10.0,),
    Text('Naruo Yoshiki',
    style: TextStyle(
    color:Colors.white,
    fontSize: 20.0,
    )),
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
    Text('商学部',
    style: TextStyle(
    fontSize: 15.0,
    ),)
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
    Text('2回生',
    style: TextStyle(
    fontSize: 15.0,
    ),)
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
              Text('男',
                style: TextStyle(
                  fontSize: 15.0,
                ),)
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


