import 'package:order_client_app/src/models/food.dart';

class Favorite {
  String id;
  Food food;
  int userId;

  Favorite();

  Favorite.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] != null ? jsonMap['id'].toString() : null;
    food = jsonMap['food'] != null ? Food.fromJSON(jsonMap['food']) : null;
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["food_id"] = food.id;
    map["user_id"] = userId;
    return map;
  }
}
