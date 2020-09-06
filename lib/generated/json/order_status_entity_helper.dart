import 'package:trip_car_client/src/models/order_status_entity.dart';

orderStatusEntityFromJson(OrderStatusEntity data, Map<String, dynamic> json) {
  if (json['data'] != null) {
    data.data = new List<OrderStatusData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new OrderStatusData().fromJson(v));
    });
  }
  if (json['status'] != null) {
    data.status = json['status']?.toInt();
  }
  return data;
}

Map<String, dynamic> orderStatusEntityToJson(OrderStatusEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  data['status'] = entity.status;
  return data;
}

orderStatusDataFromJson(OrderStatusData data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at'];
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at'];
  }
  return data;
}

Map<String, dynamic> orderStatusDataToJson(OrderStatusData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}
