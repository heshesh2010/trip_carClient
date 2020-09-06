import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/controllers/order_controller.dart';
import 'package:trip_car_client/src/elements/EmptyReviewsWidget.dart';
import 'package:trip_car_client/src/elements/OrderItemWidget.dart';
import 'package:trip_car_client/src/elements/PermissionDeniedWidget.dart';
import 'package:trip_car_client/src/helpers/shimmer_helper.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class OrdersWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  OrdersWidget({Key key, this.parentScaffoldKey}) : super(key: key);

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
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).my_orders,
          style: Theme.of(context)
              .textTheme
              .title
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      key: _con.scaffoldKey,
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : _con.isLoading
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
