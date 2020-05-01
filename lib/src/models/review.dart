import 'package:order_client_app/src/models/user.dart';

class Review {
  String id;
  String review;
  double rate;
  User user;

  Review();

  Review.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    review = jsonMap['review'];
    rate = double.parse(jsonMap['rate'].toString()) ?? '0.0';
    user = jsonMap['user'] != null ? User.fromJSON(jsonMap['user']) : null;
  }
}
