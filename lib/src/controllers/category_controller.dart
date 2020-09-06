import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/category.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/repository/category_repository.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class CategoryController extends ControllerMVC {
  List<CarData> cars = <CarData>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  Category category;
  UserDataUser user = new UserDataUser();

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

  void listenForCarsByCategory({int id, String message}) async {
    final Stream<CarData> stream = await getCarsByCategory(id);
    stream.listen((CarData _car) {
      setState(() {
        cars.add(_car);
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
    cars.clear();
    category = new Category();
    listenForCarsByCategory(message: 'تم تحديث التصنيفات بنجاح');
    listenForCategory(message: 'تم تحديث التصنيفات بنجاح');
  }
}
