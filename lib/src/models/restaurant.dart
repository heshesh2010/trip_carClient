import 'package:order_client_app/src/models/media.dart';

class Restaurant {
  int id;
  String name;
  Media image;
  double rate;
  String address;
  String description;
  String phone;
  String mobile;
  String information;
  String latitude;
  String longitude;
  double distance;
 int userId;
  Restaurant();

  Restaurant.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        name = jsonMap['name'],
        image = jsonMap['media'] != null
            ? Media.fromJSON(jsonMap['media'][0])
            : null,
        rate = double.parse(jsonMap['rate'].toString()) ?? 0.0,
        address = jsonMap['address'] ?? "",
        description = jsonMap['description'] ?? "",
        phone = jsonMap['phone'] ?? "",
        mobile = jsonMap['mobile'] ?? "",
        information = jsonMap['information'] ?? "",
        latitude = jsonMap['latitude'] ?? "",
        longitude = jsonMap['longitude'] ?? "",
        distance = jsonMap['distance'] != null
            ? double.parse(jsonMap['distance'].toString())
            : 0.0,
userId = jsonMap['user_id'] ?? null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
    };
  }
}
