import 'package:trip_car_client/generated/json/base/json_convert_content.dart';
import 'package:trip_car_client/generated/json/base/json_filed.dart';
import 'package:trip_car_client/src/models/user_entity.dart';

class CarEntity with JsonConvert<CarEntity> {
  List<CarData> data;
  int status;
}

class CarData with JsonConvert<CarData> {
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
  CarDataCity city;
  CarDataModel model;
  CarDataYear year;
  @JSONField(name: "sub_model")
  CarDataSubModel subModel;
  List<CarDataReview> reviews;
  CarDataCategory category;
  CarDataUser user;
  @JSONField(name: "available_dates")
  List<CarDataAvailableDate> availableDates;
  double carAverageReview;
  double distance;
}

class CarDataCity with JsonConvert<CarDataCity> {
  int id;
  String name;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
}

class CarDataModel with JsonConvert<CarDataModel> {
  int id;
  String name;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
}

class CarDataYear with JsonConvert<CarDataYear> {
  int id;
  String name;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
}

class CarDataSubModel with JsonConvert<CarDataSubModel> {
  int id;
  String name;
  @JSONField(name: "model_id")
  int modelId;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
}

class CarDataReview with JsonConvert<CarDataReview> {
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
}

class CarDataCategory with JsonConvert<CarDataCategory> {
  int id;
  String name;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
}

class CarDataUser with JsonConvert<CarDataUser> {
  int id;
  String username;
  String fullname;
  String phone;
  String image;
  String email;
  @JSONField(name: "email_verified_at")
  String emailVerifiedAt;
  int active;
  @JSONField(name: "recive_order")
  int reciveOrder;
  @JSONField(name: "api_token")
  String apiToken;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
  int hasImage;
  @JSONField(name: "device_token")
  String deviceToken;
}

class CarDataAvailableDate with JsonConvert<CarDataAvailableDate> {
  int id;
  @JSONField(name: "car_id")
  int carId;
  String from;
  String to;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
}
