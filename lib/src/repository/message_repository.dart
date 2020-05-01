import 'dart:convert';

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

Future<Message> updateMessages(
    String message, int senderId, int receiverId, int orderId) async {
  User _user = await getCurrentUser();
  Message messageOP = new Message(
      message: message,
      senderId: senderId,
      reciverId: receiverId,
      orderId: orderId);

  url = '${GlobalConfiguration().getString('api_base_url')}save_message';
  final client = new http.Client();
  Map params = messageOP.toMap();
  // params.addAll(_creditCard.toMap());
  final response = await client.post(
    url,
    // headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:"Bearer ${_user.apiToken}"},
    headers: {
      'Authorization': 'Bearer ${_user.apiToken}',
      "Content-Type": "application/json"
    },
    body: json.encode(params),
  );
  return Message.fromMap(json.decode(response.body)['data']);
}
