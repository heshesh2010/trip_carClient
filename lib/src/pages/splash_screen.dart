import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/controllers/controller.dart';
import 'package:trip_car_client/src/pages/pages.dart';

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
          next: (context) => PagesTestWidget(),
          isLoading: true,
          startAnimation: 'intro',
        ),
      ),
    );
  }
}
