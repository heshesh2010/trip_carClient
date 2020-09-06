import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/order_entity.dart';
import 'package:trip_car_client/src/models/user_entity.dart';

orderEntityFromJson(OrderEntity data, Map<String, dynamic> json) {
  if (json['data'] != null) {
    data.data = new List<OrderData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new OrderData().fromJson(v));
    });
  }
  if (json['status'] != null) {
    data.status = json['status']?.toInt();
  }
  return data;
}

Map<String, dynamic> orderEntityToJson(OrderEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  data['status'] = entity.status;
  return data;
}

orderDataFromJson(OrderData data, Map<String, dynamic> json) {
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
  if (json['car'] != null) {
    data.car = new OrderDataCar().fromJson(json['car']);
  }
  if (json['status'] != null) {
    data.status = new OrderDataStatus().fromJson(json['status']);
  }
  if (json['payment'] != null) {
    data.payment = new OrderDataPayment().fromJson(json['payment']);
  }

  return data;
}

Map<String, dynamic> orderDataSaveToJson(OrderData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.car.id != null) {
    data['car_id'] = entity.car.id;
  }

  if (entity.from != null) {
    data['from'] = entity.from;
  }

  if (entity.to != null) {
    data['to'] = entity.to;
  }

  if (entity.payment.price != null) {
    data['price'] = entity.payment.price;
  }

  if (entity.payment.refrenceId != null) {
    data['refrence_id'] = entity.payment.refrenceId;
  }
  data['method'] = "online";

  return data;
}

Map<String, dynamic> orderDataToJson(OrderData entity) {
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
  if (entity.car != null) {
    data['car'] = entity.car.toJson();
  }
  if (entity.status != null) {
    data['status'] = entity.status.toJson();
  }
  if (entity.payment != null) {
    data['payment'] = entity.payment.toJson();
  }
  return data;
}

orderDataCarFromJson(OrderDataCar data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['color'] != null) {
    data.color = json['color']?.toString();
  }
  if (json['image'] != null) {
    data.image = json['image']?.toString();
  }
  if (json['diriving_license'] != null) {
    data.dirivingLicense = json['diriving_license']?.toString();
  }
  if (json['rent_price_per_day'] != null) {
    data.rentPricePerDay = json['rent_price_per_day']?.toString();
  }
  if (json['max_number_of_kilometers'] != null) {
    data.maxNumberOfKilometers = json['max_number_of_kilometers']?.toString();
  }
  if (json['price_of_increase_kilometers'] != null) {
    data.priceOfIncreaseKilometers =
        json['price_of_increase_kilometers']?.toString();
  }
  if (json['address'] != null) {
    data.address = json['address']?.toString();
  }
  if (json['latitude'] != null) {
    data.latitude = json['latitude']?.toString();
  }
  if (json['longitude'] != null) {
    data.longitude = json['longitude']?.toString();
  }
  if (json['user_id'] != null) {
    data.userId = json['user_id']?.toInt();
  }
  if (json['city_id'] != null) {
    data.cityId = json['city_id']?.toInt();
  }
  if (json['category_id'] != null) {
    data.categoryId = json['category_id']?.toInt();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at']?.toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at']?.toString();
  }
  if (json['model_id'] != null) {
    data.modelId = json['model_id']?.toInt();
  }
  if (json['year_id'] != null) {
    data.yearId = json['year_id']?.toInt();
  }
  if (json['sub_model_id'] != null) {
    data.subModelId = json['sub_model_id']?.toInt();
  }
  if (json['hasImage'] != null) {
    data.hasImage = json['hasImage']?.toInt();
  }
  if (json['user'] != null) {
    data.user = new UserDataUser().fromJson(json['user']);
  }
  if (json['car_reviews'] != null) {
    data.reviews = new List<CarDataReview>();
    (json['car_reviews'] as List).forEach((v) {
      data.reviews.add(new CarDataReview().fromJson(v));
    });
  }
  if (json['carAverageReview'] != null) {
    data.carAverageReview = json['carAverageReview'];
  }
  return data;
}

Map<String, dynamic> orderDataCarToJson(OrderDataCar entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['color'] = entity.color;
  data['image'] = entity.image;
  data['diriving_license'] = entity.dirivingLicense;
  data['rent_price_per_day'] = entity.rentPricePerDay;
  data['max_number_of_kilometers'] = entity.maxNumberOfKilometers;
  data['price_of_increase_kilometers'] = entity.priceOfIncreaseKilometers;
  data['address'] = entity.address;
  data['latitude'] = entity.latitude;
  data['longitude'] = entity.longitude;
  data['user_id'] = entity.userId;
  data['city_id'] = entity.cityId;
  data['category_id'] = entity.categoryId;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  data['model_id'] = entity.modelId;
  data['year_id'] = entity.yearId;
  data['sub_model_id'] = entity.subModelId;
  data['hasImage'] = entity.hasImage;
  return data;
}

orderDataStatusFromJson(OrderDataStatus data, Map<String, dynamic> json) {
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

Map<String, dynamic> orderDataStatusToJson(OrderDataStatus entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

orderDataPaymentFromJson(OrderDataPayment data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['price'] != null) {
    data.price = json['price'].toDouble();
  }
  if (json['refrence_id'] != null) {
    data.refrenceId = json['refrence_id']?.toInt();
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
  return data;
}

Map<String, dynamic> orderDataPaymentToJson(OrderDataPayment entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['price'] = entity.price;
  data['refrence_id'] = entity.refrenceId;
  data['order_id'] = entity.orderId;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}
