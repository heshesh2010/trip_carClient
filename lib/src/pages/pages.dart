import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/elements/DrawerWidget.dart';
import 'package:trip_car_client/src/models/route_argument.dart';
import 'package:trip_car_client/src/pages/home.dart';
import 'package:trip_car_client/src/pages/notifications.dart';
import 'package:trip_car_client/src/pages/orders.dart';
import 'package:trip_car_client/src/pages/review.dart';

import 'ChatHomeScreen.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  String currentTitle;
  Widget currentPage;
  RouteArgument routeArgument;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKey2;

  PagesWidget({
    this.scaffoldKey2,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 2;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentTitle = S.of(context).notifications;
          widget.currentPage =
              NotificationsWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentTitle = S.of(context).reviews;
          widget.currentPage =
              ReviewsWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 2:
          widget.currentPage =
              HomeWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 3:
          widget.currentTitle =
              S.of(widget?.scaffoldKey2?.currentContext ?? context).my_orders;
          widget.currentPage =
              OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 4:
          widget.currentTitle =
              S.of(widget?.scaffoldKey2?.currentContext ?? context).chat;
          widget.currentPage =
              ChatHomeScreenWidget(parentScaffoldKey: widget.scaffoldKey);

          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      drawer: DrawerWidget(),
      backgroundColor: Theme.of(context).focusColor,
      body: widget.currentPage,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        color: Theme.of(context).accentColor,
        height: 50,

        // type: BottomNavigationBarType.fixed,
        //    selectedItemColor: Theme.of(context).hintColor,
        // this will be set when a new tab is tapped
        index: widget.currentTab,
        items: <Widget>[
          Icon(Icons.notifications, size: 30),
          Icon(Icons.star, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.local_taxi, size: 30),
          Icon(Icons.chat, size: 30),
        ],
        onTap: (int i) {
          this._selectTab(i);
        },
      ),
    );
  }
}
