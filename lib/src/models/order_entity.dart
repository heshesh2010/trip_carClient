import 'package:trip_car_client/generated/json/base/json_convert_content.dart';
import 'package:trip_car_client/generated/json/base/json_filed.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/user_entity.dart';

class OrderEntity with JsonConvert<OrderEntity> {
  List<OrderData> data;
  int status;
}

class OrderData with JsonConvert<OrderData> {
  int id;
  @JSONField(name: "user_id")
  int userId;
  @JSONField(name: "car_id")
  int carId;
  @JSONField(name: "status_id")
  int statusId;
  String from;
  String to;
  int tax;
  @JSONField(name: "start_meter_reading")
  int startMeterReading;
  @JSONField(name: "start_image")
  String startImage;
  @JSONField(name: "end_meter_reading")
  int endMeterReading;
  @JSONField(name: "end_image")
  String endImage;
  @JSONField(name: "increase_kilometers")
  int increaseKilometers;
  @JSONField(name: "increase_kilometers_price")
  int increaseKilometersPrice;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
  OrderDataCar car = new OrderDataCar();
  OrderDataStatus status;
  OrderDataPayment payment = new OrderDataPayment();
}

class OrderDataCar with JsonConvert<OrderDataCar> {
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
  List<CarDataReview> reviews;
  UserDataUser user;
  int carAverageReview;
}

class OrderDataStatus with JsonConvert<OrderDataStatus> {
  int id;
  String name;
  @JSONField(name: "created_at")
  dynamic createdAt;
  @JSONField(name: "updated_at")
  dynamic updatedAt;
}

class OrderDataPayment with JsonConvert<OrderDataPayment> {
  int id;
  double price;
  @JSONField(name: "refrence_id")
  int refrenceId;
  @JSONField(name: "order_id")
  int orderId;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
  String method;

  OrderDataPayment({this.method});
}
