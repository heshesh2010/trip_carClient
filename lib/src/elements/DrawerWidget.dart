import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/controllers/profile_controller.dart';
import 'package:trip_car_client/src/repository/settings_repository.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  ProfileController _con;
  Drawer dd;
  _DrawerWidgetState() : super(ProfileController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return dd = _con.user?.apiToken != null
        ? Drawer(
            child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(0.1),
//              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
                  ),
                  accountName: Text(
                    _con.user.name,
                    style: Theme.of(context).textTheme.title,
                  ),
                  accountEmail: Text(
                    _con.user.email,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  currentAccountPicture: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      backgroundImage: _con.user.media != null
                          ? CachedNetworkImageProvider(
                              _con.user.media.first.thumb)
                          : Image.asset('assets/img/default.png').image),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('Pages', arguments: 2);
                },
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).focusColor.withOpacity(1),
                ),
                title: Text(
                  "الرئيسية",
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              ListTile(
                dense: true,
                title: Text(
                  "اعدادت التطبيق",
                  style: Theme.of(context).textTheme.body1,
                ),
                trailing: Icon(
                  Icons.remove,
                  color: Theme.of(context).focusColor.withOpacity(0.3),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('Help');
                },
                leading: Icon(
                  Icons.help,
                  color: Theme.of(context).focusColor.withOpacity(1),
                ),
                title: Text(
                  "الدعم والمساعدة",
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('Settings');
                },
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).focusColor.withOpacity(1),
                ),
                title: Text(
                  "الاعدادت",
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('Languages');
                },
                leading: Icon(
                  Icons.translate,
                  color: Theme.of(context).focusColor.withOpacity(1),
                ),
              ),
              ListTile(
                onTap: () {
                  if (Theme.of(context).brightness == Brightness.dark) {
                    setBrightness(Brightness.light);
                    DynamicTheme.of(context).setBrightness(Brightness.light);
                  } else {
                    setBrightness(Brightness.dark);
                    DynamicTheme.of(context).setBrightness(Brightness.dark);
                  }
                },
                leading: Icon(
                  Icons.brightness_6,
                  color: Theme.of(context).focusColor.withOpacity(1),
                ),
                title: Text(
                  Theme.of(context).brightness == Brightness.dark
                      ? "الوضع النهاري"
                      : "الوضع الليلي",
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              ListTile(
                onTap: () {
                  logout().then((value) {
                    Navigator.of(context)
                        .pushReplacementNamed('Pages', arguments: 2);
                  });
                },
                leading: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).focusColor.withOpacity(1),
                ),
                title: Text(
                  "تسجيل الخروج",
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              ListTile(
                dense: true,
                title: Text(
                  "Version 0.0.1",
                  style: Theme.of(context).textTheme.body1,
                ),
                trailing: Icon(
                  Icons.remove,
                  color: Theme.of(context).focusColor.withOpacity(0.3),
                ),
              ),
            ],
          ))
        : Drawer(
            child: ListView(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('Pages', arguments: 2);
                  },
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    "الرئيسية",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('Help');
                  },
                  leading: Icon(
                    Icons.help,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    "الدعم والمساعدة",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('Settings');
                  },
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    "الاعدادت",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('Languages');
                  },
                  leading: Icon(
                    Icons.translate,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                ),
                ListTile(
                  onTap: () {
                    if (Theme.of(context).brightness == Brightness.dark) {
                      setBrightness(Brightness.light);
                      DynamicTheme.of(context).setBrightness(Brightness.light);
                    } else {
                      setBrightness(Brightness.dark);
                      DynamicTheme.of(context).setBrightness(Brightness.dark);
                    }
                  },
                  leading: Icon(
                    Icons.brightness_6,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    Theme.of(context).brightness == Brightness.dark
                        ? "الوضع النهاري"
                        : "الوضع الليلي",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                ListTile(
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamed("Login");
                    });
                  },
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    "تسجيل الدخول",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                ListTile(
                  dense: true,
                  title: Text(
                    "Version 0.0.1",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Icon(
                    Icons.remove,
                    color: Theme.of(context).focusColor.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          );
  }
}
