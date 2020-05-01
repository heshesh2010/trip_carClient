import 'dart:convert';

import 'package:order_client_app/src/models/media.dart';
import 'package:order_client_app/src/models/restaurant.dart';

class User {
  int id;
  String name;
  String email;
  String password;
  String apiToken;
  String deviceToken;
  String phone;
  String address;
  String bio;
  Media image;
  String message;
  Restaurant restaurant;
//  String role;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    email = jsonMap['email'];
    apiToken = jsonMap['api_token'];
    deviceToken = jsonMap['device_token'];
    try {
      phone = jsonMap['custom_fields']['phone']['view'];
    } catch (e) {
      phone = "";
    }
    try {
      address = jsonMap['custom_fields']['address']['view'];
    } catch (e) {
      address = "";
    }
    try {
      bio = jsonMap['custom_fields']['bio']['view'];
    } catch (e) {
      bio = "";
    }
    image =
        jsonMap['media'] != null ? Media.fromJSON(jsonMap['media'][0]) : null;
    restaurant = jsonMap['resturant'] != null
        ? Restaurant.fromJSON(jsonMap['resturant'])
        : null;
  }

  String toJson() => json.encode(toMap());

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["password"] = password;
    map["api_token"] = apiToken;
    map["device_token"] = deviceToken;
    map["phone"] = phone;
    map["address"] = address;
    map["bio"] = bio;
    return map;
  }
}
