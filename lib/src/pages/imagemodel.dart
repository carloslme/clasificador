import 'dart:convert';

ImagenModel clientFromJson(String str) => ImagenModel.fromJson(json.decode(str));

String clientToJson(ImagenModel data) => json.encode(data.toJson());

class ImagenModel {
    String escena;
    Materiales materiales;
    Probabilidades probabilidades;

    ImagenModel({
        this.escena,
        this.materiales,
        this.probabilidades,
    });

    factory ImagenModel.fromJson(Map<String, dynamic> json) => new ImagenModel(
        escena: json["escena"],
        materiales: Materiales.fromJson(json["materiales"]),
        probabilidades: Probabilidades.fromJson(json["probabilidades"]),
    );

    Map<String, dynamic> toJson() => {
        "escena": escena,
        "materiales": materiales.toJson(),
        "probabilidades": probabilidades.toJson(),
    };
}

class Materiales {
    String imagen1;
    String imagen2;
    String imagen3;
    String imagen4;
    String imagen5;

    Materiales({
        this.imagen1,
        this.imagen2,
        this.imagen3,
        this.imagen4,
        this.imagen5,
    });

    factory Materiales.fromJson(Map<String, dynamic> json) => new Materiales(
        imagen1: json["imagen_1"],
        imagen2: json["imagen_2"],
        imagen3: json["imagen_3"],
        imagen4: json["imagen_4"],
        imagen5: json["imagen_5"],
    );

    Map<String, dynamic> toJson() => {
        "imagen_1": imagen1,
        "imagen_2": imagen2,
        "imagen_3": imagen3,
        "imagen_4": imagen4,
        "imagen_5": imagen5,
    };
}

class Probabilidades {
    int americano;
    int cafetero;
    int light;
    int paisa;
    int rolo;

    Probabilidades({
        this.americano,
        this.cafetero,
        this.light,
        this.paisa,
        this.rolo,
    });

    factory Probabilidades.fromJson(Map<String, dynamic> json) => new Probabilidades(
        americano: json["Americano"],
        cafetero: json["Cafetero"],
        light: json["Light"],
        paisa: json["Paisa"],
        rolo: json["Rolo"],
    );

    Map<String, dynamic> toJson() => {
        "Americano": americano,
        "Cafetero": cafetero,
        "Light": light,
        "Paisa": paisa,
        "Rolo": rolo,
    };
}