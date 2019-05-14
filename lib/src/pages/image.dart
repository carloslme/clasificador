import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clasificador/variables/globals.dart';

import 'imagemodel.dart';

class ImageInput extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

File _imageFile;

class _ImageInputState extends State<ImageInput> {
  void capturarFoto(){

  }

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
      setState(() {
      _imageFile = image;
      });
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              Text(
                'Escoja una imagen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Usar Camara'),
                onPressed: () {
                  _getImage(context, ImageSource.camera);
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Usar Galería'),
                onPressed: () {
                  _getImage(context, ImageSource.gallery);
                  print("Holaaaaaaa");

                },
              )
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).primaryColor;
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide: BorderSide(
            color: buttonColor,
            width: 2.0,
          ),
          onPressed: () {
            _openImagePicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centrar el botón de Añadir Imagen
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                color: buttonColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Añadir Imagen',
                style: TextStyle(color: buttonColor),
              )
            ],
          ),
        ),
       SizedBox(height: 10.0),
        _imageFile == null
            ? Text('Por favor, seleccione una imagen.')
            : Image.file(
                _imageFile,
                fit: BoxFit.contain,
                height: 250.0,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
              )
      ],
    );
  }

}

//class AppState extends State<ImageInput>{
//  int counter = 0;
//
//  List<ImageModel> images =[];
//
//  fetchImage() async{
//    counter++;
//    var imageModel = ImageModel.fromJson(json.decode(_imageFile.path));
//    setState(() {
//      images.add(imageModel);
//    });
//  }
//}
