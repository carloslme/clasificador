
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('First app')),
        body: Column(
          children: <Widget>[
            Image.asset(
              'assets/img1.jpg',
            ),
            Text('Me')
          ],
        ),
      ),
    );
  }
}
//class _MyAppState extends State<MyApp> {
//  List<String> _products = ['Laptop'];
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData(primarySwatch: Colors.deepPurple),
//      home: Scaffold(
//        appBar: AppBar(title: Text('Long List App')),
//        body: Column(children: [
//          Container(
//              margin: EdgeInsets.all(10.0),
//              child: RaisedButton(
//                  color: Theme.of(context).primaryColor,
//                  splashColor: Colors.blueGrey,
//                  textColor: Colors.white,
//                  onPressed: () {
//                    setState(() {
//                      _products.add('Macbook');
//                    });
//                  },
//                  child: Text('Add Laptops'))),
//          Column(
//              children: _products
//                  .map((element) => Card(
//                child: Column(
//                  children: <Widget>[
//                    Image.asset('assets/img1.jpg'),
//                    Text(element,
//                        style: TextStyle(color: Colors.deepPurple))
//                  ],
//                ),
//              ))
//                  .toList()),
//        ]),
//      ),
//    );
//  }
//}
