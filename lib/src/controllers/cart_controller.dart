import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/models/cart.dart';
import 'package:order_client_app/src/models/user.dart';
import 'package:order_client_app/src/repository/cart_repository.dart';
import 'package:order_client_app/src/repository/settings_repository.dart'
    as settingRepo;
import 'package:order_client_app/src/repository/user_repository.dart';

class CartController extends ControllerMVC {
  List<Cart> carts = <Cart>[];
  double taxAmount = 0.0;
  int cartCount = 0;
  double subTotal = 0.0;
  double total = 0.0;
  GlobalKey<ScaffoldState> scaffoldKey;
  User user = new User();

  CartController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForUser();
  }

  void listenForUser() {
    getCurrentUser().then((_user) {
      setState(() {
        user = _user;
      });
    });
  }

  void listenForCarts({String message}) async {
    final Stream<Cart> stream = await getCart();
    stream.listen((Cart _cart) {
      if (!carts.contains(_cart)) {
        setState(() {
          carts.add(_cart);
        });
      }
    }, onError: (a) {
      print(a);
      FlushbarHelper.createError(message: "حدث خطأ بالاتصال").show(context);
    }, onDone: () {
      calculateSubtotal();
      if (message != null) {
        FlushbarHelper.createSuccess(message: message).show(context);
      }
    });
  }

  void listenForCartsCount({String message}) async {
    final Stream<int> stream = await getCartCount();
    stream.listen((int _count) {
      setState(() {
        this.cartCount = _count;
      });
    }, onError: (a) {
      print(a);
      FlushbarHelper.createError(message: "حدث خطأ بالاتصال").show(context);
    });
  }

  Future<void> refreshCarts() async {
    listenForCarts(message: 'تم تحديث سلة المشتريات بنجاح');
  }

  void removeFromCart(Cart _cart) async {
    removeCart(_cart).then((value) {
      setState(() {
        this.carts.remove(_cart);
      });
      FlushbarHelper.createInformation(
              message: " ${_cart.food.name}تم حذف الوجبة ")
          .show(context);
    });
  }

  void calculateSubtotal() async {
    subTotal = 0;
    carts.forEach((cart) {
      subTotal += cart.quantity * cart.food.price;
    });
    taxAmount = subTotal * settingRepo.setting.defaultTax / 100;
    total = subTotal + taxAmount;
    setState(() {});
  }

  incrementQuantity(Cart cart) {
    if (cart.quantity <= 99) {
      ++cart.quantity;
      updateCart(cart);
      calculateSubtotal();
    }
  }

  decrementQuantity(Cart cart) {
    if (cart.quantity > 1) {
      --cart.quantity;
      updateCart(cart);
      calculateSubtotal();
    }
  }
}
