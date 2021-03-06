import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/conversation_entity.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

Future<Stream<ConversationData>> getRecentConversations() async {
  UserDataUser _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}';
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}conversation?$_apiToken';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return ConversationData().fromJson(data);
  });
}
