import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/repository/settings_repository.dart'
    as settingRepo;
import 'package:trip_car_client/src/repository/user_repository.dart'
    as userRepo;

class Controller extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

  var title = '';

  var body = '';

  Controller() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    settingRepo.initSettings().then((setting) {
      setState(() {
        settingRepo.setting.value = setting;
      });
    });
    settingRepo.setCurrentLocation().then((locationData) {
      setState(() {
        settingRepo.locationData = locationData;
      });
    });
    userRepo.getCurrentUser().then((user) {
      setState(() {
        userRepo.currentUser.value = user;
      });
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        showNotification(message);
        Platform.isIOS ? showDialog(message) : showAndroidDialog(message);

        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        Platform.isIOS ? myBackgroundMessageHandler : null;

        print("onResume: $message");
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token) {
      print(token);
      _saveDeviceToken(token);
    });

    if (Platform.isIOS) {
      _firebaseMessaging.onIosSettingsRegistered.listen((data) {});

      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    } else {}
  }

  Future<void> showAndroidDialog(Map<String, dynamic> message) async {
    print(message.toString());

    var fetchedMessage;

    fetchedMessage = message['notification'];

    showToast(fetchedMessage);
  }

  void showToast(fetchedMessage) {
    showOverlayNotification((context) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 30),
        elevation: 32,
        color: Theme.of(context).primaryColor,
        child: ClipPath(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(
                        color: Theme.of(context).highlightColor, width: 5))),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: ListTile(
                title: Text(fetchedMessage['title'].toString(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.bold)),
                subtitle: Text(fetchedMessage['body'],
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).focusColor)),
                leading: Icon(
                  Icons.notifications,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
          ),
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3))),
        ),
      );
    }, duration: Duration(seconds: 7));
  }

  Future<void> showDialog(Map<String, dynamic> message) async {
    print(message.toString());

    var fetchedMessage;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    if (Platform.isIOS &&
        int.parse(iosInfo.systemVersion.split('.')[0]) <= 13.5) {
      fetchedMessage = message['aps']['alert'];
    } else {
      fetchedMessage = message['notification'];
    }

    showToast(fetchedMessage);
  }

  showNotification(Map<String, dynamic> msg) async {
    var android = new AndroidNotificationDetails(
      '',
      "CHANNLE NAME",
      "channelDescription",
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, msg['notification']['title'], msg['notification']['body'], platform);
  }

  Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      await showNotification(data);
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      await showNotification(notification);
    }
    return Future<void>.value();

    // Or do other work.
  }

  void _saveDeviceToken(String token) {
    if (userRepo.currentUser.value.apiToken != null) {
      userRepo.saveToken(token).then((value) {
        if (value is UserDataUser) {}
      });
    }
  }
}
