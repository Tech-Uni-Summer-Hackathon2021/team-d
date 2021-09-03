import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawa/picker/genre_picker.dart';
import 'package:sawa/screens/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'content.dart';


class favoriteQ extends StatefulWidget {
  favoriteQ(this.ids);
  final List<int> ids;
  @override
  _favoriteQState createState() => _favoriteQState();

}

class _favoriteQState extends State<favoriteQ> {

  @override
  Widget build(BuildContext context) {
    //実験用なので気にしないで
    //
print(widget.ids);
    final User user =  FirebaseAuth.instance.currentUser;
    final String uid = user.uid.toString();
    return Scaffold(
        appBar: AppBar(
          title: Text("いいねした質問一覧"),
        ),
        body:Column(
            children:[
              Flexible(
                child:StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("forms").where(
                      'id', whereIn:widget.ids).snapshots(),
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
                                title: Text(document.data()['content'], maxLines:1,),
                                subtitle: Text(document.data()['days']),
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
            ]
        )
    );

  }
}