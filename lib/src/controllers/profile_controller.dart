import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/order_entity.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class ProfileController extends ControllerMVC {
  UserDataUser user = new UserDataUser();
  List<OrderData> recentOrders = [];
  GlobalKey<ScaffoldState> scaffoldKey;

  ProfileController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForUser();
    if (user.apiToken != null) {}
  }

  void listenForUser() {
    getCurrentUser().then((_user) {
      setState(() {
        user = _user;
      });
    });
  }
}
