import 'package:trip_car_client/generated/json/base/json_convert_content.dart';
import 'package:trip_car_client/generated/json/base/json_filed.dart';

import 'car_entity.dart';

class UserReviewEntity with JsonConvert<UserReviewEntity> {
  List<UserReviewData> data;
  int status;
}

class UserReviewData with JsonConvert<UserReviewData> {
  int id;
  @JSONField(name: "car_id")
  int carId;
  @JSONField(name: "user_id")
  int userId;
  @JSONField(name: "car_stars")
  int carStars;
  @JSONField(name: "car_comment")
  String carComment;
  @JSONField(name: "created_at")
  String createdAt;
  CarData car;
  String orderId;
  String message;
  UserReviewData.init(this.carStars);
  UserReviewData();
}
