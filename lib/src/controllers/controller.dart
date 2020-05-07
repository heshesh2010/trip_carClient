import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/models/user.dart';
import 'package:order_client_app/src/repository/settings_repository.dart'
    as settingRepo;
import 'package:order_client_app/src/repository/user_repository.dart'
    as userRepo;
import 'package:overlay_support/overlay_support.dart';

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
    var ios = new IOSInitializationSettings();

    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    settingRepo.initSettings().then((setting) {
      setState(() {
        settingRepo.setting = setting;
      });
    });
    settingRepo.setCurrentLocation().then((locationData) {
      setState(() {
        settingRepo.locationData = locationData;
      });
    });
    userRepo.getCurrentUser().then((user) {
      setState(() {
        userRepo.currentUser = user;
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

    showOverlayNotification((context) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 32),
        elevation: 3,
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: ListTile(
            title: Text(fetchedMessage['title'].toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.bold)),
            subtitle: Text(fetchedMessage['body'],
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).backgroundColor)),
          ),
        ),
      );
    }, duration: Duration(seconds: 5));
  }

  Future<void> showDialog(Map<String, dynamic> message) async {
    print(message.toString());

    var fetchedMessage;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    if (Platform.isIOS &&
        int.parse(iosInfo.systemVersion.split('.')[0]) >= 13) {
      fetchedMessage = message['aps']['alert'];
    } else {
      fetchedMessage = message['notification'];
    }

    showOverlayNotification((context) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 32),
        elevation: 3,
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: ListTile(
            title: Text(fetchedMessage['title'].toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.bold)),
            subtitle: Text(fetchedMessage['body'],
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).backgroundColor)),
          ),
        ),
      );
    }, duration: Duration(seconds: 5));
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
    if (userRepo.currentUser.apiToken != null) {
      userRepo.saveToken(token).then((value) {
        if (value is User) {}
      });
    }
  }
}
