import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/order.dart';
import 'package:trip_car_client/src/models/order_status.dart';
import 'package:trip_car_client/src/models/user.dart';
import 'package:trip_car_client/src/repository/order_repository.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class OrderController extends ControllerMVC {
  List<Order> orders = <Order>[];
  List<OrderStatus> orderStatus = <OrderStatus>[];
  bool isLoading = true;

  GlobalKey<ScaffoldState> scaffoldKey;
  User currentUser;
  getUser() async {
    this.currentUser = await getCurrentUser();
  }

  OrderController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    getUser();
    listenForOrders();
  }

  void listenForOrders({String message}) async {
    final Stream<Order> stream = await getOrders();
    stream.listen((Order _order) {
      setState(() {
        orders.add(_order);
      });
    }, onError: (a) {
      setState(() {
        isLoading = false;
      });
      print(a);
      FlushbarHelper.createError(message: a.toString()).show(context);
    }, onDone: () {
      listenForOrderStatus();
      setState(() {
        isLoading = false;
      });
      if (message != null) {
        FlushbarHelper.createSuccess(message: message).show(context);
      }
    });
  }

  void listenForOrderStatus() async {
    final Stream<OrderStatus> stream = await getOrderStatus();
    stream.listen((OrderStatus _orderStatus) {
      setState(() {
        orderStatus.add(_orderStatus);
      });
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> refreshOrders() async {
    orders.clear();
    orderStatus.clear();
    listenForOrders(message: 'تم تحديث قائمة التريبات بنجاح');
    //  listenForOrderStatus();
  }
}
