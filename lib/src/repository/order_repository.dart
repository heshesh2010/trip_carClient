import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:trip_car_client/generated/json/order_entity_helper.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/order_entity.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

Future<Stream<OrderData>> getOrders() async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  if (currentUser.value.apiToken == null) {
    return new Stream.value(null);
  }
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}myOrder?$_apiToken';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return OrderData().fromJson(data);
  });
}

Future<Stream<OrderDataStatus>> getOrderStatus() async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}order_statuses?$_apiToken';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return OrderDataStatus().fromJson(data);
  });
}

Future<OrderDataPayment> addOrder(OrderData order) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}payment?$_apiToken';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      //     HttpHeaders.contentTypeHeader: 'application/json',
      //HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
    },
    body: json.encode(orderDataSaveToJson(order)),
  );
  print(response.body);
  return OrderDataPayment().fromJson(json.decode(response.body)['data']);
}
