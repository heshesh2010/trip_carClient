import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:order_client_app/src/helpers/helper.dart';
import 'package:order_client_app/src/models/ad.dart';

Future<Stream<Ad>> getAds() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}ads';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => Ad.fromMap(data));
}

Future<Stream<Ad>> getAd(int id) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}ads/$id';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .map((data) => Ad.fromMap(data));
}
