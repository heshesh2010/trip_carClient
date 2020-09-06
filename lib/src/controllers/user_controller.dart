import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:trip_car_client/src/elements/showRestPassDialog.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';
import 'package:trip_car_client/src/repository/user_repository.dart'
    as userRepo;

import 'TeddyController.dart';

class UserController extends ControllerMVC {
  UserDataUser user;
  bool hidePassword = true;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> resetPassFirstFormKey;
  GlobalKey<FormState> resetPassFinalFormKey;

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
    signUpFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    _firebaseMessaging = FirebaseMessaging();
    getTos();
    getUser();
    resetPassFirstFormKey = new GlobalKey<FormState>();
    resetPassFinalFormKey = new GlobalKey<FormState>();
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
        print(value.apiToken);
        if (value != null && value.apiToken != null) {
          setCurrentUser(json.encode(value.toJson()));
          btnControllerLogin.success();
          _teddyController.submitPassword(1);
          FlushbarHelper.createSuccess(message: " اهلا بك يا ${value.username}")
              .show(scaffoldKey.currentContext);
          notifyListeners();

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

  void restPassFirstStep(RoundedLoadingButtonController btnControllerRest) {
    if (resetPassFirstFormKey.currentState.validate()) {
      resetPassFirstFormKey.currentState.save();

      userRepo.restPassFirstStep(user).then((value) {
        if (value != null && value.contains("true")) {
          setState(() {
            btnControllerRest.success();
          });
          showRestPassDialog(context, this);
          FlushbarHelper.createSuccess(
                  message: "تم ارسال كود استعاده كلمه المرور عبر الايميل")
              .show(scaffoldKey.currentState.context);
        } else {
          Timer(Duration(seconds: 2), () {
            setState(() {
              btnControllerRest.reset();
            });
          });
          FlushbarHelper.createError(message: value)
              .show(scaffoldKey.currentState.context);
        }
      });
    } else {
      setState(() {
        btnControllerRest.reset();
      });
    }
  }

  void restPassFinalStep(RoundedLoadingButtonController btnControllerSave) {
    if (resetPassFinalFormKey.currentState.validate()) {
      resetPassFinalFormKey.currentState.save();

      userRepo.restPassFinalStep(user).then((value) {
        if (value != null && value.contains("successfully")) {
          setState(() {
            btnControllerSave.success();
          });

          FlushbarHelper.createSuccess(
                  message: "تم اعاده ضبط كلمه المرور الجديدة بنجاح")
              .show(scaffoldKey.currentState.context);
        } else {
          Timer(Duration(seconds: 2), () {
            setState(() {
              btnControllerSave.reset();
            });
          });
          FlushbarHelper.createError(message: value)
              .show(scaffoldKey.currentState.context);
        }
      });
    } else {
      setState(() {
        btnControllerSave.reset();
      });
    }
  }

  void register(RoundedLoadingButtonController btnControllerSave) async {
    if (signUpFormKey.currentState.validate()) {
      signUpFormKey.currentState.save();

      userRepo.register(user).then((value) {
        if (value != null && value.apiToken != null) {
          btnControllerSave.success();
          FlushbarHelper.createSuccess(message: "تم التسجيل بنجاح")
              .show(scaffoldKey.currentContext);
          setCurrentUser(json.encode(value.toJson()));
          Future.delayed(Duration(seconds: 4)).then((__) {
            Navigator.of(scaffoldKey.currentContext)
                .pushReplacementNamed('Pages', arguments: 2);
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
