import 'package:flutter/material.dart';

class NotifyView extends StatefulWidget {
  @override
  _NotifyViewState createState() => _NotifyViewState();
}
class _NotifyViewState extends State<NotifyView>{

  @override
   Widget build(BuildContext context) {
      bool _active = false;

  void _changeSwitch(bool e) => setState(() => _active = e);

    return Container(padding: const EdgeInsets.all(10.0), 
      child: Column(
        children: <Widget>[
          new SwitchListTile(
            value: _active,
            activeColor: Colors.orange,
            activeTrackColor: Colors.red,
            inactiveThumbColor: Colors.blue,
            inactiveTrackColor: Colors.grey,
            secondary: new Icon(
              Icons.thumb_up,
              color: _active ? Colors.orange[700] : Colors.grey[500],
              size: 10.0,
            ),
            title: Text('自分の質問への回答が届いた時'),
            onChanged: _changeSwitch,
          )
        ],
      )
    );
  }
}