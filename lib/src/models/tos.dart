import 'dart:convert';

class Tos {
    int id;
    String description;
    String message ;
    Tos({
        this.id,
        this.description,
    });

    factory Tos.fromRawJson(String str) => Tos.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Tos.fromJson(Map<String, dynamic> json) => Tos(
        id: json["id"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
    };
}