//import 'package:flutter/material.dart';
//import 'package:clasificador/src/pages/acercade.dart';
//import 'package:clasificador/src/pages/ayuda.dart';
//import 'package:clasificador/src/pages/clasificador.dart';
//
//import 'dart:math' as math;
//import 'package:clasificador/src/pages/image.dart';
import 'dart:convert';
import 'dart:io';

import 'package:clasificador/variables/globals.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//
//
//void main() {
//  runApp(new MaterialApp(
//      // Title
//      title: "Clasificador de alimentos",
//      // Home
//      home: new MyHome()));
//}
//
//class MyHome extends StatefulWidget {
//  @override
//  MyHomeState createState() => new MyHomeState();
//}
//
//// SingleTickerProviderStateMixin is used for animation
//class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
//  // Create a tab controller
//  TabController controller;
//
//  @override
//  void initState() {
//    super.initState();
//
//    // Initialize the Tab Controller
//    controller = new TabController(length: 3, vsync: this);
//  }
//
//  @override
//  void dispose() {
//    // Dispose of the Tab Controller
//    controller.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      // Appbar
//      appBar: new AppBar(
//        centerTitle: true ,
//        // Title
//        title: new Text("Clasificador de desayunos"),
//        // Set the background color of the App Bar
//        backgroundColor: Colors.blue,
//      ),
//      // Set the TabBar view as the body of the Scaffold
//      body: new TabBarView(
//        // Add tabs as widgets
//        children: <Widget>[new Ayuda(), new Clasificador(), new AcercaDe()],
//        // set the controller
//        controller: controller,
//      ),
//      // Set the bottom navigation bar
//      bottomNavigationBar: new Material(
//        // set the color of the bottom navigation bar
//        color: Colors.blue,
//        // set the tab bar as the child of bottom navigation bar
//        child: new TabBar(
//          tabs: <Tab>[
//            new Tab(
//              text: 'Ayuda',
//              // set icon to the tab
//              icon: new Icon(Icons.help),
//            ),
//            new Tab(
//              text: 'Clasificador',
//              icon: new Icon(Icons.image),
//            ),
//            new Tab(
//              text: 'Acerca de',
//              icon: new Icon(Icons.info),
//            ),
//          ],
//          // setup the controller
//          controller: controller,
//        ),
//      ),
//    );
//  }
// }

// This app is a stateful, it tracks the user's current choice.

int contadorImg = 0;
List<String> _imagenes = [

  ];
File _imageFile;

var paramsImage;


@override
void initState() {
}
//Define "root widget"
void main() {
  runApp(new MyApp());
} //one-line function

//Now use stateful Widget = Widget has properties which can be changed
class MainPage extends StatefulWidget {
  final String title;
  //Custom constructor, add property : title
  @override
  MainPage({this.title}) : super();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainPageState(); //Return a state object
  }
}

class MainPageState extends State<MainPage> {
  Choice _selectedChoice = choices[0]; // The app's "state".

