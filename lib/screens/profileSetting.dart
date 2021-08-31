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
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sawa/picker/age_picker.dart';
import 'package:sawa/picker/major_picker.dart';
import 'package:sawa/picker/gender_picker.dart';

TextEditingController _nameController = TextEditingController();
TextEditingController _ageController = TextEditingController();
TextEditingController _majorController = TextEditingController();
TextEditingController _genderController = TextEditingController();
final myFocusNode = FocusNode();
final _firestore = FirebaseFirestore.instance;

Future _getPreferences() async {
  var preferences = await SharedPreferences.getInstance();
  //documentIDの取得のために使用
  print(preferences.getString("test_string_key"));
}
Future deletePreferences() async {
  //削除用-リリース前には消す
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('test_string_key');
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
  String _selectedAge = "1回生";
  String _selectedGender = "男";
  String _selectedMajor = "神";
  String _initial = "選択";
  void _onSelectedItemChanged_age(int index) {
    setState(() {
      _selectedAge = ageList[index];
    });
  }
  void _onSelectedItemChanged_major(int index) {
    setState(() {
      _selectedMajor = majorList[index];
    });
  }
void picker_age() {

  Widget _pickerAge(String str) {
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
                      _initial = _selectedAge;
                      user_age=_initial;
                      _ageController.text=user_age;
                    });
                  },
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: CupertinoPicker(
                itemExtent: 40,
                children: ageList.map(_pickerAge).toList(),
                onSelectedItemChanged: _onSelectedItemChanged_age,
              ),
            )
          ],
        ),
      );
    },
  );
}

  void picker_gender() {
    void _onSelectedItemChanged_gender(int index) {
      setState(() {
        _selectedGender = genderList[index];
      });
    }

    Widget _pickerGender(String str) {
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
                        _initial = _selectedGender;
                        user_gender=_initial;
                        _genderController.text=user_gender;
                      });
                    },
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: CupertinoPicker(
                  itemExtent: 40,
                  children: genderList.map(_pickerGender).toList(),
                  onSelectedItemChanged: _onSelectedItemChanged_gender,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void picker_major() {


    Widget _pickerMajor(String str) {
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
                        _initial = _selectedMajor;
                        user_major=_initial;
                        _majorController.text=user_major;
                      });
                    },
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: CupertinoPicker(
                  itemExtent: 40,
                  children: majorList.map(_pickerMajor).toList(),
                  onSelectedItemChanged: _onSelectedItemChanged_major,
                ),
              )
            ],
          ),
        );
      },
    );
  }


  void showBottomSheet() async {
    final result = 1;
    File file;
    final imagePicker = ImagePicker();

    if (result == 0) {
      final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
      file = File(pickedFile.path);
    } else if (result == 1) {
      final pickedFile =
      await imagePicker.getImage(source: ImageSource.gallery);
      file = File(pickedFile.path);
    } else {
      return;
    }
    try {
      var task = await firebase_storage.FirebaseStorage.instance
          .ref('user_icon/' + widget.uid + '.jpg')
          .putFile(file);
      _getPreferences();
      var preferences = await SharedPreferences.getInstance();
      task.ref.getDownloadURL().then((downloadURL) => FirebaseFirestore.instance
          .collection("user")
          .doc(preferences.getString("start"))
          .update({'avatar_image_path': downloadURL}));
    } catch (e) {
      print("Image upload failed");
      print(e);
    }
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

                    //更新
                    FirebaseFirestore.instance.collection('user')
                        .doc(preferences.getString("start"))
                        .update(
                      {
                        "name": user_name,
                        "age": user_age,
                        "major": user_major,
                        "gender": user_gender,
                      },
                    );
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
                              SizedBox(height: 20.0,),

                              Container(
                                child:StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("user").where(
                                        'uid', isEqualTo: widget.uid).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator());
                                      }
                                      return Column(
                                        children: snapshot.data.docs.map((
                                            DocumentSnapshot document) {
                                          return CircleAvatar(
                                            radius: 65.0,
                                            backgroundImage: NetworkImage(document.data()['avatar_image_path']),
                                            backgroundColor: Colors.white,
                                          );

                                        }).toList(),
                                      );
                                    }
                                ),
                              ),
                              SizedBox(height: 8.0,),
                              TextButton(onPressed: () async {
                                showBottomSheet();
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
                                    color: Colors.black, fontSize: 14),
                                obscureText: false,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: '　名前',
                                ),
                              ),
                        GestureDetector(
                              child: TextFormField(
                                onTap:(){
                                  picker_major();
                                },
                                controller: _majorController,
                                onChanged: (value) async {
                                  user_major = value;
                                },
                                enabled: true,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                obscureText: false,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: '　学部',
                                ),
                              ),
                        ),
                    GestureDetector(
                              child: TextFormField(
                                onTap:(){
                                  picker_age();
                                },
                                controller: _ageController,
                                onChanged: (value) async {
                                  user_age = value;
                                },
                                enabled: true,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                obscureText: false,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: '　学年',
                                ),
                              ),
                    ),
                        GestureDetector(
                              child: TextFormField(
                                onTap:(){
                                  picker_gender();
                                },
                                controller: _genderController,
                                onChanged: (value) async {
                                  user_gender = value;
                                },
                                enabled: true,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                obscureText: false,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: '　性別',
                                ),
                              ),
                        )
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