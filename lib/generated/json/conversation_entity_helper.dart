import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/conversation_entity.dart';

conversationEntityFromJson(ConversationEntity data, Map<String, dynamic> json) {
  if (json['data'] != null) {
    data.data = new List<ConversationData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new ConversationData().fromJson(v));
    });
  }
  if (json['status'] != null) {
    data.status = json['status']?.toInt();
  }
  return data;
}

Map<String, dynamic> conversationEntityToJson(ConversationEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  data['status'] = entity.status;
  return data;
}

conversationDataFromJson(ConversationData data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['user_id'] != null) {
    data.userId = json['user_id']?.toInt();
  }
  if (json['car_id'] != null) {
    data.carId = json['car_id']?.toInt();
  }
  if (json['order_id'] != null) {
    data.orderId = json['order_id']?.toInt();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at']?.toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at']?.toString();
  }
  if (json['order'] != null) {
    data.order = new ConversationDataOrder().fromJson(json['order']);
  }
  if (json['latest_message'] != null) {
    data.latestMessage =
        new ConversationDataLatestMessage().fromJson(json['latest_message']);
  }
  if (json['car'] != null) {
    data.car = new CarData().fromJson(json['car']);
  }
  return data;
}

Map<String, dynamic> conversationDataToJson(ConversationData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['user_id'] = entity.userId;
  data['car_id'] = entity.carId;
  data['order_id'] = entity.orderId;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  if (entity.order != null) {
    data['order'] = entity.order.toJson();
  }
  if (entity.latestMessage != null) {
    data['latest_message'] = entity.latestMessage.toJson();
  }
  return data;
}

conversationDataUserFromJson(
    ConversationDataUser data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['username'] != null) {
    data.username = json['username']?.toString();
  }
  if (json['fullname'] != null) {
    data.fullname = json['fullname']?.toString();
  }
  if (json['phone'] != null) {
    data.phone = json['phone']?.toString();
  }
  if (json['image'] != null) {
    data.image = json['image']?.toString();
  }
  if (json['email'] != null) {
    data.email = json['email']?.toString();
  }
  if (json['email_verified_at'] != null) {
    data.emailVerifiedAt = json['email_verified_at']?.toString();
  }
  if (json['active'] != null) {
    data.active = json['active']?.toInt();
  }
  if (json['recive_order'] != null) {
    data.reciveOrder = json['recive_order']?.toInt();
  }
  if (json['api_token'] != null) {
    data.apiToken = json['api_token']?.toString();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at']?.toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at']?.toString();
  }
  if (json['hasImage'] != null) {
    data.hasImage = json['hasImage']?.toInt();
  }
  if (json['device_token'] != null) {
    data.deviceToken = json['device_token'];
  }
  return data;
}

Map<String, dynamic> conversationDataUserToJson(ConversationDataUser entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['username'] = entity.username;
  data['fullname'] = entity.fullname;
  data['phone'] = entity.phone;
  data['image'] = entity.image;
  data['email'] = entity.email;
  data['email_verified_at'] = entity.emailVerifiedAt;
  data['active'] = entity.active;
  data['recive_order'] = entity.reciveOrder;
  data['api_token'] = entity.apiToken;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  data['hasImage'] = entity.hasImage;
  data['device_token'] = entity.deviceToken;
  return data;
}

conversationDataOrderFromJson(
    ConversationDataOrder data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['user_id'] != null) {
    data.userId = json['user_id']?.toInt();
  }
  if (json['car_id'] != null) {
    data.carId = json['car_id']?.toInt();
  }
  if (json['status_id'] != null) {
    data.statusId = json['status_id']?.toInt();
  }
  if (json['from'] != null) {
    data.from = json['from']?.toString();
  }
  if (json['to'] != null) {
    data.to = json['to']?.toString();
  }
  if (json['tax'] != null) {
    data.tax = json['tax']?.toInt();
  }
  if (json['start_meter_reading'] != null) {
    data.startMeterReading = json['start_meter_reading']?.toInt();
  }
  if (json['start_image'] != null) {
    data.startImage = json['start_image']?.toString();
  }
  if (json['end_meter_reading'] != null) {
    data.endMeterReading = json['end_meter_reading']?.toInt();
  }
  if (json['end_image'] != null) {
    data.endImage = json['end_image']?.toString();
  }
  if (json['increase_kilometers'] != null) {
    data.increaseKilometers = json['increase_kilometers']?.toInt();
  }
  if (json['increase_kilometers_price'] != null) {
    data.increaseKilometersPrice = json['increase_kilometers_price']?.toInt();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at']?.toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at']?.toString();
  }
  return data;
}

Map<String, dynamic> conversationDataOrderToJson(ConversationDataOrder entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['user_id'] = entity.userId;
  data['car_id'] = entity.carId;
  data['status_id'] = entity.statusId;
  data['from'] = entity.from;
  data['to'] = entity.to;
  data['tax'] = entity.tax;
  data['start_meter_reading'] = entity.startMeterReading;
  data['start_image'] = entity.startImage;
  data['end_meter_reading'] = entity.endMeterReading;
  data['end_image'] = entity.endImage;
  data['increase_kilometers'] = entity.increaseKilometers;
  data['increase_kilometers_price'] = entity.increaseKilometersPrice;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

conversationDataLatestMessageFromJson(
    ConversationDataLatestMessage data, Map<String, dynamic> json) {
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

Map<String, dynamic> conversationDataLatestMessageToJson(
    ConversationDataLatestMessage entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['sentBy'] = entity.sentBy;
  data['message'] = entity.message;
  data['seen'] = entity.seen;
  data['conversation_id'] = entity.conversationId;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}
