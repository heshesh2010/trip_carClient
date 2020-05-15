import 'dart:convert';
import 'dart:io';

import 'package:trip_car_client/src/models/media.dart';
import 'package:trip_car_client/src/models/restaurant.dart';

class User {
  int id;
  String name;
  String email;
  String password;
  String apiToken;
  String deviceToken;
  String mobile;
  String address;
  String bio;
  List<Media> media;
  String message;
  Restaurant restaurant;
  File profileImage64;

  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.apiToken,
      this.deviceToken,
      this.mobile,
      this.address,
      this.bio,
      this.media,
      this.message,
      this.restaurant,
      this.profileImage64}); //  String role;

  User.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    email = jsonMap['email'];
    apiToken = jsonMap['api_token'];
    deviceToken = jsonMap['device_token'];
    try {
      mobile = jsonMap['custom_fields']['phone']['view'];
    } catch (e) {
      mobile = "";
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
    media = jsonMap["media"] != null
        ? List<Media>.from(jsonMap["media"].map((x) => Media.fromMap(x)))
        : null;

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
    map["mobile"] = mobile;
    map["address"] = address;
    map["bio"] = bio;
    map['media'] = List<dynamic>.from(media.map((x) => x.toMap()));

    return map;
  }

  Map toMapLogin() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["password"] = password;
    map["api_token"] = apiToken;
    map["device_token"] = deviceToken;
    map["phone"] = mobile;
    map["address"] = address;
    map["bio"] = bio;

    return map;
  }

  Map toMapUploadImage() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["password"] = password;
    map["api_token"] = apiToken;
    map["device_token"] = deviceToken;
    map["phone"] = mobile;
    map["address"] = address;
    map["bio"] = bio;
    map["image"] = profileImage64 == null
        ? null
        : "data:image/jpeg;base64," +
            base64Encode(profileImage64.readAsBytesSync());
    return map;
  }
}
