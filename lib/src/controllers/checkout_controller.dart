import 'dart:async';

import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:order_client_app/src/models/cart.dart';
import 'package:order_client_app/src/models/order.dart';
import 'package:order_client_app/src/models/payment.dart';
import 'package:order_client_app/src/models/user.dart';
import 'package:order_client_app/src/repository/cart_repository.dart';
import 'package:order_client_app/src/repository/order_repository.dart'
    as orderRepo;
import 'package:order_client_app/src/repository/settings_repository.dart';
import 'package:order_client_app/src/repository/settings_repository.dart'
    as settingRepo;
import 'package:order_client_app/src/repository/user_repository.dart';

class CheckoutController extends ControllerMVC {
  List<Cart> carts = <Cart>[];
  Payment payment;
  double taxAmount = 0.0;
  double subTotal = 0.0;
  double total = 0.0;
  bool loading = true;
  GlobalKey<ScaffoldState> scaffoldKey;
  User currentUser;
  getUser() async {
    this.currentUser = await getCurrentUser();
  }

  CheckoutController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    getUser();
  }

  void listenForCarts({String message, bool withAddOrder = false}) async {
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

      if (withAddOrder != null && withAddOrder == true) {
        addOrder();
      } else {
        pay();
      }
      if (message != null) {
        FlushbarHelper.createSuccess(message: message).show(context);
      }
    });
  }

  void addOrder() async {
    Order _order = new Order();
    _order.tax = setting.defaultTax;
    _order.payment = payment;
    orderRepo.addOrder(_order).then((value) {
      if (value is Payment) {
        setState(() {
          payment = value;
          loading = false;
        });
      }
    });
  }

  void calculateSubtotal() async {
    subTotal = 0;
    carts.forEach((cart) {
      subTotal += cart.quantity * cart.food.price;
    });
    taxAmount = subTotal * settingRepo.setting.defaultTax / 100;
    total = subTotal + taxAmount;
    //payment.price = total;
    setState(() {});
  }

  void pay() {
    MyFatoorah.startPayment(
      context: scaffoldKey.currentState.context,
      request: MyfatoorahRequest(
        currencyIso: Country.SaudiArabia,
        customerEmail: currentUser.email,
        customerMobile: currentUser.phone,
        customerName: currentUser.name,
        successUrl:
            "https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png",
        errorUrl:
            "https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png",
        invoiceAmount: total,
        language: ApiLanguage.Arabic,
        token:
            "bIxjseDjSqVKYmfXTLdOjoBTpFQIdLPMbs1T8COW3QzuhvrIvDY0f-1kYVzj0YcLnMFljQyUMiI4XclP37EB-8ZOZVh0D4N2NEwLEiJ_49OsDsfvFpH-hqp80trFc1VFfcxHE8vW6SDitG7uQvTmqpcqMjFx7jR-wqbRia4IXBre80FEjFGsK_wlf5AETSzPBdUv237O6XG1Ne6n4lcDumZzoJMz6n_MmRvW1NlHYkPjx0atLgKh8VPwcM0B3xAyUiNqaLzrEPdwm-4L0apljNTP90JVnudWOdyULLgXfNCJvoBLoq2-XVtx276nS0lfIQaHkj3WexWlcJAEXhKnEwXsaGfQn9eSTUrzd7Rr07QI78mWY8bgtNPku7UabXmp3OyiU4CtvB0SPRAKTh_uJASCy-ZFb3yzzjwNLYC6wS5Pnxuv9QCS5oPJ77WQ_wFWhEkgvMkYdIROuUzsbRtZXCBvKHCGHc9Da23Mi7DZUWy5fxkraMsBm3COmY1oVf8CkrzMVbkryDayTMB-vUqcQTnSLZTgcBw9GOPhM-4L2rZUABMJgnPwu19klxP8OgfryEIAg8evqkrwazbtSc548BpVD_0tBsxcEWZ_MydkEoQ3lD_04C8j7LZ2sWvXXLS7XE80FPL6ek16iJ8qfik1hYR8CRgzQDLScgNWg6mGqdmBBrF3Fre4kTuDdD0Egrk0qvAY1g",
        afterPaymentBehaviour: AfterPaymentBehaviour.BeforeCalbacksExecution,
      ),
    ).then((response) {
      print(response);
      //if response == sucess
      if (response.status.toString().contains("PaymentStatus.Success")) {
        payment = new Payment();
        payment.referenceId = response.paymentId;
        payment.method = "دقع الكتروني";

        //payment.tax = taxAmount;
        Navigator.of(context)
            .pushReplacementNamed('OrderSuccess', arguments: payment);
      }
    }).catchError((error, stackTrace) {
      print("inner: $error");
      print(stackTrace);
//show error and go back
    });
  }
}
