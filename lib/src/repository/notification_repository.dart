import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/notification.dart';
import 'package:trip_car_client/src/models/user.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

Future<Stream<Notification>> getNotifications() async {
  User _user = await getCurrentUser();
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}notifications?${_apiToken}with=notificationType&search=user_id:${_user.id}&searchFields=user_id:=&orderBy=updated_at&sortedBy=desc&limit=10';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return Notification.fromJSON(data);
  });
}
