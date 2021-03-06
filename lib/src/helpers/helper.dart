import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/elements/StrikeThroughWidget.dart';
import 'package:trip_car_client/src/models/setting.dart';
import 'package:trip_car_client/src/repository/settings_repository.dart';

class Helper {
  // for mapping data retrieved form json array
  static getData(Map<String, dynamic> data) {
    return data['data'] ?? [];
  }

  static int getIntData(Map<String, dynamic> data) {
    return (data['data'] as int) ?? 0;
  }

  static getObjectData(Map<String, dynamic> data) {
    return data['data'] ?? new Map<String, dynamic>();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  static Future<Marker> getMarker(Map<String, dynamic> res) async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/img/marker.png', 120);
    final Marker marker = Marker(
        markerId: MarkerId(res['id'].toString()),
        icon: BitmapDescriptor.fromBytes(markerIcon),
//        onTap: () {
//          //print(res.name);
//        },
        anchor: Offset(0.5, 0.5),
        infoWindow: InfoWindow(
            title: res['name'],
            snippet: res['distance'].toStringAsFixed(2) + ' km',
            onTap: () {
              print('infowi tap');
            }),
        position: LatLng(
            double.parse(res['latitude']), double.parse(res['longitude'])));
    return marker;
  }

  static Future<Marker> getMyPositionMarker(
      double latitude, double longitude) async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/img/my_marker.png', 120);
    final Marker marker = Marker(
        markerId: MarkerId(Random().nextInt(100).toString()),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        anchor: Offset(0.5, 0.5),
        position: LatLng(latitude, longitude));

    return marker;
  }

  static List<Icon> getStarsList(double rate) {
    var list = <Icon>[];
    list = List.generate(rate.floor(), (index) {
      return Icon(Icons.star, size: 18, color: Color(0xFFFFB24D));
    });
    if (rate - rate.floor() > 0) {
      list.add(Icon(Icons.star_half, size: 18, color: Color(0xFFFFB24D)));
    }
    list.addAll(
        List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
      return Icon(Icons.star_border, size: 18, color: Color(0xFFFFB24D));
    }));
    return list;
  }

//  static Future<List> getPriceWithCurrency(double myPrice) async {
//    final Setting _settings = await getCurrentSettings();
//    List result = [];
//    if (myPrice != null) {
//      result.add('${myPrice.toStringAsFixed(2)}');
//      if (_settings.currencyRight) {
//        return '${myPrice.toStringAsFixed(2)} ' + _settings.defaultCurrency;
//      } else {
//        return _settings.defaultCurrency + ' ${myPrice.toStringAsFixed(2)}';
//      }
//    }
//    if (_settings.currencyRight) {
//      return '0.00 ' + _settings.defaultCurrency;
//    } else {
//      return _settings.defaultCurrency + ' 0.00';
//    }
//  }

  static FutureBuilder<Setting> getDiscountPrice(double myPrice,
      {TextStyle style}) {
    if (style != null) {
      style = style.merge(TextStyle(fontSize: style.fontSize));
    }
    return FutureBuilder(
      builder: (context, priceSnap) {
        if (priceSnap.connectionState == ConnectionState.none &&
            priceSnap.hasData == false) {
          return Text('');
        }
        return StrikeThroughWidget(
            child: RichText(
          softWrap: false,
          //   overflow: TextOverflow.fade,
          maxLines: 1,
          text: priceSnap.data?.currencyRight != null &&
                  priceSnap.data?.currencyRight == false
              ? TextSpan(
                  text: priceSnap.data?.defaultCurrency,
                  style: style ?? Theme.of(context).textTheme.subtitle1,
                  children: <TextSpan>[
                    TextSpan(
                        text: myPrice.toStringAsFixed(1) ?? '',
                        style: style ?? Theme.of(context).textTheme.subtitle1),
                  ],
                )
              : TextSpan(
                  text: myPrice.toStringAsFixed(1) ?? '',
                  style: style ?? Theme.of(context).textTheme.subtitle1,
                  children: <TextSpan>[
                    TextSpan(
                        text: priceSnap.data?.defaultCurrency,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: style != null
                                ? style.fontSize - 6
                                : Theme.of(context).textTheme.subhead.fontSize -
                                    6)),
                  ],
                ),
        ));
      },
      future: getCurrentSettings(),
    );
  }

  static Widget getPrice(double myPrice, BuildContext context,
      {TextStyle style}) {
    if (style != null) {
      style = style.merge(TextStyle(fontSize: style.fontSize + 2));
    }
    try {
      if (myPrice == 0) {
        return Text('-', style: style ?? Theme.of(context).textTheme.subhead);
      }
      return RichText(
        softWrap: false,
        overflow: TextOverflow.fade,
        maxLines: 1,
        text: TextSpan(
          text: myPrice.toStringAsFixed(2) ?? '',
          style: style ?? Theme.of(context).textTheme.subhead,
          children: <TextSpan>[
            TextSpan(
                text: setting.value?.defaultCurrency,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: style != null
                        ? style.fontSize - 4
                        : Theme.of(context).textTheme.subhead.fontSize - 4)),
          ],
        ),
      );
    } catch (e) {
      return Text('');
    }
  }

  static String getDistance(double distance, BuildContext context) {
    // TODO get unit from settings
    return distance != null
        ? distance.toStringAsFixed(2) + S.of(context).km
        : "";
  }

  static String skipHtml(String htmlString) {
    var document = parse(htmlString);
    String parsedString = parse(document.body.text).documentElement.text;
    return parsedString;
  }

  static String limitString(String text,
      {int limit = 24, String hiddenText = "..."}) {
    return text.substring(0, min<int>(limit, text.length)) +
        (text.length > limit ? hiddenText : '');
  }

  static String getCreditCardNumber(String number) {
    String result = '';
    if (number != null && number.isNotEmpty && number.length == 16) {
      result = number.substring(0, 4);
      result += ' ' + number.substring(4, 8);
      result += ' ' + number.substring(8, 12);
      result += ' ' + number.substring(12, 16);
    }
    return result;
  }

  static String getDateOnly(String date) {
    final DateFormat displayFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormatter = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormatter.parse(date);
    final String formatted = serverFormatter.format(displayDate);
    return formatted;
  }

  static String getTimeOnly(String date) {
    final DateFormat displayFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormatter = DateFormat('HH:mm:ss');
    final DateTime displayDate = displayFormatter.parse(date);
    final String formatted = serverFormatter.format(displayDate);
    return formatted;
  }

  static List decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    // repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negative then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  static List<LatLng> convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }
}
