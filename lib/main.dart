
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:clasificador/providers/imagenes_provider.dart';
import 'package:clasificador/src/pages/imagemodel.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clasificador/variables/globals.dart';


// VARIABLES LOCALES
int contadorImg = 0;
List<String> _imagenes = []; // Arreglo de imagenes par enviar
File _imageFile;
var paramsImage;
String serverResponse = 'Server response';
Uint8ClampedList base64Data = null;
final servicio = new ImagenesProvider();
bool banderaEscena = false;
bool mostrarTexto = false;


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
    return new MainPageState(); //Return a state object
  }
}

class MainPageState extends State<MainPage> {
  Choice _selectedChoice = choices[0]; // The app's "state".
  final formKey = GlobalKey<FormState>();
  String escena = '';
  String porcentaje = '';
  List<String> materiales = []; 
  String imagen1 = '';
  String imagen2 = '';
  String imagen3 = '';
  String imagen4 = '';
  String imagen5 = '';
  String americano = '';
  String cafetero = '';
  String light = '';
  String paisa = '';
  String rolo = '';
  List<String> values;
  bool _sEnabled = false;
  bool _aEnabled = false;

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  //State must have "build" => return Widget
  @override
  Widget build(BuildContext context) {
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
                  _limpiarTodo();
                });
              },
            ),
            // action button
            IconButton(
              icon: Icon(choices[1].icon),
              onPressed: () {
                showAlertVerAyuda(context);
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
                showAlertVerInfo(context);
                _select(choices[2]);
                print("Boton 2");
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
              children: [
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
                new Padding(padding: EdgeInsets.only(bottom: 20.0)),
                Visibility(
                  child: Text("Desayuno detectado:",style: TextStyle(fontSize: 16.0),),
                  maintainSize: true, 
                  maintainAnimation: true,
                  maintainState: true,
                  visible: mostrarTexto, 
                ),
                Visibility(
                  child: new Text("$escena",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  maintainSize: true, 
                  maintainAnimation: true,
                  maintainState: true,
                  visible: mostrarTexto, 
                ),
                new Padding(padding: EdgeInsets.only(bottom: 15.0)),
                Visibility(
                  child:  new Text("% probabilidad:",style: TextStyle(fontSize: 16.0),),
                  maintainSize: true, 
                  maintainAnimation: true,
                  maintainState: true,
                  visible: mostrarTexto, 
                ),
                Visibility(
                  child:  new Text("$porcentaje",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  maintainSize: true, 
                  maintainAnimation: true,
                  maintainState: true,
                  visible: mostrarTexto, 
                ),
                new Padding(padding: EdgeInsets.only(bottom: 15.0)),
                Visibility(
                  child: ListTile(
                  title: new Center(child: new Text( 'Ver detalles desayuno', style:  TextStyle(fontSize: 13.0, color: Colors.black54) )),
                    onTap: () {                          
                      showAlertVerDetalles(context);
                    }, 
                  ),
                  maintainSize: true, 
                  maintainAnimation: true,
                  maintainState: true,
                  visible: mostrarTexto, 
                ),
              ]),
            ),
          ),
        ),
        floatingActionButton: 
        Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: _crearBotonSeleccionarFoto(context),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: _crearBotonTomarFoto(context),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: _crearBotonSubirFotos(context)
                ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: _crearBotonAnalizarFotos(context)
              ),

            ])
    );
  }
   Widget _crearItem(BuildContext context, ImagenModel producto ) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      // onDismissed: ( direccion ){
      //   productosProvider.borrarProducto(producto.id);
      // },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('${ producto.escena }'),
              subtitle: Text( 'Prueba' ),
              onTap: () {                          
                print("tapped on container");
              }, 
            ),
          ],
        ),
      )
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
      title: Text("Solo se pueden cargar máximo 5 imágenes"),
      content: Text(serverResponse),
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
  showAlertSinImg(BuildContext context) {
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
      content: Text("Primero debe subir las imágenes."),
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
  showAlertResponse(BuildContext context) {
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
      content: Text(serverResponse),
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
  showAlertVerDetalles(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Porcentajes"),
      content: Text('% Paisa: $paisa \n % Cafetero: $cafetero \n % Rolo: $rolo \n % Americano: $americano \n % Light: $light \n'),
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
  showAlertVerDetallesAlimentos(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Porcentajes"),
      content: Text('% Paisa: $paisa \n % Cafetero: $cafetero \n % Rolo: $rolo \n % Americano: $americano \n % Light: $light \n'),
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
  showAlertVerAyuda(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Ayuda"),
      content: Text('1) Para comenzar añade alguna imagen o toma un par de fotos.\n 2) Da clic en Subir. \n 3) Da clic en Analizar. \n * Para quitar una imagen de la lista solo tócala.'),
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

  showAlertVerInfo(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Acerca de"),
      content: Text('Esta es una app que clasifica imágenes y las analiza en conjunto para identificar desayunos colombianos. \nHace uso de redes neuronales convolucionales y artificiales. Está escrita en Python y hace uso de librerías con Keras y OpenCV. \nVersion 1.0'),
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

  void _getImages(BuildContext context, ImageSource source) async {
    ImagePicker.pickImage(source: source).then((File image) {
      setState((){
        _imageFile = image;
        var cadena = _imageFile.toString();
        String path = cadena.substring(6,cadena.length);
        String path2 = cadena.substring(7,cadena.length-1);
        print("--------  " + path);
        print("++++++++  " + path2);
        print('path: ' + image.path);

        _imagenes.add(path2); // Listado de imagenes para mostrar en pantalla
        // // PRUEBA: Se sube la imagen al servidor
        // servicio.subirImagenFlask(image);

      });
//      Navigator.pop(context);
    });
  }

  int enviarImagenes(){
    print('Tamaño del arreglo de imagenes: ' + _imagenes.length.toString());
    int tamanio = _imagenes.length;
    
    print(json.encode(_imagenes));
    for (var i = 0; i < tamanio; i++) {
        print(_imagenes[i]);
        var imagenAEnviar = new File(_imagenes[i]);
        servicio.subirImagenFlask(imagenAEnviar).toString();  
        if ( pathAux == 'listo') {
          print('Ningun error al enviar imagen.');
        } else {
          print('Error al enviar imagen: ' + pathAux);
        }
    }
    if ( _imagenes.contains(pathAux) ) {
      print('Sin contiene el PATH:' + pathAux);
      setState(() {
        _imagenes.removeWhere((item) => item == pathAux.toString());
      });
     
    }
    return 1;
  }

  _crearBotonSeleccionarFoto(BuildContext context) {
    return FloatingActionButton(
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
    );
  }

  _crearBotonTomarFoto(BuildContext context) {
    return FloatingActionButton(
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
    );
  }
  _crearBotonSubirFotos(BuildContext context) {
    return RaisedButton.icon(
      color: Colors.blue,
      label: Text('Subir'), textColor: Colors.white,
      icon: Icon(Icons.send),
      onPressed: () {
        if (_imagenes.length < 2) {
          print("Alerta mínimo dos imágenes para poder clasificar");
          showAlertDosImg(context);
        } else {
          // Se envian las imagenes siempre que sean mayores a 2 e inferiores a 5
          var envio = enviarImagenes();
          if (envio != 1) {
            print('Error al enviar imágenes');
          } else {
            print('Imágenes enviadas');
          }
          banderaEscena = true;
        
        }
      },
    );
  }

  _crearBotonAnalizarFotos(BuildContext context) {
    return RaisedButton.icon(
      color: Colors.blue,
      label: Text('Analizar'), textColor: Colors.white,
      icon: Icon(Icons.center_focus_strong),
      onPressed: () {
        if (banderaEscena == false) {
          print("Aún no ha subido las imágenes");
          showAlertSinImg(context);
        } else {
        _crearListado();
        // setState(() {
        //           mostrarTexto = true
        //         });
        banderaEscena= false;
        }
      },
    );
  }
  _limpiarTodo() {
    setState(() {
      escena = '';
      porcentaje = '';
      imagen1 = '';
      imagen2 = '';
      imagen3 = '';
      imagen4 = '';
      imagen5 = '';
      americano = '';
      cafetero = '';
      light = '';
      paisa = '';
      rolo = '';
      _imagenes = [];   
      mostrarTexto = false;   
    });
      
  }
   Future <Widget> _crearListado() async {
      // var respuesta = servicio.peticionEscena();
      final urlLocal = Uri.parse('http://10.0.2.2:5000/analizarEscena');  
      var res = await http.get(urlLocal,headers: {"Accept":"application/json"});
      var resBody = json.decode(res.body);
      print('LISTADO');
      print(resBody);
      escena = resBody['escena'];
      porcentaje = resBody['porcentaje'];
      print('La escena es: ' + escena);

        

      americano = resBody["probabilidades"]["Americano"];
      cafetero = resBody["probabilidades"]["Cafetero"];
      light = resBody["probabilidades"]["Light"];
      paisa = resBody["probabilidades"]["Paisa"];
      rolo = resBody["probabilidades"]["Rolo"];

      // imagen1 = ["materiales"][""];
      // imagen2 = '';
      // imagen3 = '';
      // imagen4 = '';
      // imagen5 = '';

      
      setState(() {
        print("Success");
        mostrarTexto = true;
      });
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
  const Choice(title: 'Nuevo', icon: Icons.refresh),
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