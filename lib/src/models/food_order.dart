import 'package:order_client_app/src/models/extra.dart';
import 'package:order_client_app/src/models/pivot.dart';

import 'media.dart';

class FoodOrder {
  String name;
  double price;
  String foodId;
  double quantity;
  bool hasMedia;
  List<Media> media;
  Pivot pivot;
  List<Extra> extras;
  String dateTime;
  FoodOrder();

  FoodOrder.fromJSON(Map<String, dynamic> jsonMap) {
    foodId = jsonMap['id'].toString();
    name = jsonMap["name"];
    price = jsonMap['price'] != null ? jsonMap['price'].toDouble() : 0.0;
    quantity =
        jsonMap['quantity'] != null ? jsonMap['quantity'].toDouble() : 0.0;
    hasMedia = jsonMap["has_media"];

    media = List<Media>.from(jsonMap["media"].map((x) => Media.fromJSON(x)));
    dateTime = jsonMap['updated_at'] != null ? jsonMap['updated_at'] : "";
    extras = jsonMap['extras'] != null
        ? List.from(jsonMap['extras'])
            .map((element) => Extra.fromJSON(element))
            .toList()
        : null;
    pivot = jsonMap["pivot"] != null ? Pivot.fromMap(jsonMap["pivot"]) : null;
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["price"] = price;
    map["quantity"] = quantity;
    map["food_id"] = foodId;
    map["extras"] =
        extras == null ? null : extras.map((element) => element.id).toList();
    return map;
  }
}
