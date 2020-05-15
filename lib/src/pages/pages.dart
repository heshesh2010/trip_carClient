import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/elements/DrawerWidget.dart';
import 'package:trip_car_client/src/elements/ShoppingCartButtonWidget.dart';
import 'package:trip_car_client/src/models/user.dart';
import 'package:trip_car_client/src/pages/home.dart';
import 'package:trip_car_client/src/pages/notifications.dart';
import 'package:trip_car_client/src/pages/orders.dart';
import 'package:trip_car_client/src/repository/settings_repository.dart'
    as settingsRepo;
import 'package:trip_car_client/src/repository/user_repository.dart';

import 'ChatHomeScreen.dart';
import 'favorites.dart';

// ignore: must_be_immutable
class PagesTestWidget extends StatefulWidget {
  int currentTab;
  String currentTitle;
  Widget currentPage = HomeWidget();
  GlobalKey navBarGlobalKey = new GlobalKey<ScaffoldState>();

  PagesTestWidget({
    Key key,
    this.currentTab,
  }) {
    currentTab = currentTab != null ? currentTab : 2;
  }

  @override
  _PagesTestWidgetState createState() {
    return _PagesTestWidgetState(this.navBarGlobalKey);
  }
}

class _PagesTestWidgetState extends State<PagesTestWidget> {
  bool isLogged = false;
  GlobalKey navBarGlobalKey;
  _PagesTestWidgetState(this.navBarGlobalKey);

  initState() {
    getCurrentUser().then((value) {
      if (value is User && value?.apiToken != null) {
        setState(() {
          isLogged = true;
        });
      } else {
        setState(() {
          isLogged = false;
        });
      }
    });
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesTestWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    if (this.isLogged) {
      setState(() {
        widget.currentTab = tabItem;
        switch (tabItem) {
          case 0:
            widget.currentTitle = S.of(context).notifications;
            widget.currentPage = NotificationsWidget();
            break;
          case 1:
            widget.currentTitle = S.of(context).chat;
            widget.currentPage = ChatHomeScreenWidget();
            break;
          case 2:
            widget.currentTitle = settingsRepo.setting?.appName;
            widget.currentPage = HomeWidget();
            break;
          case 3:
            widget.currentTitle = "تريباتي";
            widget.currentPage = OrdersWidget();
            break;
          case 4:
            widget.currentTitle = S.of(context).favorites;
            widget.currentPage = FavoritesWidget();

            break;
        }
      });
    } else if (tabItem != 2) {
      FlushbarHelper.createError(
              message: "يجب تسجيل الدخول اولاً من القائمة اليمنى ")
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.currentTitle ??
              settingsRepo.setting?.appName ??
              S.of(context).home,
          style: Theme.of(context)
              .textTheme
              .title
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          isLogged
              ? new ShoppingCartButtonWidget(
                  iconColor: Theme.of(context).hintColor,
                  labelColor: Theme.of(context).focusColor)
              : Container(),
        ],
      ),
      body: widget.currentPage,
      bottomNavigationBar: CurvedNavigationBar(
        key: navBarGlobalKey,
        backgroundColor: Theme.of(context).primaryColor,
        color: Theme.of(context).accentColor,
        // type: BottomNavigationBarType.fixed,
        //    selectedItemColor: Theme.of(context).hintColor,
        // this will be set when a new tab is tapped
        index: 2,
        items: <Widget>[
          Icon(Icons.notifications, size: 30),
          Icon(Icons.rate_review, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.note_add, size: 30),
          Icon(Icons.chat, size: 30),
        ],
        onTap: (int i) {
          this._selectTab(i);
        },
      ),
    );
  }
}
