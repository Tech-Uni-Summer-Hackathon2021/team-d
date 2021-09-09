import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawa/picker/genre_picker.dart';
import 'package:sawa/screens/auth/auth.dart';
import 'package:sawa/screens/categoryQ.dart';
import 'package:shared_preferences/shared_preferences.dart';



class categoryFile extends StatefulWidget {

  @override
  _categoryFileState createState() => _categoryFileState();

}

class _categoryFileState extends State<categoryFile> {

  @override
  Widget build(BuildContext context) {
    final User user =  FirebaseAuth.instance.currentUser;
    final String uid = user.uid.toString();
    return Scaffold(
        body:Column(
            children:[
              Card(
                  child:GestureDetector(
                    //質問内容等
                      child: ListTile(
                        leading: Icon(Icons.folder),
                          title: Text("授業"),
                      ),
                      onTap:() async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => category("授業")),
                          );
                      }
                  )
              ),
              //
              Card(
                  child:GestureDetector(
                    //質問内容等
                      child: ListTile(
                        leading: Icon(Icons.folder),
                        title: Text("大学生活"),
                      ),
                      onTap:() async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => category("大学生活")),
                        );
                      }
                  )
              ),
              //
              Card(
                  child:GestureDetector(
                    //質問内容等
                      child: ListTile(
                        leading: Icon(Icons.folder),
                        title: Text("恋愛"),
                      ),
                      onTap:() async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => category("恋愛")),
                        );
                      }
                  )
              ),
              //
              Card(
                  child:GestureDetector(
                    //質問内容等
                      child: ListTile(
                        leading: Icon(Icons.folder),
                        title: Text("就活"),
                      ),
                      onTap:() async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => category("就活")),
                        );
                      }
                  )
              ),
              //
              Card(
                  child:GestureDetector(
                    //質問内容等
                      child: ListTile(
                        leading: Icon(Icons.folder),
                        title: Text("留学"),
                      ),
                      onTap:() async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => category("留学")),
                        );
                      }
                  )
              ),
              //
              Card(
                  child:GestureDetector(
                    //質問内容等
                      child: ListTile(
                        leading: Icon(Icons.folder),
                        title: Text("ゼミ"),
                      ),
                      onTap:() async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => category("ゼミ")),
                        );
                      }
                  )
              ),
              //
              Card(
                  child:GestureDetector(
                    //質問内容等
                      child: ListTile(
                        leading: Icon(Icons.folder),
                        title: Text("勉強"),
                      ),
                      onTap:() async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => category("勉強")),
                        );
                      }
                  )
              ),
              //
              Card(
                  child:GestureDetector(
                    //質問内容等
                      child: ListTile(
                        leading: Icon(Icons.folder),
                        title: Text("バイト"),
                      ),
                      onTap:() async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => category("バイト")),
                        );
                      }
                  )
              ),
              //
              Card(
                  child:GestureDetector(
                    //質問内容等
                      child: ListTile(
                        leading: Icon(Icons.folder),
                        title: Text("サークル"),
                      ),
                      onTap:() async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => category("サークル")),
                        );
                      }
                  )
              ),
              Card(
                  child:GestureDetector(
                    //質問内容等

                      child: ListTile(
                        leading: Icon(Icons.folder),
                        title: Text("その他"),
                      ),
                      onTap:() async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => category("その他")),
                        );
                      }
                  )
              ),
            ]
        )
    );
  }
}