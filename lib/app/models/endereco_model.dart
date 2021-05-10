import 'dart:convert';

class EnderecoModel {
  int id;
  String endereco;
  double latitude;
  double longitude;
  String complemento;

  EnderecoModel({
    this.id,
    this.endereco,
    this.latitude,
    this.longitude,
    this.complemento,
  });

  EnderecoModel.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      id = map['id'] as int;
      endereco = map['endereco'] as String;
      latitude = map['latitude'] is String
          ? double.parse(map['latitude'])
          : map['latitude'] as double;
      longitude = map['longitude'] is String
          ? double.parse(map['longitude'])
          : map['longitude'] as double;
      complemento = map['complemento'] as String;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'endereco': endereco,
      'latitude': latitude,
      'longitude': longitude,
      'complemento': complemento,
    };
  }

  String toJson() => json.encode(toMap());
  static EnderecoModel fromJson(String source) =>
      EnderecoModel.fromMap(json.decode(source));
}
