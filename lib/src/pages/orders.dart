import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/controllers/order_controller.dart';
import 'package:order_client_app/src/elements/EmptyReviewsWidget.dart';
import 'package:order_client_app/src/elements/OrderItemWidget.dart';
import 'package:order_client_app/src/helpers/shimmer_helper.dart';

class OrdersWidget extends StatefulWidget {
  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends StateMVC<OrdersWidget> {
  OrderController _con;

  _OrdersWidgetState() : super(OrderController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.grey);
    return Scaffold(
      key: _con.scaffoldKey,
      body: _con.isLoading
          ? ShimmerHelper(type: Type.complex)
          : _con.orders.isEmpty
              ? EmptyReviewsWidget()
              : LiquidPullToRefresh(
                  //   key: _refreshIndicatorKey,
                  onRefresh: _con.refreshOrders,

                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: _con.orders.length,
                    itemBuilder: (context, index) {
                      return Theme(
                          data: theme,
                          child: OrderItemWidget(
                              order: _con.orders.elementAt(index),
                              orderStatus: _con.orderStatus));
                    },
                  ),
                ),
    );
  }
}
