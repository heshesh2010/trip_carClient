import 'package:order_client_app/src/models/media.dart';

class Extra {
  String id;
  String name;
  double price;
  Media image;
  String description;
  bool checked;

  Extra();

  Extra.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'].toString(),
        name = jsonMap['name'],
        price = jsonMap['price'] != null ? jsonMap['price'].toDouble() : null,
        description = jsonMap['description'],
        checked = false,
        image = jsonMap['media'] != null
            ? (jsonMap['media'] as List).isNotEmpty
                ? Media.fromJSON(jsonMap['media'][0])
                : null
            : null;

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["price"] = price;
    map["description"] = description;
    return map;
  }
}
