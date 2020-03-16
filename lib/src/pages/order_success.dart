import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/generated/i18n.dart';
import 'package:restaurant_rlutter_ui/src/controllers/checkout_controller.dart';
import 'package:restaurant_rlutter_ui/src/helpers/helper.dart';
import 'package:restaurant_rlutter_ui/src/models/payment.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/repository/settings_repository.dart';

class OrderSuccessWidget extends StatefulWidget {
  RouteArgument routeArgument;
  OrderSuccessWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _OrderSuccessWidgetState createState() => _OrderSuccessWidgetState();
}

class _OrderSuccessWidgetState extends StateMVC<OrderSuccessWidget> {
  CheckoutController _con;

  _OrderSuccessWidgetState() : super(CheckoutController()) {
    _con = controller;
  }

  @override
  void initState() {
    // route param contains the payment method
    _con.payment = new Payment(widget.routeArgument.param);
    _con.listenForCarts(withAddOrder: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
            color: Theme.of(context).hintColor,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context).confirmation,
            style: Theme.of(context).textTheme.title.merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              alignment: AlignmentDirectional.center,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                              Colors.green.withOpacity(1),
                              Colors.green.withOpacity(0.2),
                            ])),
                        child: _con.loading
                            ? Padding(
                                padding: EdgeInsets.all(55),
                                child: CircularProgressIndicator(
                                  valueColor:
                                      new AlwaysStoppedAnimation<Color>(Theme.of(context).scaffoldBackgroundColor),
                                ),
                              )
                            : Icon(
                                Icons.check,
                                color: Theme.of(context).scaffoldBackgroundColor,
                                size: 90,
                              ),
                      ),
                      Positioned(
                        right: -30,
                        bottom: -50,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(150),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -20,
                        top: -50,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(150),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Opacity(
                    opacity: 0.4,
                    child: Text(
                      S.of(context).your_order_has_been_successfully_submitted,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.display2.merge(TextStyle(fontWeight: FontWeight.w300)),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 230,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, -2), blurRadius: 5.0)
                    ]),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              S.of(context).subtotal,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          Helper.getPrice(_con.subTotal, style: Theme.of(context).textTheme.subhead)
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "${S.of(context).tax} (${setting.defaultTax}%)",
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          Helper.getPrice(_con.taxAmount, style: Theme.of(context).textTheme.subhead)
                        ],
                      ),
                      Divider(height: 30),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              S.of(context).total,
                              style: Theme.of(context).textTheme.title.merge(TextStyle(color: Theme.of(context).hintColor)),
                            ),
                          ),
                          Helper.getPrice(_con.total, style: Theme.of(context).textTheme.title,)
                        ],
                      ),

                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/Pages', arguments: 3);
//                                      Navigator.of(context).pushReplacementNamed('/Checkout',
//                                          arguments:
//                                              new RouteArgument(param: [_con.carts, _con.total, setting.defaultTax]));
                          },
                          padding: EdgeInsets.symmetric(vertical: 14),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                          child: Text(
                            S.of(context).my_orders,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Theme.of(context).hintColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}