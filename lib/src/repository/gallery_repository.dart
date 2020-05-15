import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/gallery.dart';
import 'package:trip_car_client/src/models/user.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

Future<Stream<Gallery>> getGalleries(int idRestaurant) async {
  User _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}galleries?search=restaurant_id:$idRestaurant';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => Gallery.fromJSON(data));
}
