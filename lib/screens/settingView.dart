import 'package:flutter/material.dart';
import 'settings/aboutView.dart';
import 'settings/notifyView.dart';
import 'settings/inquiryView.dart';

class SettingView extends StatelessWidget {
  @override
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
                  
                },
                child: ListTile(
                  title: Text('アカウント削除'),
                ),
              ),
            ),

            Card(
              child: InkWell(  // InkWellはCardの子ウィジェット
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InquiryView()),
                  );
                },
                child: ListTile(
                  title: Text('お問い合わせ'),
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
          ],
        ),
      )
    );
  }
}
