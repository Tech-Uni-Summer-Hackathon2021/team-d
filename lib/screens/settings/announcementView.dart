import 'package:flutter/material.dart';


class AnnouncementView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("お知らせ"),
      ),
      body: Container(
        margin:EdgeInsets.only(top:80),
        child: Center(child:
          Text("祝！しゅわしゅわ β版 リリース！！！",
           style: 
            TextStyle(
              fontSize:18,
              fontWeight: FontWeight.bold
            ),
           ),
       ),
        padding: const EdgeInsets.all(5),
        width: 500,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue,width:3.0),
          borderRadius: BorderRadius.circular(100),
         ),
      )
    );
  }
}