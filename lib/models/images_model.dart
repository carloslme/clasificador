import 'dart:convert' show base64;
import 'dart:typed_data' show Uint8List, ByteBuffer;
import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart/';
import 'package:clasificador/main.dart';

import 'package:clasificador/variables/globals.dart';

main() {
  try {
    String path = 'data/img/image01.jpg';
    File imageToConvert = new File(imageFile.toString());
    List<int> imageBytes = imageToConvert.readAsBytesSync();
    String base64Image = base64.encode(imageBytes);
    print('Imagen en base64' + base64Image);
  } catch(e){
    print("Erroe" + e);
  }


}
class Image{
  final int id;
  final String name;
  final String base64;

  const Image(this.id, this.name, this.base64); // Se coloca const para poder crear instancias constantes en timepo de compilacion
}


void ConvertirAJSON(){

}

void imageToBase64(){

}