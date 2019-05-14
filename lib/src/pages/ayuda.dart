import 'package:flutter/material.dart';

import 'collapsinglist.dart';
import 'gridview.dart';

class Ayuda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Center(
          child: new Column(
            // center the children
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Icon(
                Icons.help_outline,
                size: 160.0,
                color: Colors.black,
              ),
              new Text(
                "Acerca de",
                style: new TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
