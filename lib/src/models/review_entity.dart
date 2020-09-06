import 'package:trip_car_client/generated/json/base/json_convert_content.dart';
import 'package:trip_car_client/generated/json/base/json_filed.dart';
import 'package:trip_car_client/src/models/user_entity.dart';

class ReviewEntity with JsonConvert<ReviewEntity> {
  List<ReviewData> data;
  int status;
}

class ReviewData with JsonConvert<ReviewData> {
  int id;
  int stars;
  String comment;
  @JSONField(name: "user_id")
  int userId;
  @JSONField(name: "car_id")
  int carId;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
  UserDataUser user;
  ReviewDataCar car;
}

class ReviewDataCar with JsonConvert<ReviewDataCar> {
  int id;
  String name;
  String color;
  String image;
  @JSONField(name: "diriving_license")
  String dirivingLicense;
  @JSONField(name: "rent_price_per_day")
  String rentPricePerDay;
  @JSONField(name: "max_number_of_kilometers")
  String maxNumberOfKilometers;
  @JSONField(name: "price_of_increase_kilometers")
  String priceOfIncreaseKilometers;
  String address;
  String latitude;
  String longitude;
  @JSONField(name: "user_id")
  int userId;
  @JSONField(name: "city_id")
  int cityId;
  @JSONField(name: "category_id")
  int categoryId;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
  @JSONField(name: "model_id")
  int modelId;
  @JSONField(name: "year_id")
  int yearId;
  @JSONField(name: "sub_model_id")
  int subModelId;
  int hasImage;
}
