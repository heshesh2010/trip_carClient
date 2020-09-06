import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/order_entity.dart';
import 'package:trip_car_client/src/models/review_entity.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/models/user_review_entity.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

Future<Stream<ReviewData>> getReviews() async {
  UserDataUser _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}';
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}myReview?$_apiToken';
//TODO: error and should add api header as well .
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return ReviewData().fromJson(data);
  });
}

Future<UserReviewData> addUserReview(
    UserReviewData review, OrderData orderData) async {
  UserDataUser _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}addCarReview?$_apiToken';
  final client = new http.Client();

  try {
    final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(review.toJson()),
    );
    if (response.statusCode == 200) {
      return UserReviewData().fromJson(json.decode(response.body)['data']);
    } else {
      return review..message = "حدث خطأ";
    }
  } catch (e) {
    return review..message = "حدث خطأ";
  }
}
