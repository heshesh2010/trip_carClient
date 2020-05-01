import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/controllers/controller.dart';
import 'package:order_client_app/src/pages/login.dart';
import 'package:order_client_app/src/pages/pages.dart';
import 'package:order_client_app/src/repository/user_repository.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

import 'home.dart';


class SplashScreenHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreenHome> {
  SplashScreenState() : super(Controller());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),

        child: SplashScreen.navigate(
          name: 'assets/flare/intro.flr',
          next: (context) =>  currentUser.apiToken == null?LoginWidget(): PagesTestWidget(),
          isLoading:  true,
          startAnimation: 'intro',
        ),
      ),
    );
  }
}
