import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView( // ←WebViewプラグインのウィジェット
          //initialUrl: 呼び出すWebサイトのURLを文字列で渡す
          initialUrl: 'https://arooms.herokuapp.com/now',
          // JavaScriptを有効化させます
          javascriptMode: JavascriptMode.unrestricted,
        ),);
  }
}
