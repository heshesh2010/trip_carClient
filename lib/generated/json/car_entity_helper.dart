import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/user_entity.dart';

carEntityFromJson(CarEntity data, Map<String, dynamic> json) {
  if (json['data'] != null) {
    data.data = new List<CarData>();
    (json['data'] as List).forEach((v) {
      data.data.add(new CarData().fromJson(v));
    });
  }
  if (json['status'] != null) {
    data.status = json['status']?.toInt();
  }
  return data;
}

Map<String, dynamic> carEntityToJson(CarEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.data != null) {
    data['data'] = entity.data.map((v) => v.toJson()).toList();
  }
  data['status'] = entity.status;
  return data;
}

carDataFromJson(CarData data, Map<String, dynamic> json) {
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
  if (json['carAverageReview'] != null) {
    data.carAverageReview =
        double.parse(json['carAverageReview'].toString()) ?? 0.0;
  }

  if (json['distance'] != null) {
    data.distance = double.parse(json['distance'].toString()) ?? 0.0;
  }

  if (json['sub_model_id'] != null) {
    data.subModelId = json['sub_model_id']?.toInt();
  }
  if (json['hasImage'] != null) {
    data.hasImage = json['hasImage']?.toInt();
  }
  if (json['city'] != null) {
    data.city = new CarDataCity().fromJson(json['city']);
  }
  if (json['model'] != null) {
    data.model = new CarDataModel().fromJson(json['model']);
  }
  if (json['year'] != null) {
    data.year = new CarDataYear().fromJson(json['year']);
  }
  if (json['sub_model'] != null) {
    data.subModel = new CarDataSubModel().fromJson(json['sub_model']);
  }
  if (json['car_reviews'] != null) {
    data.reviews = new List<CarDataReview>();
    (json['car_reviews'] as List).forEach((v) {
      data.reviews.add(new CarDataReview().fromJson(v));
    });
  }
  if (json['category'] != null) {
    data.category = new CarDataCategory().fromJson(json['category']);
  }
  if (json['user'] != null) {
    data.user = new CarDataUser().fromJson(json['user']);
  }
  if (json['available_dates'] != null) {
    data.availableDates = new List<CarDataAvailableDate>();
    data.availableDates
        .add(new CarDataAvailableDate().fromJson(json['available_dates']));
  }
  return data;
}

Map<String, dynamic> carDataToJson(CarData entity) {
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
  if (entity.city != null) {
    data['city'] = entity.city.toJson();
  }
  if (entity.model != null) {
    data['model'] = entity.model.toJson();
  }
  if (entity.year != null) {
    data['year'] = entity.year.toJson();
  }
  if (entity.subModel != null) {
    data['sub_model'] = entity.subModel.toJson();
  }
  if (entity.reviews != null) {
    data['reviews'] = entity.reviews.map((v) => v.toJson()).toList();
  }
  if (entity.category != null) {
    data['category'] = entity.category.toJson();
  }
  if (entity.user != null) {
    data['user'] = entity.user.toJson();
  }
  if (entity.availableDates != null) {
    data['available_dates'] =
        entity.availableDates.map((v) => v.toJson()).toList();
  }
  return data;
}

carDataCityFromJson(CarDataCity data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at']?.toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at']?.toString();
  }
  return data;
}

Map<String, dynamic> carDataCityToJson(CarDataCity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

carDataModelFromJson(CarDataModel data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at']?.toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at']?.toString();
  }
  return data;
}

Map<String, dynamic> carDataModelToJson(CarDataModel entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

carDataYearFromJson(CarDataYear data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at']?.toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at']?.toString();
  }
  return data;
}

Map<String, dynamic> carDataYearToJson(CarDataYear entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

carDataSubModelFromJson(CarDataSubModel data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['model_id'] != null) {
    data.modelId = json['model_id']?.toInt();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at']?.toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at']?.toString();
  }
  return data;
}

Map<String, dynamic> carDataSubModelToJson(CarDataSubModel entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['model_id'] = entity.modelId;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

carDataReviewFromJson(CarDataReview data, Map<String, dynamic> json) {
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
  if (json['user'] != null) {
    data.user = new UserDataUser().fromJson(json['user']);
  }

  return data;
}

Map<String, dynamic> carDataReviewToJson(CarDataReview entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['stars'] = entity.stars;
  data['comment'] = entity.comment;
  data['user_id'] = entity.userId;
  data['car_id'] = entity.carId;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

carDataCategoryFromJson(CarDataCategory data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at']?.toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at']?.toString();
  }
  return data;
}

Map<String, dynamic> carDataCategoryToJson(CarDataCategory entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

carDataUserFromJson(CarDataUser data, Map<String, dynamic> json) {
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
    data.deviceToken = json['device_token']?.toString();
  }
  return data;
}

Map<String, dynamic> carDataUserToJson(CarDataUser entity) {
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

carDataAvailableDateFromJson(
    CarDataAvailableDate data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toInt();
  }
  if (json['car_id'] != null) {
    data.carId = json['car_id']?.toInt();
  }
  if (json['from'] != null) {
    data.from = json['from']?.toString();
  }
  if (json['to'] != null) {
    data.to = json['to']?.toString();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at']?.toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at']?.toString();
  }
  return data;
}

Map<String, dynamic> carDataAvailableDateToJson(CarDataAvailableDate entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['car_id'] = entity.carId;
  data['from'] = entity.from;
  data['to'] = entity.to;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}
