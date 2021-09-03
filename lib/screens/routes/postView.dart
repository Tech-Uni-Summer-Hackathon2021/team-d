import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawa/picker/genre_picker.dart';
import 'package:sawa/screens/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../content.dart';
import '../form_questions.dart';

class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();
}
void getName() async{
  var preferences = await SharedPreferences.getInstance();
  FirebaseFirestore.instance.collection("user").doc(preferences.getString("start")).get().then((value) {
    String user_name=value.data()['name'];
  print(user_name);
  return user_name;
  });
}

class _PostViewState extends State<PostView> {
  TextEditingController _search = TextEditingController();
  final list = <String>[];
  String _selectedGenre = "授業";
  String _initial = "選択";
  void _onSelectedItemChanged_genre(int index) {
    setState(() {
      _selectedGenre = genreList[index];
    });
  }

  void picker_genre() {
    Widget _pickerGenre(String str) {
      return Text(
        str,
        style: const TextStyle(fontSize: 32),
      );
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CupertinoButton(
                    child: Text("戻る"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    child: Text("決定"),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _search.text = _selectedGenre;
                      });
                    },
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: CupertinoPicker(
                  itemExtent: 40,
                  children: genreList.map(_pickerGenre).toList(),
                  onSelectedItemChanged: _onSelectedItemChanged_genre,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
      children:[
      Container(
      margin:EdgeInsets.only(top:10,bottom:8),
        decoration: BoxDecoration(
            border: const Border(
              top: const BorderSide(
                color: Colors.black,
                width: 0.5,
              ),
            )
        ),
        child:GestureDetector(
        child:TextField(
          controller: _search,
          readOnly: true,
          onTap: () {
            // onChangedは入力されている文字が変更するたびに呼ばれます
            picker_genre();
          },
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search, color: Colors.grey),
            hintText: "検索条件を決める",
          ),
        ),
        ),
      ),

        Flexible(
      child:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("forms").where(
    'title', isEqualTo:_selectedGenre).orderBy('id', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              // list.add(document.data()['content']);
              // print(list);
              return Card(
                //tapの処理
                  child:GestureDetector(
                    //質問内容等
                    child: ListTile(
                      title: Text(document.data()['content'], maxLines:1,),
                      subtitle: Text(document.data()['days']+"   "+document.data()['user_major']+"学部"),
                    ),
                    onTap: () {
                      Navigator.push(
                        //画面遷移
                        context,
                        MaterialPageRoute(builder: (context) => ContentPage(document.data()['content'],document.data()['id'],document.data()['days'])),
                      );
                    },
                  )
              );
            }).toList(),
          );
        },
      ),
        ),

        SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[
            Container(
    margin:EdgeInsets.only(left: 300.0,bottom: 30),
        child:FloatingActionButton (

        onPressed: () async{

          var preferences = await SharedPreferences.getInstance();
          FirebaseFirestore.instance.collection("user").doc(preferences.getString("start")).get().then((value) {
            String user_name=value.data()['name'];
            String defaultImage=value.data()['avatar_image_path'];
            String major=value.data()['major'];
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostPage(user_name,defaultImage,major)),
            );
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
            )
        ]
    )
        )
    ]
    )
    );

  }
}





