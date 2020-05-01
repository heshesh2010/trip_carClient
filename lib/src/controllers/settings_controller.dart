import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/models/credit_card.dart';
import 'package:order_client_app/src/models/user.dart';
import 'package:order_client_app/src/repository/user_repository.dart' as repository;

class SettingsController extends ControllerMVC {
  User user = new User();
  CreditCard creditCard = new CreditCard();
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  SettingsController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForUser();
  }

  void update(User user) async {
    repository.update(user).then((value) {
      setState(() {
        //this.favorite = value;
      });
      FlushbarHelper.createSuccess(message: "تم تحديث الملف الشخصي")
          .show(scaffoldKey.currentState.context);
    });
  }

  void updateCreditCard(CreditCard creditCard) {
    repository.setCreditCard(creditCard).then((value) {
      setState(() {});
      FlushbarHelper.createSuccess(message: "تم تحديث معلومات الدفع")
          .show(scaffoldKey.currentState.context);
    });
  }

  void listenForUser() async {
    user = await repository.getCurrentUser();
    creditCard = await repository.getCreditCard();
    setState(() {});
  }

  Future<void> refreshSettings() async {
    user = new User();
    creditCard = new CreditCard();
    listenForUser();
  }
}
