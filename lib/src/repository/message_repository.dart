import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:order_client_app/src/helpers/helper.dart';
import 'package:order_client_app/src/models/Message.dart';
import 'package:order_client_app/src/models/user.dart';
import 'package:order_client_app/src/repository/user_repository.dart';

Future<Stream<Message>> getMessages(conversationId) async {
  User _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}messages/$conversationId?$_apiToken';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return Message.fromMap(data);
  });
}

String url;

Future<Message> updateMessages(String message, int orderId) async {
  User _user = await getCurrentUser();
  Message messageOP = new Message(message: message, orderId: orderId);
  final String _apiToken = 'api_token=${_user.apiToken}';
  url =
      '${GlobalConfiguration().getString('api_base_url')}save_message?$_apiToken';
  final client = new http.Client();

  final response = await client.post(
    url,
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_user.apiToken}',
      HttpHeaders.acceptHeader: 'application/json',
    },
    body: messageOP.toMap(),
  );
  print(response.statusCode);
  return Message.fromMap(json.decode(response.body)['data']);
}
