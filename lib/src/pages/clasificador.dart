import 'package:flutter/material.dart';

import 'image.dart';

class Clasificador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        child: new Center(
          child: new Column(
            // center the children
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageInput(),
            ],
          ),
        ),
      ),
    );
  }

 

}