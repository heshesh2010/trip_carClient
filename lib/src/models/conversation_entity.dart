import 'package:trip_car_client/generated/json/base/json_convert_content.dart';
import 'package:trip_car_client/generated/json/base/json_filed.dart';
import 'package:trip_car_client/src/models/car_entity.dart';

class ConversationEntity with JsonConvert<ConversationEntity> {
  List<ConversationData> data;
  int status;
}

class ConversationData with JsonConvert<ConversationData> {
  int id;
  @JSONField(name: "user_id")
  int userId;
  @JSONField(name: "car_id")
  int carId;
  @JSONField(name: "order_id")
  int orderId;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
  ConversationDataOrder order;
  @JSONField(name: "latest_message")
  ConversationDataLatestMessage latestMessage;
  CarData car;
}

class ConversationDataUser with JsonConvert<ConversationDataUser> {
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
  dynamic deviceToken;
}

class ConversationDataOrder with JsonConvert<ConversationDataOrder> {
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
}

class ConversationDataLatestMessage
    with JsonConvert<ConversationDataLatestMessage> {
  int id;
  String sentBy;
  String message;
  int seen;
  @JSONField(name: "conversation_id")
  int conversationId;
  @JSONField(name: "created_at")
  String createdAt;
  @JSONField(name: "updated_at")
  String updatedAt;
}
