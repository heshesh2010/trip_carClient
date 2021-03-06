import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/category.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

Future<Stream<Category>> getCategories() async {
  UserDataUser _user = await getCurrentUser();
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}categories';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => Category.fromJSON(data));
}

Future<Stream<CarData>> getCarsByCategory(categoryId) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}cars?category_id=$categoryId';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return CarData().fromJson(data);
  });
}

Future<Stream<Category>> getCategory(int id) async {
  UserDataUser _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}categories/$id';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .map((data) => Category.fromJSON(data));
}
