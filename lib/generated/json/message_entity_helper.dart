import 'package:trip_car_client/src/models/message_entity.dart';

messageEntityFromJson(MessageEntity data, Map<String, dynamic> json) {
  if (json['data'] != null) {
    data.data = new List<MessageData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new MessageData().fromJson(v));
    });
  }
  if (json['status'] != null) {
    data.status = json['status']?.toInt();
  }
  return data;
}

Map<String, dynamic> messageEntityToJson(MessageEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  data['status'] = entity.status;
  return data;
}

messageDataFromJson(MessageData data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['sentBy'] != null) {
    data.sentBy = json['sentBy']?.toString();
  }
  if (json['message'] != null) {
    data.message = json['message']?.toString();
  }
  if (json['seen'] != null) {
    data.seen = json['seen']?.toInt();
  }
  if (json['conversation_id'] != null) {
    data.conversationId = json['conversation_id']?.toInt();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at']?.toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at']?.toString();
  }
  return data;
}

Map<String, dynamic> messageDataToJson(MessageData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  // data['id'] = entity.id;
  // data['sentBy'] = entity.sentBy;
  data['message'] = entity.message;
//  data['seen'] = entity.seen;
//  data['conversation_id'] = entity.conversationId;
//  data['created_at'] = entity.createdAt;
//  data['updated_at'] = entity.updatedAt;
  data['order_id'] = entity.orderId.toString();

  return data;
}
