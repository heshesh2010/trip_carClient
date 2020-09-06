import 'dart:convert';

import 'package:trip_car_client/src/models/user_entity.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
  if (json['data'] != null) {
    data.data = new UserData().fromJson(json['data']);
  }
  if (json['status'] != null) {
    data.status = json['status']?.toInt();
  }
  return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.data != null) {
    data['data'] = entity.data.toJson();
  }
  data['status'] = entity.status;
  return data;
}

userDataFromJson(UserData data, Map<String, dynamic> json) {
  if (json['user'] != null) {
    data.user = new UserDataUser().fromJson(json['user']);
  }
  return data;
}

Map<String, dynamic> userDataToJson(UserData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.user != null) {
    data['user'] = entity.user.toJson();
  }
  return data;
}

Map<String, dynamic> userDataUserToJsonUpdate(UserDataUser entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.password != null) data['password'] = entity.password;
  if (entity.username != null) data['username'] = entity.username;
  if (entity.fullname != null) data['fullname'] = entity.fullname;
  if (entity.phone != null) data['phone'] = entity.phone;

  if (entity.uploadImage != null) {
    data['image'] = entity.uploadImage == null
        ? null
        : "data:image/jpeg;base64," +
            base64Encode(entity.uploadImage.readAsBytesSync());
  }
  print("data:image/jpeg;base64," +
      base64Encode(entity.uploadImage.readAsBytesSync()));

  if (entity.email != null) data['email'] = entity.email;
  // data['recive_order'] = entity.reciveOrder ? 1 : 0;
  return data;
}

userDataUserFromJson(UserDataUser data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['username'] != null) {
    data.username = json['username']?.toString();
  }
  if (json['fullname'] != null) {
    data.fullname = json['fullname']?.toString();
  }
  if (json['phone'] != null) {
    data.phone = json['phone']?.toString();
  }
  if (json['image'] != null) {
    data.image = json['image']?.toString();
  }
  if (json['email'] != null) {
    data.email = json['email']?.toString();
  }
  if (json['email_verified_at'] != null) {
    data.emailVerifiedAt = json['email_verified_at'];
  }
  if (json['active'] != null) {
    data.active = json['active'] == 1 ? true : false;
  }
  if (json['recive_order'] != null) {
    data.reciveOrder = json['recive_order'] == 1 ? true : false;
  }
  if (json['api_token'] != null) {
    data.apiToken = json['api_token']?.toString();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at']?.toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at']?.toString();
  }
  if (json['hasImage'] != null) {
    data.hasImage = json['hasImage'] == 1 ? true : false;
  }
  if (json['device_token'] != null) {
    data.deviceToken = json['device_token']?.toString();
  }
  if (json['token'] != null) {
    data.apiToken = json['token']?.toString();
  }
  if (json['wallet'] != null) {
    data.wallet = json['wallet'];
  }
  if (json['message'] != null) {
    data.message = json['message']?.toString();
  }
  if (json['reviews'] != null) {
    data.reviews = new List<dynamic>();
    data.reviews.addAll(json['reviews']);
  }
  return data;
}

Map<String, dynamic> userDataUserToJson(UserDataUser entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['username'] = entity.username;
  data['password'] = entity.password;

  data['fullname'] = entity.fullname;
  data['phone'] = entity.phone;
  data['image'] = entity.image;
  data['email'] = entity.email;
  data['email_verified_at'] = entity.emailVerifiedAt;
  data['active'] = entity.active;
  data['recive_order'] = entity.reciveOrder;
  // data['api_token'] = entity.apiToken;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  data['hasImage'] = entity.hasImage;
  data['device_token'] = entity.deviceToken;
  data['token'] = entity.apiToken;
  data['wallet'] = entity.wallet;
  data['message'] = entity.message;
  data['email'] = entity.email;
  data['password'] = entity.password;
  data['password_confirmation'] = entity.passwordConfirmation;
  data['code'] = entity.code;
  return data;
}

Map<String, dynamic> userDataUserToJsonRestPass(UserDataUser entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['email'] = entity.email;
  data['password'] = entity.password;
  data['password_confirmation'] = entity.passwordConfirmation;
  data['code'] = entity.code;
  return data;
}

Map<String, dynamic> userDataUserToJsonReg(UserDataUser entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
//  data['id'] = entity.id;
  data['password'] = entity.password;
  data['username'] = entity.username;
  data['fullname'] = entity.fullname;
  data['phone'] = entity.phone;
  // data['image'] = entity.image;
  data['email'] = entity.email;

  return data;
}
