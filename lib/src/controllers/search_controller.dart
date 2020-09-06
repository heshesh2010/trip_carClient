import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/repository/car_repository.dart';
import 'package:trip_car_client/src/repository/search_repository.dart';
import 'package:trip_car_client/src/repository/settings_repository.dart';

class SearchController extends ControllerMVC {
  List<CarData> cars = <CarData>[];
  List<CarDataModel> models = <CarDataModel>[];
  List<CarDataYear> years = <CarDataYear>[];
  List<CarDataCity> cities = <CarDataCity>[];
  List<CarDataSubModel> subModels = <CarDataSubModel>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  bool loading = true;
  CarData car;
  SearchController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    car = new CarData();
    listenForModels();

    listenForCars();
  }

  void listenForModels({String message}) async {
    final Stream<CarDataModel> stream = await getModels();
    stream.listen((CarDataModel _model) {
      setState(() {
        models.add(_model);
      });
    }, onError: (a) {
      print(a);
      FlushbarHelper.createSuccess(message: " تاكد من اتصال الانترنت")
          .show(scaffoldKey.currentContext);
    }, onDone: () {
      listenForCities();
    });
  }

  void listenForSubModels(int modelId, {String message}) async {
    subModels.clear();
    final Stream<CarDataSubModel> stream = await getSubModels(modelId);
    stream.listen((CarDataSubModel _subModel) {
      setState(() {
        subModels.add(_subModel);
      });
    }, onError: (a) {
      print(a);
      FlushbarHelper.createSuccess(message: " تاكد من اتصال الانترنت")
          .show(scaffoldKey.currentContext);
    }, onDone: () {
      //  listenForCities();
    });
  }

  void listenForCities({String message}) async {
    final Stream<CarDataCity> stream = await getCities();
    stream.listen((CarDataCity _city) {
      setState(() {
        cities.add(_city);
      });
    }, onError: (a) {
      print(a);
      FlushbarHelper.createSuccess(message: " تاكد من اتصال الانترنت")
          .show(scaffoldKey.currentContext);
    }, onDone: () {});
  }

  void listenForCars(
      {int city_id,
      int model_id,
      int sub_model_id,
      String search,
      RoundedLoadingButtonController controller}) async {
    LocationData _locationData = await getCurrentLocation();
    final Stream<CarData> stream = await searchCars(
        city_id, model_id, sub_model_id, search, _locationData);
    stream.listen(
        (CarData _car) {
          setState(() => cars.add(_car));
        },
        onError: (a) {},
        onDone: () {
          controller.stop();
        });
  }

  Future<void> refreshSearch(
      {String search,
      CarDataCity selectedCityValue,
      CarDataModel selectedModelValue,
      CarDataSubModel selectedSubModelValue,
      RoundedLoadingButtonController controller}) async {
    cars = <CarData>[];
    listenForCars(
        search: search ?? null,
        city_id: selectedCityValue?.id ?? null,
        model_id: selectedModelValue?.id ?? null,
        sub_model_id: selectedSubModelValue?.id ?? null,
        controller: controller);
  }

  void saveSearch(String search) {
    setRecentSearch(search);
  }
}
