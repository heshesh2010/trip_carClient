class Notification {
  String id;
  String title;
  int read;
  DateTime dateTime;

  Notification();

  Notification.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    title = jsonMap['title'] != null ? jsonMap['title'].toString() : '';
    read = jsonMap['read'] ?? false;
    dateTime = DateTime.parse(jsonMap['updated_at']);
  }
}
