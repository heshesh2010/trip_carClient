import 'package:flutter/animation.dart';
import 'package:trip_car_client/generated/json/base/json_convert_content.dart';
import 'package:trip_car_client/generated/json/base/json_filed.dart';

class MessageEntity with JsonConvert<MessageEntity> {
  List<MessageData> data;
  int status;
}

class MessageData with JsonConvert<MessageData> {
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
  int orderId;
  AnimationController animationController;
  int carId;
  MessageData({
    this.id,
    this.conversationId,
    this.sentBy,
    this.message,
    this.seen,
    this.createdAt,
    this.updatedAt,
    this.animationController,
    this.orderId,
    this.carId,
  });
}
