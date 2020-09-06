import 'dart:io';

import 'package:trip_car_client/generated/json/base/json_convert_content.dart';
import 'package:trip_car_client/generated/json/base/json_filed.dart';

class UserEntity with JsonConvert<UserEntity> {
  UserData data;
  int status;
}

class UserData with JsonConvert<UserData> {
  UserDataUser user;
}

class UserDataUser with JsonConvert<UserDataUser> {
  int id;
  String username;
  String fullname;
  String phone;
  String image;
  String email;
  @JSONField(name: "email_verified_at")
  dynamic emailVerifiedAt;
  bool active;
  @JSONField(name: "recive_order")
  bool reciveOrder;
  @JSONField(name: "api_token")
// String apiToken;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
  bool hasImage;
  @JSONField(name: "device_token")
  String deviceToken;
  String apiToken;
  dynamic wallet;
  String message;
  String password;
  String passwordConfirmation;
  String code;
  List<dynamic> reviews;
  // used for indicate if client logged in or not
  bool auth;
  File uploadImage;
  @override
  String toString() {
    var map = this.toJson();
    map["auth"] = this.auth;
    return map.toString();
  }
}
