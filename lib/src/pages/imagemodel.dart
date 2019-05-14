class ImageModel {
  String path;

  ImageModel(this.path);
  ImageModel.fromJson(Map<String, dynamic> parsedJson){
    path =  parsedJson["path"];
  }
//  int id;
//  String base64;
//  String title;
//
//  ImageModel(this.id, this.base64, this.title);
}