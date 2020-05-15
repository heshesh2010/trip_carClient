import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/category.dart';
import 'package:trip_car_client/src/models/food.dart';
import 'package:trip_car_client/src/models/user.dart';
import 'package:trip_car_client/src/repository/category_repository.dart';
import 'package:trip_car_client/src/repository/food_repository.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class CategoryController extends ControllerMVC {
  List<Food> foods = <Food>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  Category category;
  User user = new User();

  CategoryController() {
    listenForUser();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForUser() {
    getCurrentUser().then((_user) {
      setState(() {
        user = _user;
      });
    });
  }

  void listenForFoodsByCategory({int id, String message}) async {
    final Stream<Food> stream = await getFoodsByCategory(id);
    stream.listen((Food _food) {
      setState(() {
        foods.add(_food);
      });
    }, onError: (a) {
      FlushbarHelper.createError(message: "حدث خطأ بالاتصال").show(context);
    }, onDone: () {
      if (message != null) {
        FlushbarHelper.createSuccess(message: message).show(context);
      }
    });
  }

  void listenForCategory({int id, String message}) async {
    final Stream<Category> stream = await getCategory(id);
    stream.listen((Category _category) {
      setState(() => category = _category);
    }, onError: (a) {
      print(a);
      FlushbarHelper.createError(message: "حدث خطأ بالاتصال").show(context);
    }, onDone: () {
      if (message != null) {
        FlushbarHelper.createSuccess(message: message).show(context);
      }
    });
  }

  Future<void> refreshCategory() async {
    foods.clear();
    category = new Category();
    listenForFoodsByCategory(message: 'تم تحديث التصنيفات بنجاح');
    listenForCategory(message: 'تم تحديث التصنيفات بنجاح');
  }
}
