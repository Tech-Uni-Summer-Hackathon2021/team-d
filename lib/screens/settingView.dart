import 'package:flutter/material.dart';
import 'package:sawa/screens/settings/announcementView.dart';
import 'settings/aboutView.dart';
import 'settings/notifyView.dart';
import 'settings/destroyUserView.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:core';
class SettingView extends StatelessWidget {

  @override
  _launchURL() async {
    const url = "https://forms.gle/KwX57QFeHqWKXBi87";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch $url';
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("設定画面"),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              Card(
                child: InkWell(  // InkWellはCardの子ウィジェット
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotifyView()),
                    );
                  },
                  child: ListTile(
                    title: Text('通知について'),
                  ),
                ),
              ),

              Card(
                child: InkWell(  // InkWellはCardの子ウィジェット
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DestroyUserView()),
                    );
                  },
                  child: ListTile(
                    title: Text('アカウント削除'),
                  ),
                ),
              ),
              Card(
                child: InkWell(  // InkWellはCardの子ウィジェット
                  onTap: () {
                    _launchURL();
                  },
                  child: ListTile(
                    title: Text('お問い合わせとレビュー'),
                  ),
    ),
              ),
        
              Card(
                child: InkWell(  // InkWellはCardの子ウィジェット
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutView()),
                    );
                  },
                  child: ListTile(
                    title: Text('このアプリについて'),
                  ),
                ),
              ),
               Card(
                child: InkWell(  // InkWellはCardの子ウィジェット
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnnouncementView()),
                    );
                  },
                  child: ListTile(
                    title: Text('お知らせ'),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}



