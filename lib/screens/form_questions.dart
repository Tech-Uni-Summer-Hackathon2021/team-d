import 'package:flutter/material.dart';
import 'package:sawa/screens/main.dart';


class NextPage extends StatelessWidget {

  @override
  final myFocusNode = FocusNode();

  Widget build(BuildContext context) {

    final myController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text("投稿フォーム"),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: '　質問タイトル',

                ),
              ),

              TextFormField( focusNode: myFocusNode,
                maxLines: 15,
                minLines: 15,
                maxLength: 330,
                style: TextStyle(fontSize: 18),
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: '　内容',

                ),
                onChanged: (text) {

                },
              ),
              RaisedButton(
                child: Text('投稿'),
                onPressed: () {
                  final hobbyText = myController.text;
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => NextPage()),
                  );
                },
              ),
            ],
          ),
        )
    );
  }
}


