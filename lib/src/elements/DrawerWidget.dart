import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:share/share.dart';
import 'package:trip_car_client/generated/i18n.dart';
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
    return _con.user?.apiToken != null
        ? Drawer(
            child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                      //       bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                      topLeft: Radius.circular(35)),
                ),
                accountName: Text(
                  _con.user?.username ?? S.of(context).visitor,
                  style: Theme.of(context).textTheme.headline6,
                ),
                accountEmail: Text(
                  _con.user?.email ?? "",
                  style: Theme.of(context).textTheme.caption,
                ),
                currentAccountPicture: CircleAvatar(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: _con.user?.image ?? "",
                    imageBuilder: (context, imageProvider) => Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading2.gif',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
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
                  S.of(context).home,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              ListTile(
                onTap: () {
                  Share.share(S.of(context).share_text +
                      "\n" +
                      S.of(context).iphone +
                      "\n" +
                      " https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1519699940 " +
                      "\n" +
                      S.of(context).android +
                      "\n" +
                      " https://play.google.com/store/apps/details?id=com.hesham.trip_car_client");
                },
                leading: Icon(
                  Icons.share,
                  color: Theme.of(context).focusColor.withOpacity(1),
                ),
                title: Text(
                  S.of(context).share,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('OurWay');
                },
                leading: Icon(
                  Icons.event_note,
                  color: Theme.of(context).focusColor.withOpacity(1),
                ),
                title: Text(
                  S.of(context).ourWay,
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
                  S.of(context).faq,
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
                  S.of(context).profile_settings,
                  style: Theme.of(context).textTheme.subtitle1,
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
                title: Text(
                  S.of(context).languages,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              ListTile(
                onTap: () {
                  if (Theme.of(context).brightness == Brightness.dark) {
                    setBrightness(Brightness.light);
                    setting.value.brightness.value = Brightness.light;
                  } else {
                    setting.value.brightness.value = Brightness.dark;
                    setBrightness(Brightness.dark);
                  }
                  setting.notifyListeners();
                },
                leading: Icon(
                  Icons.brightness_6,
                  color: Theme.of(context).focusColor.withOpacity(1),
                ),
                title: Text(
                  Theme.of(context).brightness == Brightness.dark
                      ? S.of(context).light_mode
                      : S.of(context).night_mode,
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
                  S.of(context).logout,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              ListTile(
                dense: true,
                title: Text(
                  "${S.of(context).version} 1.0.2",
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
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                        //       bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                        topLeft: Radius.circular(35)),
                  ),
                  accountName: Text(
                    _con.user?.username ?? S.of(context).visitor,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  accountEmail: Text(
                    _con.user?.email ?? "",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: _con.user?.image ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading2.gif',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
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
                    S.of(context).home,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Share.share(S.of(context).share_text +
                        "\n" +
                        S.of(context).iphone +
                        "\n" +
                        " https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1519699940 " +
                        "\n" +
                        S.of(context).android +
                        "\n" +
                        " https://play.google.com/store/apps/details?id=com.hesham.trip_car_client");
                  },
                  leading: Icon(
                    Icons.share,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    S.of(context).share,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('OurWay');
                  },
                  leading: Icon(
                    Icons.event_note,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    S.of(context).ourWay,
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
                    S.of(context).faq,
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
                    S.of(context).profile_settings,
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
                  title: Text(
                    S.of(context).languages,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    if (Theme.of(context).brightness == Brightness.dark) {
                      setBrightness(Brightness.light);
                      setting.value.brightness.value = Brightness.light;
                    } else {
                      setting.value.brightness.value = Brightness.dark;
                      setBrightness(Brightness.dark);
                    }
                    setting.notifyListeners();
                  },
                  leading: Icon(
                    Icons.brightness_6,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    Theme.of(context).brightness == Brightness.dark
                        ? S.of(context).light_mode
                        : S.of(context).night_mode,
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
                    S.of(context).login,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                ListTile(
                  dense: true,
                  title: Text(
                    "${S.of(context).version} 1.0.2",
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
