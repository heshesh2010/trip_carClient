import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/order_entity.dart';
import 'package:trip_car_client/src/repository/order_repository.dart';

class OrderController extends ControllerMVC {
  List<OrderData> orders = <OrderData>[];
  List<OrderDataStatus> orderStatus = <OrderDataStatus>[];
  bool isLoading = true;

  GlobalKey<ScaffoldState> scaffoldKey;

  OrderController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForOrders();
  }

  void listenForOrders({String message}) async {
    final Stream<OrderData> stream = await getOrders();
    stream.listen((OrderData _order) {
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
    final Stream<OrderDataStatus> stream = await getOrderStatus();
    stream.listen((OrderDataStatus _orderStatus) {
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
