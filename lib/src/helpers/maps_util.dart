import 'dart:async';
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:order_client_app/src/models/Step.dart';

class MapsUtil {
  static final BASE_URL =
      "https://maps.googleapis.com/maps/api/directions/json?";

  static MapsUtil _instance = new MapsUtil.internal();

  MapsUtil.internal();

  factory MapsUtil() => _instance;
  final JsonDecoder _decoder = new JsonDecoder();

  Future<String> get(String url) {
    return http.get(BASE_URL + url).then((http.Response response) {
      Map values = jsonDecode(response.body);

      return values["routes"][0]["overview_polyline"]["points"];

    });
  }


}
