import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:trip_car_client/src/models/user.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';
import 'package:trip_car_client/src/repository/user_repository.dart'
    as userRepo;

import 'TeddyController.dart';

class UserController extends ControllerMVC {
  User user;
  bool hidePassword = true;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  FirebaseMessaging _firebaseMessaging;

  getUser() async {
    this.user = await getCurrentUser();
  }

  GlobalKey<FormState> signUpFormKey;
  TeddyController _teddyController;
  bool isLoading = false;
  String tos = "جارى التحميل";
  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    _firebaseMessaging = FirebaseMessaging();
    getTos();
    getUser();

    _firebaseMessaging.getToken().then((String _deviceToken) {
      user.deviceToken = _deviceToken;
    });
  }

  void getTos() async {
    userRepo.getTos().then((value) {
      if (value != null) {
        setState(() {
          tos = value.description;
        });
      } else {
        FlushbarHelper.createError(message: "حدث خطأ ما")
            .show(scaffoldKey.currentContext);

        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void login(
    teddyController,
    RoundedLoadingButtonController btnControllerLogin,
  ) async {
    _teddyController = teddyController;
    if (loginFormKey.currentState.validate()) {
      _teddyController.coverEyes(false);
      //btnControllerLogin.start();
      loginFormKey.currentState.save();
      userRepo.loginUser(user).then((value) {
        //print(value.apiToken);
        if (value != null && value.apiToken != null) {
          setCurrentUser(value.toJson());
          btnControllerLogin.success();
          _teddyController.submitPassword(1);
          FlushbarHelper.createSuccess(message: " اهلا بك يا ${value.name}")
              .show(scaffoldKey.currentContext);

          Timer(Duration(seconds: 1), () {
            Navigator.of(scaffoldKey.currentContext)
                .pushReplacementNamed('Pages', arguments: 2);
          });
        } else {
          btnControllerLogin.error();
          _teddyController.submitPassword(2);
          Timer(Duration(seconds: 2), () {
            setState(() {
              btnControllerLogin.reset();
            });
          });

          FlushbarHelper.createError(message: value.message)
              .show(scaffoldKey.currentContext);
        }
      });
    }
  }

  void restPassFirstStep(User user) {
    setState(() {
      isLoading = true;
    });
    userRepo.restPassFirstStep(user).then((value) {
      if (value != null) {
        setState(() {
          isLoading = false;
        });
        FlushbarHelper.createSuccess(
                message: "تم ارسال رساله استعاده كلمه المرور ")
            .show(scaffoldKey.currentState.context);
      } else {
        scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(value.message)));
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void register(RoundedLoadingButtonController btnControllerSave) async {
    if (signUpFormKey.currentState.validate()) {
      signUpFormKey.currentState.save();

      userRepo.register(user).then((value) {
        if (value != null && value.apiToken != null) {
          btnControllerSave.success();
          FlushbarHelper.createSuccess(message: value.message)
              .show(scaffoldKey.currentContext);
          //    setCurrentUser(value.toJson());
          Future.delayed(Duration(seconds: 4)).then((__) {
            Navigator.of(scaffoldKey.currentContext)
                .pushReplacementNamed('Login');
          });
        } else {
          FlushbarHelper.createError(message: value.message)
              .show(scaffoldKey.currentContext);
          btnControllerSave.error();
          Future.delayed(Duration(seconds: 2)).then((__) {
            btnControllerSave.reset();
          });
        }
      });
    } else {
      btnControllerSave.reset();
      FlushbarHelper.createError(message: " يجب تعبئة جميع البيانات")
          .show(scaffoldKey.currentContext);
    }
  }
}
