import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/models/favorite.dart';
import 'package:order_client_app/src/repository/food_repository.dart';

class FavoriteController extends ControllerMVC {
  List<Favorite> favorites = <Favorite>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  FavoriteController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForFavorites();
  }

  void listenForFavorites({String message}) async {
    final Stream<Favorite> stream = await getFavorites();
    stream.listen((Favorite _favorite) {
      setState(() {
        favorites.add(_favorite);
      });
    }, onError: (a) {
      FlushbarHelper.createError(message: "حدث خطأ بالاتصال").show(context);
    }, onDone: () {
      if (message != null) {
        FlushbarHelper.createSuccess(message: message).show(context);
      }
    });
  }

  Future<void> refreshFavorites() async {
    favorites.clear();
    listenForFavorites(message: 'تم تحديث قائمة المفضلة بنجاح');
  }
}
