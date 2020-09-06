import 'package:trip_car_client/generated/json/base/json_convert_content.dart';
import 'package:trip_car_client/generated/json/base/json_filed.dart';

class OrderStatusEntity with JsonConvert<OrderStatusEntity> {
  List<OrderStatusData> data;
  int status;
}

class OrderStatusData with JsonConvert<OrderStatusData> {
  int id;
  String name;
  @JSONField(name: "created_at")
  dynamic createdAt;
  @JSONField(name: "updated_at")
  dynamic updatedAt;
}
