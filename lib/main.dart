import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:trip_car_client/config/app_config.dart' as config;
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/route_generator.dart';
import 'package:trip_car_client/src/repository/settings_repository.dart'
    as settingRepo;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
        child: DynamicTheme(
            defaultBrightness: Brightness.light,
            data: (brightness) {
              if (brightness == Brightness.light) {
                return ThemeData(
                  fontFamily: 'Tajawal',
                  primaryColor: Colors.white,
                  brightness: brightness,
                  //  primaryIconTheme: IconThemeData(color: Colors.red),
                  accentColor: config.AppColors().mainColor(1), // yellow
                  focusColor: config.AppColors().secondColor(1), // black
                  hintColor: config.AppColors().accentColor(1), // red
                  unselectedWidgetColor:
                      config.AppColors().nonActiveColorLight(1),
                  highlightColor: config.AppColors().shimmerLight(1),
                  textTheme: TextTheme(
                    headline5: TextStyle(
                        fontSize: 20.0,
                        color: config.AppColors().secondColor(1)),
                    headline4: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: config.AppColors().secondColor(1)),
                    headline3: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: config.AppColors().secondColor(1)),
                    headline2: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                        color: config.AppColors().secondColor(1)),
                    headline1: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w300,
                        color: config.AppColors().secondColor(1)),
                    subtitle1: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: config.AppColors().secondColor(1)),
                    headline6: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    bodyText2: TextStyle(
                        fontSize: 12.0,
                        color: config.AppColors().accentColor(1)),
                    bodyText1: TextStyle(
                        fontSize: 14.0,
                        color: config.AppColors().secondColor(1)),
                    caption: TextStyle(
                        fontSize: 12.0,
                        color: config.AppColors().secondColor(1)),
                  ),
                );
              } else {
                return ThemeData(
                  fontFamily: 'Tajawal',
                  primaryColor: Color(0xFF121212),
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor: Color(0xFF2C2C2C),
                  accentColor: config.AppColors().mainDarkColor(1),
                  focusColor: config.AppColors().secondDarkColor(1),
                  hintColor: config.AppColors().accentDarkColor(1),
                  highlightColor: config.AppColors().shimmerLight(1),
                  primaryIconTheme: IconThemeData(
                      color: config.AppColors().secondDarkColor(1)),
                  textTheme: TextTheme(
                    headline5: TextStyle(
                        fontSize: 20.0,
                        color: config.AppColors().secondDarkColor(1)),
                    headline4: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: config.AppColors().secondDarkColor(1)),
                    headline3: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: config.AppColors().secondDarkColor(1)),
                    headline2: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                        color: config.AppColors().mainDarkColor(1)),
                    headline1: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        color: config.AppColors().secondDarkColor(1)),
                    subtitle1: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: config.AppColors().secondDarkColor(1)),
                    headline6: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    bodyText2: TextStyle(
                        fontSize: 12.0,
                        color: config.AppColors().accentDarkColor(1)),
                    bodyText1: TextStyle(
                        fontSize: 14.0,
                        color: config.AppColors().secondDarkColor(1)),
                    caption: TextStyle(
                        fontSize: 12.0,
                        color: config.AppColors().secondDarkColor(0.6)),
                  ),
                );
              }
            },
            themedWidgetBuilder: (context, theme) {
              return ValueListenableBuilder(
                  valueListenable: settingRepo.locale,
                  builder: (context, Locale value, _) {
                    print(value);
                    return MaterialApp(
                      title: 'تطبيق تريب',
                      initialRoute: 'Splash',
                      onGenerateRoute: RouteGenerator.generateRoute,
                      debugShowCheckedModeBanner: false,
                      locale: value,
                      localizationsDelegates: [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        DefaultCupertinoLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: S.delegate.supportedLocales,
                      localeListResolutionCallback: S.delegate
                          .listResolution(fallback: const Locale('ar', '')),
                      navigatorObservers: [],
                      theme: theme,
                    );
                  });
            }));
  }
}
