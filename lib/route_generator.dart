import 'package:flutter/material.dart';
import 'package:order_client_app/src/models/payment.dart';
import 'package:order_client_app/src/models/route_argument.dart';
import 'package:order_client_app/src/pages/cart.dart';
import 'package:order_client_app/src/pages/category.dart';
import 'package:order_client_app/src/pages/checkout.dart';
import 'package:order_client_app/src/pages/debug.dart';
import 'package:order_client_app/src/pages/details.dart';
import 'package:order_client_app/src/pages/food.dart';
import 'package:order_client_app/src/pages/help.dart';
import 'package:order_client_app/src/pages/login.dart';
import 'package:order_client_app/src/pages/map.dart';
import 'package:order_client_app/src/pages/menu_list.dart';
import 'package:order_client_app/src/pages/order_success.dart';
import 'package:order_client_app/src/pages/pages.dart';
import 'package:order_client_app/src/pages/payment_methods.dart';
import 'package:order_client_app/src/pages/profile.dart';
import 'package:order_client_app/src/pages/settings.dart';
import 'package:order_client_app/src/pages/signup.dart';
import 'package:order_client_app/src/pages/splash_screen.dart';
import 'package:order_client_app/src/pages/sumbit_rate.dart';
import 'package:order_client_app/src/pages/tracking.dart';
import 'package:order_client_app/src/pages/walkthrough.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case 'Debug':
        return MaterialPageRoute(
            builder: (_) => DebugWidget(routeArgument: args as RouteArgument));
      case 'Walkthrough':
        return MaterialPageRoute(builder: (_) => Walkthrough());
      case 'Splash':
        return MaterialPageRoute(builder: (_) => SplashScreenHome());
      case 'SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case 'MobileVerification':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case 'MobileVerification2':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case 'Login':
        return MaterialPageRoute(builder: (_) => LoginWidget());
      case 'Pages':
        return MaterialPageRoute(
            builder: (_) => PagesTestWidget(currentTab: args));
      case 'Details':
        return MaterialPageRoute(
            builder: (_) =>
                DetailsWidget(routeArgument: args as RouteArgument));
      case 'Map':
        return MaterialPageRoute(
            builder: (_) => MapWidget(routeArgument: args as RouteArgument));
      case 'Menu':
        return MaterialPageRoute(
            builder: (_) => MenuWidget(routeArgument: args as RouteArgument));
      case 'Food':
        return MaterialPageRoute(
            builder: (_) => FoodWidget(routeArgument: args as RouteArgument));
      case 'Category':
        return MaterialPageRoute(
            builder: (_) =>
                CategoryWidget(routeArgument: args as RouteArgument));
      case 'Cart':
        return MaterialPageRoute(
            builder: (_) => CartWidget(routeArgument: args as RouteArgument));
      case 'Tracking':
        return MaterialPageRoute(
            builder: (_) =>
                TrackingWidget(routeArgument: args as RouteArgument));
      case 'PaymentMethod':
        return MaterialPageRoute(builder: (_) => PaymentMethodsWidget());
      case 'Checkout':
        return MaterialPageRoute(builder: (_) => CheckoutWidget());

  
      case 'PayOnPickup':
        return MaterialPageRoute(
            builder: (_) => OrderSuccessWidget(
              payment: args));
      case 'OrderSuccess':
        return MaterialPageRoute(
            builder: (_) =>
                OrderSuccessWidget(payment: args));
      case 'Help':
        return MaterialPageRoute(builder: (_) => HelpWidget());
      case 'Settings':
        return MaterialPageRoute(builder: (_) => SettingsWidget());
      case 'Profile':
        return MaterialPageRoute(builder: (_) => ProfileWidget());
      case 'submit_rate':
        return MaterialPageRoute(
            builder: (_) => SubmitRate(routeArgument: args as RouteArgument));
      default:
      // If there is no such named route in the switch statement, e.g. /third
      //    return MaterialPageRoute(builder: (_) => PagesTestWidget(currentTab: 2));
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
