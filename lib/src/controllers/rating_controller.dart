import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/models/food_order.dart';
import 'package:order_client_app/src/models/rating2.dart';
import 'package:order_client_app/src/repository/rate_repository.dart'
    as rateRepo;
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RatingController extends ControllerMVC {
  FoodOrder food;
  GlobalKey<ScaffoldState> scaffoldKey;
  double rateValue;
  String rateComment;
  List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];

  RatingController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void addFoodRating(
      FoodOrder food, RoundedLoadingButtonController btnControllerSave, int index) async {
       //     formKeys[index] = new GlobalKey<FormState>();
  
    if ( formKeys[index].currentState.validate()) {
   
  
    formKeys[index].currentState.save();
      Rate rate =
          new Rate(rate: rateValue??3.0, review: rateComment, foodId: food.foodId);
      rateRepo.addFoodRate(rate).then((value) {
        if (value != null) {
          btnControllerSave.success();
          FlushbarHelper.createSuccess(message: value.message)
              .show(context);
        } else {
          FlushbarHelper.createError(message: value.message)
              .show(context);
          btnControllerSave.error();
          Future.delayed(Duration(seconds: 2)).then((__) {
            btnControllerSave.reset();
          });
        }
      });
  
    } else {
      btnControllerSave.reset();
      FlushbarHelper.createError(message: " يجب تعبئة جميع البيانات")
          .show(context);
    }
    }
  }

