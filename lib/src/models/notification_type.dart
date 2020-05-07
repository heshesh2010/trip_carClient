import 'package:order_client_app/src/models/media.dart';

class NotificationType {
  String id;
  String type;
  Media image;

  NotificationType();

  NotificationType.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    type = jsonMap['type'] != null ? jsonMap['type'].toString() : '';
    image =
        jsonMap['media'] != null ? Media.fromMap(jsonMap['media'][0]) : null;
  }
}
