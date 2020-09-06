import 'dart:convert';

import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/repository/user_repository.dart'
    as repository;
import 'package:trip_car_client/src/repository/user_repository.dart';

class SettingsController extends ControllerMVC {
  UserDataUser user = new UserDataUser();
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  bool isLoading = false;
  SettingsController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForUser();
  }

  void updateUser() async {
    setState(() {
      this.isLoading = true;
    });
    repository.update(user).then((value) {
      if (value is UserDataUser) {
        FlushbarHelper.createSuccess(message: "تم تحديث الملف الشخصي")
            .show(context);
        value.apiToken = user.apiToken;
        setCurrentUser(json.encode(value.toJson()));
        setState(() {
          this.isLoading = false;
        });
      } else {
        setState(() {
          this.isLoading = false;
        });
        FlushbarHelper.createError(message: value.message).show(context);
      }
    });
  }

  void listenForUser() async {
    user = await repository.getCurrentUser();
    setState(() {});
  }

  Future<void> refreshSettings() async {
    user = new UserDataUser();
    listenForUser();
  }
}
