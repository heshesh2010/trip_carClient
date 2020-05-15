import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/notification.dart' as model;
import 'package:trip_car_client/src/repository/notification_repository.dart';

class NotificationController extends ControllerMVC {
  List<model.Notification> notifications = <model.Notification>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  NotificationController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForNotifications();
  }

  void listenForNotifications({String message}) async {
    final Stream<model.Notification> stream = await getNotifications();
    stream.listen((model.Notification _notification) {
      setState(() {
        notifications.add(_notification);
      });
    }, onError: (a) {
      print(a);
      FlushbarHelper.createError(message: "حدث خطأ بالاتصال")
          .show(scaffoldKey.currentState.context);
    }, onDone: () {
      if (message != null) {
        FlushbarHelper.createSuccess(message: message)
            .show(scaffoldKey.currentState.context);
      }
    });
  }

  Future<void> refreshNotifications() async {
    notifications.clear();
    listenForNotifications(message: 'تم تحديث قائمة الاشعارات');
  }
}
