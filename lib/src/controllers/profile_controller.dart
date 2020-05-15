import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/order.dart';
import 'package:trip_car_client/src/models/user.dart';
import 'package:trip_car_client/src/repository/order_repository.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class ProfileController extends ControllerMVC {
  User user = new User();
  List<Order> recentOrders = [];
  GlobalKey<ScaffoldState> scaffoldKey;

  ProfileController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForUser();
    if (user.apiToken != null) {
      listenForRecentOrders();
    }
  }

  void listenForUser() {
    getCurrentUser().then((_user) {
      setState(() {
        user = _user;
      });
    });
  }

  void listenForRecentOrders({String message}) async {
    final Stream<Order> stream = await getRecentOrders();
    stream.listen((Order _order) {
      setState(() {
        recentOrders.add(_order);
      });
    }, onError: (a) {
      print(a);
      FlushbarHelper.createError(message: "حدث خطأ بالاتصال").show(context);
    }, onDone: () {
      if (message != null) {
        FlushbarHelper.createSuccess(message: message).show(context);
      }
    });
  }

  Future<void> refreshProfile() async {
    recentOrders.clear();
    user = new User();
    listenForRecentOrders(message: 'تم تحديث قائمة التريبات');
    listenForUser();
  }
}
