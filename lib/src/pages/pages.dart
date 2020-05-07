import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:order_client_app/generated/i18n.dart';
import 'package:order_client_app/src/elements/DrawerWidget.dart';
import 'package:order_client_app/src/elements/ShoppingCartButtonWidget.dart';
import 'package:order_client_app/src/models/user.dart';
import 'package:order_client_app/src/pages/home.dart';
import 'package:order_client_app/src/pages/notifications.dart';
import 'package:order_client_app/src/pages/orders.dart';
import 'package:order_client_app/src/repository/settings_repository.dart'
    as settingsRepo;
import 'package:order_client_app/src/repository/user_repository.dart';

import 'ChatHomeScreen.dart';
import 'favorites.dart';

// ignore: must_be_immutable
class PagesTestWidget extends StatefulWidget {
  int currentTab;
  String currentTitle;
  Widget currentPage = HomeWidget();
  PagesTestWidget({
    Key key,
    this.currentTab,
  }) {
    currentTab = currentTab != null ? currentTab : 2;
  }

  @override
  _PagesTestWidgetState createState() {
    return _PagesTestWidgetState();
  }
}

class _PagesTestWidgetState extends State<PagesTestWidget> {
  bool isLogged = false;

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
            widget.currentTitle = "اوردراتي";
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).hintColor,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 22,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        selectedIconTheme: IconThemeData(size: 28),
        unselectedItemColor:
            Theme.of(context).unselectedWidgetColor.withOpacity(1),
        currentIndex: widget.currentTab,
        onTap: (int i) {
          this._selectTab(i);
        },
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
              title: new Container(height: 5.0),
              icon: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).focusColor.withOpacity(0.4),
                        blurRadius: 40,
                        offset: Offset(0, 15)),
                    BoxShadow(
                        color: Theme.of(context).focusColor.withOpacity(0.4),
                        blurRadius: 13,
                        offset: Offset(0, 3))
                  ],
                ),
                child: new Icon(Icons.home, color: Theme.of(context).hintColor),
              )),
          BottomNavigationBarItem(
            icon: new Icon(Icons.fastfood),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite),
            title: new Container(height: 0.0),
          ),
        ],
      ),
    );
  }
}
