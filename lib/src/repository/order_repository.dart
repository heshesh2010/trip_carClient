import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/order.dart';
import 'package:trip_car_client/src/models/order_status.dart';
import 'package:trip_car_client/src/models/payment.dart';
import 'package:trip_car_client/src/models/user.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

Future<Stream<Order>> getOrders() async {
  User _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}orders?${_apiToken}with=user;foodOrders;foodOrders.food;orderStatus&search=user.id:${_user.id}&searchFields=user.id:=&orderBy=id&sortedBy=desc';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return Order.fromJSON(data);
  });
}

Future<Stream<Order>> getOrder(orderId) async {
  User _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}orders/$orderId?${_apiToken}with=user;foodOrders;foodOrders.food;orderStatus';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .map((data) {
    return Order.fromJSON(data);
  });
}

Future<Stream<Order>> getRecentOrders() async {
  User _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}orders?${_apiToken}with=user;foodOrders;foodOrders.food;orderStatus&search=user.id:${_user.id}&searchFields=user.id:=&orderBy=updated_at&sortedBy=desc&limit=3';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return Order.fromJSON(data);
  });
}

Future<Stream<OrderStatus>> getOrderStatus() async {
  User _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}';
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
    return OrderStatus.fromJSON(data);
  });
}

Future<Payment> addOrder(Order order) async {
  User _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}orders';
  final client = new http.Client();
  Map params = order.toMap();
  final response = await client.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      //     HttpHeaders.contentTypeHeader: 'application/json',
      //   HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",

      HttpHeaders.authorizationHeader: "Bearer ${_user.apiToken}"
    },
    body: json.encode(params),
  );
  print(response.body);
  return Payment.fromMap(json.decode(response.body)['data']);
}

String url;
Future<Order> updateOrder(Order order) async {
  User _user = await getCurrentUser();

  url = '${GlobalConfiguration().getString('api_base_url')}updateOrder/' +
      order.orderNumber.toString();
  final client = new http.Client();
  Map params = order.toMapUpdateStatus();
  // params.addAll(_creditCard.toMap());
  final response = await client.post(
    url,
    // headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:"Bearer ${_user.apiToken}"},
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer ${_user.apiToken}"
    },

    body: json.encode(params),
  );
  return Order.fromJSON(json.decode(response.body)['data']);
}
