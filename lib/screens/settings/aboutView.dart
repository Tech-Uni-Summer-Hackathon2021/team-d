import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


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
           // ignore: deprecated_member_use
           title: FlatButton(
             child:Text(
               '利用規約',
               style:TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 20,
                 color: Colors.blue),
                 ),
              onPressed: (){_launchURL();
              },
          ),
        ),
       ],
      ),
     )
    );
  }
}
_launchURL() async {
    const url = "http://monkey-food-delivery.com/%e3%81%97%e3%82%85%e3%82%8f%e3%81%97%e3%82%85%e3%82%8f%e3%80%80%e5%88%a9%e7%94%a8%e8%a6%8f%e7%b4%84/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch $url';
    }
 }