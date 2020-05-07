import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/generated/i18n.dart';
import 'package:order_client_app/src/controllers/checkout_controller.dart';
import 'package:order_client_app/src/models/route_argument.dart';

class CheckoutWidget extends StatefulWidget {
  final RouteArgument routeArgument;
  CheckoutWidget({Key key, this.routeArgument}) : super(key: key);
  @override
  _CheckoutWidgetState createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends StateMVC<CheckoutWidget> {
  CheckoutController _con;

  _CheckoutWidgetState() : super(CheckoutController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.listenForCarts(withAddOrder: false);
    _con.listenForCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).checkout,
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
    );
  }
}
