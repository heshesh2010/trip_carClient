import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:order_client_app/src/controllers/user_controller.dart';

void showTosDialog(BuildContext context, UserController con) {
  final ThemeData themeData = Theme.of(context);
  final TextStyle aboutTextStyle = themeData.textTheme.body1;
  final TextStyle linkStyle =
      themeData.textTheme.body2.copyWith(color: themeData.accentColor);

  showAboutDialog(
    context: context,
    applicationLegalese: 'اتفاقية الأستخدام',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                style: aboutTextStyle,
                text: con.tos,
              ),
              /*  _LinkTextSpan(
                style: linkStyle,
                url: 'https://flutter.dev',
              ),*/
              TextSpan(
                style: aboutTextStyle,
                text:
                    '.\n\nTo see the source code for this app, please visit the ',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '.',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
