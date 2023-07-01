import 'dart:convert';

Model modelFromJson(String str) => Model.fromJson(json.decode(str));

String modelToJson(Model data) => json.encode(data.toJson());

class Model {
  Model({
    required this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
  });

  String id;
  String name;
  int age;
  String weight;
  String height;
  String gender;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        gender: json["gender"],
        weight: json["weight"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
        "weight": weight,
        "height": height,
        "gender": gender,
      };
}
