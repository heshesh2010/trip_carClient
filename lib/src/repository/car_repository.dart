import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/favorite.dart';
import 'package:trip_car_client/src/models/review_entity.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

Future<Stream<CarData>> getTopCars(
    LocationData myLocation, LocationData areaLocation) async {
  UserDataUser _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}most_selles/${myLocation?.latitude ?? 0.0}/${myLocation?.longitude ?? 0.0}';

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

Future<Stream<CarData>> getRecentCars(
    LocationData myLocation, LocationData areaLocation) async {
  UserDataUser _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}last_car_added/${myLocation?.latitude ?? 0.0}/${myLocation?.longitude ?? 0.0}';

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

Future<Stream<CarData>> getNearCars(
    LocationData myLocation, LocationData areaLocation) async {
  UserDataUser _user = await getCurrentUser();
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}the_nearest_car/${myLocation?.latitude ?? 0.0}/${myLocation?.longitude ?? 0.0}';

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

Future<Stream<CarData>> searchCars(int city_id, int model_id, int sub_model_id,
    String search, LocationData location) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}search/$city_id/$model_id/$sub_model_id/$search/${location?.latitude ?? 0.0}/${location?.longitude ?? 0.0}';
  print(url);
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

Future<Stream<ReviewData>> getCarReviews(int id) async {
  UserDataUser _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}restaurant_reviews?with=user&search=restaurant_id:$id';

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

Future<Stream<ReviewData>> getRecentReviews() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}last_review/30.0444/31.2357';

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

Future<Stream<Favorite>> getFavorites() async {
  UserDataUser _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}favorites?${_apiToken}with=food;extras;&search=user_id:${_user.id}&searchFields=user_id:=';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => Favorite.fromJSON(data));
}

Future<Stream<CarDataModel>> getModels() async {
  UserDataUser _user = await getCurrentUser();

  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}models';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => new CarDataModel().fromJson(data));
}

Future<Stream<CarDataSubModel>> getSubModels(modelId) async {
  UserDataUser _user = await getCurrentUser();

  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}subModels/$modelId';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => new CarDataSubModel().fromJson(data));
}

Future<Stream<CarDataYear>> getYears() async {
  UserDataUser _user = await getCurrentUser();

  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}years';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => new CarDataYear().fromJson(data));
}

Future<Stream<CarDataCity>> getCities() async {
  UserDataUser _user = await getCurrentUser();

  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}cities';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => new CarDataCity().fromJson(data));
}
