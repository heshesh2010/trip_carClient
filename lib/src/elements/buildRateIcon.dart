import 'package:flutter/material.dart';
import 'package:trip_car_client/generated/i18n.dart';

Widget buildRateIcon(int rateValue, BuildContext context) {
  switch (rateValue) {
    case -1:
      return Text("لا يوجد تقييمات بعد");
    case 0:
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_very_dissatisfied,
            color: Colors.red,
          ),
          Text(S.of(context).angry),
        ],
      );
    case 1:
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied,
            color: Colors.redAccent,
          ),
          Text(S.of(context).not_satisfied),
        ],
      );
    case 2:
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_neutral,
            color: Colors.amber,
          ),
          Text(S.of(context).average_satisfied),
        ],
      );
    case 3:
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_satisfied,
            color: Colors.lightGreen,
          ),
          Text(S.of(context).satisfied),
        ],
      );
    case 4:
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_very_satisfied,
            color: Colors.green,
            size: 40,
          ),
          Text(S.of(context).very_satisfied),
        ],
      );
    default:
      return null;
  }
}
