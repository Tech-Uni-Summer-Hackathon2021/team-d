import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawa/screens/auth/auth.dart';
import 'package:sawa/screens/routes/postView.dart';
import 'package:flutter/cupertino.dart';
import 'package:sawa/screens/routes/userView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
TextEditingController _nameController = TextEditingController();
TextEditingController _ageController = TextEditingController();
TextEditingController _majorController = TextEditingController();
TextEditingController _genderController = TextEditingController();
final myFocusNode = FocusNode();
final _firestore = FirebaseFirestore.instance;

Future _getPreferences() async {
  var preferences = await SharedPreferences.getInstance();
  // SharedPreferencesから値を取得.
  // keyが存在しない場合はnullを返す.
  //documentIDの取得のために使用
  print(preferences.getString("test_string_key"));
}



class ProfileSetView extends StatefulWidget {

  ProfileSetView(this.uid) ;

  final String uid;

  @override
  _ProfileSetViewState createState() => _ProfileSetViewState();
}

class _ProfileSetViewState extends State<ProfileSetView> {
  File _image;

  final imagePicker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
//     _firestore.collection("image").add(
//       {
// "url":_image,
//       },
//     );
  }
  Future<Null> _uploadProfilePicture() async{
    User user = await FirebaseAuth.instance.currentUser;

    final StorageReference ref = FirebaseStorage.instance.ref().child('${user.email}/${user.email}_profilePicture.jpg');
    final StorageUploadTask uploadTask = ref.putFile(_image);
    final Uri downloadUrl = (await uploadTask.future).downloadUrl;
  }
  String user_name;

  String user_age;

  String user_major;

  String user_gender;

  @override
  final _profile = GlobalKey <FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('大学生のための質問教室'),
          actions: <Widget>[
            IconButton(
                icon: Text("保存"),
                onPressed: () async {
                  print(widget.uid);
                  if (user_name?.isEmpty ?? true) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('注意'),
                          content: Text('項目を入力してください'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("確認"),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else if (user_age?.isEmpty ?? true) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('注意'),
                          content: Text('項目を入力してください'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("確認"),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else if (user_gender?.isEmpty ?? true) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('注意'),
                          content: Text('項目を入力してください'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("確認"),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else if (user_major?.isEmpty ?? true) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('注意'),
                          content: Text('項目を入力してください'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("確認"),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('完了'),
                          content: Text('プロフィールを更新しました'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("確認"),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      },
                    );
                    _getPreferences();
                    var preferences = await SharedPreferences.getInstance();
                    if (preferences.containsKey("test_string_key")) {
                      //更新
                      FirebaseFirestore.instance.collection('user')
                          .doc(preferences.getString("test_string_key"))
                          .update(
                        {
                          "name": user_name,
                          "age": user_age,
                          "major": user_major,
                          "gender": user_gender,
                        },
                      );
                    }
                    else {
                      //追加
                      var docRef = await _firestore.collection("user").add(
                        {
                          "name": user_name,
                          "age": user_age,
                          "major": user_major,
                          "gender": user_gender,
                          "uid": widget.uid,
                        },
                      );
                      var documentId = docRef.id;
                      _firestore.collection("user").doc(documentId).update(
                        {
                          "documentID": documentId
                        },
                      );
                      Future _setPreferences() async {
                        var preferences = await SharedPreferences.getInstance();
                        // SharedPreferencesに値を設定
                        preferences.setString("test_string_key", documentId);
                      }
                      _setPreferences();
                    }
                  }
                }
            )
          ],
        ),
        body: Stack(

            key: _profile,
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 5,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.white],
                          ),
                        ),
                        child: Column(
                            children: [
                              SizedBox(height: 25.0,),
                    Container(
                            child: _image == null
                                ?  CircleAvatar(
                              radius: 65.0,
                              backgroundImage: AssetImage(
                                  'assets/default.png'),
                              backgroundColor: Colors.white,
                            )
                                : CircleAvatar(

                              child: Image.file(_image),
                              radius: 65.0,
                              backgroundColor: Colors.white,
                            )
                    ),
                              SizedBox(height: 10.0,),
                              TextButton(onPressed: () async {
                                getImageFromGallery();

                              }, child: Text(
                                  'プロフィール画像を変更')),
                              TextFormField(

                                controller: _nameController,
                                onFieldSubmitted: (value) {
                                  print(value);
                                },
                                onChanged: (value) async {
                                  user_name = value;
                                },
                                enabled: true,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                obscureText: false,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: '　名前',
                                ),
                              ),
                              TextFormField(
                                controller: _majorController,
                                onChanged: (value) async {
                                  user_major = value;
                                },
                                enabled: true,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                obscureText: false,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: '　学部',
                                ),
                              ),
                              TextFormField(
                                controller: _ageController,
                                onChanged: (value) async {
                                  user_age = value;
                                },
                                enabled: true,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                obscureText: false,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: '　学年',
                                ),
                              ),
                              TextFormField(
                                controller: _genderController,
                                onChanged: (value) async {
                                  user_gender = value;
                                },
                                enabled: true,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                obscureText: false,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: '　性別',
                                ),
                              ),
                            ]

                        ),
                      )
                  )
                ],
              )
            ]
        )
    );
  }
}