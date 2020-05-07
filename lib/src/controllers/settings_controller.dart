import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/models/user.dart';
import 'package:order_client_app/src/repository/user_repository.dart'
    as repository;
import 'package:order_client_app/src/repository/user_repository.dart';

class SettingsController extends ControllerMVC {
  User user = new User();
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  bool isLoading=false;
  SettingsController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForUser();
  }

  void updateUser() async {
          setState(() {
          this.isLoading=true;
        });
    repository.update(user).then((value) {
      if (value is User) {
        FlushbarHelper.createSuccess(message: "تم تحديث الملف الشخصي")
            .show(context);
        setCurrentUser(value.toJson());
        setState(() {
           this.isLoading=false;
        });
      } else {
           setState(() {
           this.isLoading=false;
        });
        FlushbarHelper.createError(
                message: "حدث خطأ اثناء تحديث صورة الملف الشخصي")
            .show(context);
      }
    });
  }

  void listenForUser() async {
    user = await repository.getCurrentUser();
    setState(() {});
  }

  Future<void> refreshSettings() async {
    user = new User();
    listenForUser();
  }
}
