import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/models/faq_category.dart';
import 'package:order_client_app/src/models/user.dart';
import 'package:order_client_app/src/repository/faq_repository.dart';
import 'package:order_client_app/src/repository/user_repository.dart';

class FaqController extends ControllerMVC {
  List<FaqCategory> faqs = <FaqCategory>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  User user = new User();

  FaqController() {
    listenForUser();
    scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForFaqs();
  }

  void listenForUser() {
    getCurrentUser().then((_user) {
      setState(() {
        user = _user;
      });
    });
  }

  void listenForFaqs({String message}) async {
    final Stream<FaqCategory> stream = await getFaqCategories();
    stream.listen((FaqCategory _faq) {
      setState(() {
        faqs.add(_faq);
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

  Future<void> refreshFaqs() async {
    faqs.clear();
    listenForFaqs(message: 'تم تحديث الأسئلة الشائعة');
  }
}
