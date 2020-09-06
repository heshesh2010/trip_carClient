import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:trip_car_client/generated/json/message_entity_helper.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/message_entity.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

Future<Stream<MessageData>> getMessages(conversationId) async {
  UserDataUser _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}messages/$conversationId?$_apiToken';

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return MessageData().fromJson(data);
    }).timeout(const Duration(seconds: 2));
  } on TimeoutException catch (_) {
    throw "error";
  } on SocketException catch (_) {
    throw "error";
  }
}

String url;

Future<MessageData> updateMessages(
    String message, int orderId, int carId) async {
  UserDataUser _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}';

  MessageData messageOP =
      new MessageData(message: message, orderId: orderId, carId: carId);

  url =
      '${GlobalConfiguration().getString('api_base_url')}save_message?$_apiToken';
  final client = new http.Client();
  final response = await client.post(
    url,
    // headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:"Bearer ${_user.apiToken}"},
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
    },
    body: messageDataToJson(messageOP),
  );
  return MessageData().fromJson(json.decode(response.body)['data']);
}
