import 'package:trip_car_client/src/models/car_entity.dart';

class Favorite {
  String id;
  CarData car;
  int userId;

  Favorite();

  Favorite.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] != null ? jsonMap['id'].toString() : null;
    //  car = jsonMap['car'] != null ? CarData().fromJson(json)['car'] : null;
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["food_id"] = car.id;
    map["user_id"] = userId;
    return map;
  }
}
