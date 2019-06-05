
import 'dart:convert';
import 'dart:io';

import 'package:clasificador/src/pages/imagemodel.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';
import 'package:clasificador/variables/globals.dart';

class ImagenesProvider {
  Future<String> subirImagenCloudinary( File imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dxsjfx9w2/image/upload?upload_preset=r5fpavat');
   
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }
    final respData = json.decode(resp.body);
    print( respData);
    return respData['secure_url'];
  }


  subirImagenFlask( File imagen ) async {
     try {
      final urlHeroku = Uri.parse('https://young-headland-40135.herokuapp.com/subirImagen');
      final urlLocal = Uri.parse('http://10.0.2.2:5000/subirImagen'); 
      final urlLocalWifi = Uri.parse('http://169.254.223.36:5000/subirImagen'); 
      final mimeType = mime(imagen.path).split('/'); //image/jpeg
      final imageUploadRequest = http.MultipartRequest(
        'POST',
        urlLocal
      );

      final file = await http.MultipartFile.fromPath(
        'file', 
        imagen.path,
        contentType: MediaType( mimeType[0], mimeType[1] )
      );

      imageUploadRequest.files.add(file);

      final streamResponse = await imageUploadRequest.send();
      final resp = await http.Response.fromStream(streamResponse);
      print('Imagen recibida');
      print(resp.body);

      // if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      //   print('Imagen recibida');
      //   // print( resp.body );
      // } else {
      //   final respData = json.decode(resp.body);
      //   print( respData);
      // }
      pathAux = 'listo';
     } catch (e) {
      print('ERROR EN LA IMAGEN:::::: ' + imagen.path);
      pathAux = e.toString();
     }
  }

  Future peticionEscena() async {
    try {
      final urlHeroku = Uri.parse('https://young-headland-40135.herokuapp.com/subirImagen');
      final urlLocal = Uri.parse('http://10.0.2.2:5000/analizarEscena'); 
      final sceneRequest = http.MultipartRequest(
        'GET',
        urlLocal
      );

      final streamResponse = await sceneRequest.send();
      final resp = await http.Response.fromStream(streamResponse);
      print('JSON RECIBIDO');
      print(json.decode(resp.body));
      // Comienza la decodificacion del archivo json de respuesta para 
      // pintar los resultados en el menu principal
      // final Map<String, dynamic> decodedData = json.decode(resp.body);
      // final List<ImagenModel> productos = new List();
      // if ( decodedData == null ) return [];
      // decodedData.forEach( ( id, prod ){
      //   final prodTemp = ImagenModel.fromJson(prod);
      //   prodTemp.escena = id;
      //   productos.add( prodTemp );
      // });
      // return productos;
      return json.decode(resp.body);
    } catch (e) {
      print('ERROR:::: ' + e.toString());
    }

  }


}


   // String arregloPrueba = {  
      //    "escena": "Light",
      //     "materiales": {
      //     "650x350_cinnamon_vanilla_toasted_oats_recipe.jpg": "Cereales",
      //     "como-hacer-las-patatas-fritas-perfectas.jpg": "Cereales",
      //     "cuantas-tazas-de-cafe-son-a-jpg_800x0-jpg_626x0.jpg": "Cereales"
      //      },
      //      "probabilidades":{
      //           "Americano": "0.007252557",
      //           "Cafetero": "0.027723735",
      //           "Light": "0.28939617",
      //           "Paisa": "0.071908794",
      //           "Rolo": "0.13047332"
      //      }
      // };