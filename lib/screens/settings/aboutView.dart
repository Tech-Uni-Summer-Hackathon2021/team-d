import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';


class AboutView extends StatelessWidget {
  String getTodayDate() {
    initializeDateFormatting('ja');

    return DateFormat.yMMMd('ja').format(DateTime.now()).toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("このアプリについて"),
      ),
      body: Container(
       width: double.infinity,
       child: ListView(
        children: <Widget>[
         ListTile(
           leading: Icon(Icons.announcement),
           title: Text('バージョン：β (${getTodayDate()}現在)'),
           ),
         ListTile(
           leading: Icon(Icons.chat_outlined),
           title: Text('利用規約'),
           
          ),
        ],
       ),
      ),
     );
  }
}