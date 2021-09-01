// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
//
//
// File _image;
//
// Future _takeProfilePicture() async{
//   var image = await ImagePicker.pickImage(source: ImageSource.camera);
//
//   setState((){
//     _image = image;
//   });
// }
//
// Future _selectProfilePicture() async{
//   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//   setState((){
//     _image = image;
//   });
// }
//
// Future<Null> _uploadProfilePicture() async{
//   FirebaseUser user = await FirebaseAuth.instance.currentUser();
//   final StorageReference ref = FirebaseStorage.instance.ref().child('${user.email}/${user.email}_profilePicture.jpg');
//   final StorageUploadTask uploadTask = ref.putFile(_image);
//   final Uri downloadUrl = (await uploadTask.future).downloadUrl;
// }
//
// void _selectAndUploadPicture() async{
//   await _selectProfilePicture();
//   await _uploadProfilePicture();
// }
//
// void _takeAndUploadPicture() async{
//   await _takeProfilePicture();
//   await _uploadProfilePicture();
// }