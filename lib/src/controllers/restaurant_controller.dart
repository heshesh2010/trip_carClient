import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/review_entity.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/repository/car_repository.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class CarController extends ControllerMVC {
  CarData car;
  List<ReviewData> reviews = <ReviewData>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  UserDataUser user = new UserDataUser();
  CarController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    if (user != null) {
      listenForUser();
    }
  }

  void listenForUser() {
    getCurrentUser().then((_user) {
      setState(() {
        user = _user;
      });
    });
  }

  void listenForCarReviews({int id, String message}) async {
    final Stream<ReviewData> stream = await getCarReviews(id);
    stream.listen((ReviewData _review) {
      setState(() => reviews.add(_review));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> refreshRestaurant() async {
    var _id = car.id;
    car = new CarData();
    reviews.clear();
    listenForCarReviews(id: _id);
  }
}