  // Contiene la lista de las imagenes y su path que se han tomado para poder desplegarlas en el gridview

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  //State must have "build" => return Widget
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Clasificador"),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(choices[0].icon),
              onPressed: () {
                _select(choices[0]);
                print("Boton 0");
                setState(() {
                  _imagenes.add('data/img/image02.jpg');
                });
              },
            ),
            // action button
            IconButton(
              icon: Icon(choices[1].icon),
              onPressed: () {
                setState(() {
                  _select(choices[1]);
                  print("Boton 1");
                  new Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ChoiceCard(choice: _selectedChoice),
                  );
                });
              },
            ),
            IconButton(
              icon: Icon(choices[2].icon),
              onPressed: () {
                _select(choices[2]);
                print("Boton 2");
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
              children: [
//          new Expanded(
//            child: Card(
//                child: new GridView.extent(
//                    maxCrossAxisExtent: 130.0,
//                    mainAxisSpacing: 5.0,
//                    crossAxisSpacing: 5.0,
//                    padding: const EdgeInsets.all(5.0),
//                    children: _buildGridTiles(5)
//                )
//            ),
//          ),
                new SizedBox(height: 100),
                new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _imagenes.
                    map(
                            (elemento) =>
                            Expanded(
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  setState(() {
//                              print('Elemento: ' + elemento);
//                              print("ANTES: " + _imagenes.toString());
                                    _imagenes.removeWhere((item) =>
                                    item == elemento.toString());
//                              print("DESPUES: " + _imagenes.toString());
                                  });
                                },
                                child: SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Image.asset(
                                        elemento, fit: BoxFit.contain)
                                ),
                              ),
                            )
                    ).toList()
                ),
              ]),
        ),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  if (_imagenes.length < 5) {
                    try{
                      _getImages(context, ImageSource.gallery);
                      print("Cargar imagen");
                    } catch(e) {
                      print('error caught: $e');
                    }

                  } else {
                    print("Entro a ELSE");
                    showAlertDialog(context);
                  }
                },
                heroTag: 'image0',
                tooltip: 'Pick Image from gallery',
                child: const Icon(Icons.add_photo_alternate),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    if (_imagenes.length < 5) {
                      _getImages(context, ImageSource.camera);
                      print("Cargar imagen");
                    } else {
                      print("Entro a ELSE");
                      showAlertDialog(context);
                    }
                  },
                  heroTag: 'image1',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.add_a_photo),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: RaisedButton.icon(
                  color: Colors.blue,
                  label: Text('Clasificar'), textColor: Colors.white,
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_imagenes.length < 2) {
                      print("Alerta mínimo dos imágenes para poder clasificar");
                      showAlertDosImg(context);
                    }
                  },
                ),
              ),
            ]
        ),
    );
  }


  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alerta"),
      content: Text("Solo se pueden capturar máximo 5 imágenes."),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showAlertDosImg(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alerta"),
      content: Text("Debe seleccionar al menos 2 imágenes."),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _getImages(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source).then((File image) {
      setState((){
        print("/////////////// Entra a _getImage");
//        _imagenes.add(_imageFile.toString());
        _imageFile = image;
        var cadena = _imageFile.toString();
        String path = cadena.substring(6,cadena.length);
        String path2 = cadena.substring(7,cadena.length-1);
        print("--------  " + path);
        print("++++++++  " + path2);
        _imagenes.add(path2);
        List<int> imageBytes = _imageFile.readAsBytesSync();
        print(imageBytes);
        String base64Image = base64Encode(imageBytes);
        print("base64: " + base64Image);

        print("paramsImage: " + paramsImage.toString());

      });
//      Navigator.pop(context);
    });
  }
  void converToBase64(BuildContext context, File source){
//    List<int> imageBytes = widget.source.readAsBytesSync();
  }
}

List<Widget> _buildGridTiles(numberOfTiles) {
  List<Container> containers =
      new List<Container>.generate(_imagenes.length, (int index) {
//          final imageName = index < _imagenes.length ?
//          'data/img/image0${index + 1}.jpg' : 'data/img/image${index + 1}.jpg';
    String path = _imagenes.elementAt(index).toString();
    print(path);
    return new Container(
      child: new Image.asset(path, fit: BoxFit.fill),
    );
  });
  return containers;
}

class MyApp extends StatelessWidget {
  //Stateless = immutable = cannot change object's properties
  //Every UI components are widgets
  @override
  Widget build(BuildContext context) {
    //Now we need multiple widgets into a parent = "Container" widget
    //build function returns a "Widget"
    return new MaterialApp(
        title: "", home: new MainPage(title: "GridView of Images"));
  }
}

// Clases para elegir el ícono //
class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Clasificador', icon: Icons.image),
  const Choice(title: 'Ayuda', icon: Icons.help),
  const Choice(title: 'Información', icon: Icons.info),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}



