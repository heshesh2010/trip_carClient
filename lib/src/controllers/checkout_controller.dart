import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:trip_car_client/src/models/order_entity.dart';
import 'package:trip_car_client/src/models/route_argument.dart';
import 'package:trip_car_client/src/repository/order_repository.dart'
    as orderRepo;
import 'package:trip_car_client/src/repository/user_repository.dart';

class CheckoutController extends ControllerMVC {
  OrderDataPayment payment;
  double taxAmount = 0.0;
  double subTotal = 0.0;
  double total = 0.0;
  bool loading = true;
  GlobalKey<ScaffoldState> scaffoldKey; //so we can call snackbar from anywhere

  CheckoutController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
  void addOrder(OrderData order) async {
    orderRepo.addOrder(order).then((value) {
      if (value is OrderDataPayment) {
        setState(() {
          payment = value;
          loading = false;
        });
      }
    });
  }

  void pay(BuildContext context, OrderData order) {
    MyFatoorah.startPayment(
      context: context,
      request: MyfatoorahRequest(
        currencyIso: Country.SaudiArabia,
        customerEmail: currentUser.value.email,
        customerMobile: currentUser.value.phone,
        customerName: currentUser.value.username,
        successUrl:
            "https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png",
        errorUrl:
            "https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png",
        invoiceAmount: order.payment.price.toDouble(),
        language: ApiLanguage.Arabic,
        token: null,
        afterPaymentBehaviour: AfterPaymentBehaviour.AfterCalbacksExecution,
      ),
    ).then((response) {
      print(response);
      //if response == sucess
      if (response.status.toString().contains("PaymentStatus.Success")) {
        order.payment.refrenceId = int.parse(response.paymentId);
        //payment.method = "دقع الكتروني";

        //payment.tax = taxAmount;
        Navigator.of(context).pushReplacementNamed('OrderSuccess',
            arguments: RouteArgument(order: order));
      }
    }).catchError((error, stackTrace) {
      print("inner: $error");
      print(stackTrace);
//show error and go back
    });
  }
}
