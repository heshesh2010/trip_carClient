import 'package:trip_car_client/src/models/review_entity.dart';
import 'package:trip_car_client/src/models/user_entity.dart';

reviewEntityFromJson(ReviewEntity data, Map<String, dynamic> json) {
  if (json['data'] != null) {
    data.data = new List<ReviewData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new ReviewData().fromJson(v));
    });
  }
  if (json['status'] != null) {
    data.status = json['status']?.toInt();
  }
  return data;
}

Map<String, dynamic> reviewEntityToJson(ReviewEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  data['status'] = entity.status;
  return data;
}

reviewDataFromJson(ReviewData data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['car_stars'] != null) {
    data.stars = json['car_stars']?.toInt();
  }
  if (json['car_comment'] != null) {
    data.comment = json['car_comment']?.toString();
  }
  if (json['user_id'] != null) {
    data.userId = json['user_id']?.toInt();
  }
  if (json['car_id'] != null) {
    data.carId = json['car_id']?.toInt();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at']?.toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at']?.toString();
  }
  if (json['user'] != null) {
    data.user = new UserDataUser().fromJson(json['user']);
  }
  if (json['car'] != null) {
    data.car = new ReviewDataCar().fromJson(json['car']);
  }
  return data;
}

Map<String, dynamic> reviewDataToJson(ReviewData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['stars'] = entity.stars;
  data['comment'] = entity.comment;
  data['user_id'] = entity.userId;
  data['car_id'] = entity.carId;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  if (entity.user != null) {
    data['user'] = entity.user.toJson();
  }
  if (entity.car != null) {
    data['car'] = entity.car.toJson();
  }
  return data;
}

reviewDataCarFromJson(ReviewDataCar data, Map<String, dynamic> json) {
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
  return data;
}

Map<String, dynamic> reviewDataCarToJson(ReviewDataCar entity) {
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
