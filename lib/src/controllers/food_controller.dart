import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/cart.dart';
import 'package:trip_car_client/src/models/extra.dart';
import 'package:trip_car_client/src/models/favorite.dart';
import 'package:trip_car_client/src/models/food.dart';
import 'package:trip_car_client/src/models/user.dart';
import 'package:trip_car_client/src/repository/cart_repository.dart';
import 'package:trip_car_client/src/repository/food_repository.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class FoodController extends ControllerMVC {
  Food food;
  double quantity = 1;
  double total = 0;
  Cart cart;
  bool loadCart = false;
  GlobalKey<ScaffoldState> scaffoldKey;
  Favorite favorite;
  User user = new User();

  FoodController() {
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

  void listenForCart() async {
    final Stream<Cart> stream = await getCart();
    stream.listen((Cart _cart) {
      cart = _cart;
    });
  }

  bool isSameRestaurants(Food food) {
    if (cart != null) {
      return cart.food?.restaurantId == food.restaurantId;
    }
    return true;
  }

  void addToCart(Food food, {bool reset = false}) async {
    setState(() {
      this.loadCart = true;
    });
    var _cart = new Cart();
    _cart.food = food;
    _cart.food.selectedExtras =
        food.selectedExtras.where((element) => element.checked).toList();
    //_cart.extras= food.extras.where((element) => element.checked).toList();

    _cart.quantity = this.quantity;
    addCart(_cart, reset).then((value) {
      setState(() {
        this.loadCart = false;
      });
      FlushbarHelper.createInformation(
              message: "تم اضافه الوجبة الى سلة الشراء")
          .show(context);
    });
  }

  void addToFavorite(Food food) async {
    var _favorite = new Favorite();
    _favorite.food = food;
    _favorite.food.extras = food.extras.where((Extra _extra) {
      return _extra.checked;
    }).toList();
    addFavorite(_favorite).then((value) {
      setState(() {
        this.favorite = value;
      });
      FlushbarHelper.createInformation(message: "تم اضافه الوجبة الى المفضلة")
          .show(context);
    });
  }

  void removeFromFavorite(Favorite _favorite) async {
    removeFavorite(_favorite).then((value) {
      setState(() {});
      FlushbarHelper.createInformation(message: "تم حذف الوجبة من المفضله")
          .show(scaffoldKey.currentState.context);
    });
  }

  void calculateTotal() {
    total = food.price ?? 0;
    food.extras.forEach((extra) {
      total += extra.checked ? extra.price : 0;
    });
    total *= quantity;
    setState(() {});
  }

  incrementQuantity() {
    if (this.quantity <= 99) {
      ++this.quantity;
      calculateTotal();
    }
  }

  decrementQuantity() {
    if (this.quantity > 1) {
      --this.quantity;
      calculateTotal();
    }
  }
}
