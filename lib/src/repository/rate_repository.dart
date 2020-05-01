import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:order_client_app/src/models/rating2.dart';
import 'package:order_client_app/src/models/user.dart';
import 'package:order_client_app/src/repository/user_repository.dart';

String url;

Future<Rate> addFoodRate(Rate rate) async {
  User _user = await getCurrentUser();

  url = '${GlobalConfiguration().getString('api_base_url')}food_reviews';
  final client = new http.Client();
  Map params = rate.toMap();
  final response = await client.post(
    url,
    headers: {
      'Authorization': 'Bearer ${_user.apiToken}',
      "Content-Type": "application/json"
    },
    body: json.encode(params),
  );

  if (response.statusCode == 200 &&
      json.decode(response.body)['data'].toString().contains("name")) {
    return Rate.fromMap(json.decode(response.body)['data']);
  } else if (response.statusCode == 401 || response.statusCode == 404) {
    rate.message = json.decode(response.body)['message'].toString();
    return rate;
  } else {
    try {
      rate.message = jsonDecode(response.body)['message'].toString();
    } on Exception {
      rate.message = "error";
    } catch (error) {
      rate.message = "خطا";
    }
    return rate;
  }
}
