import 'package:trip_car_client/src/models/category.dart';
import 'package:trip_car_client/src/models/extra.dart';
import 'package:trip_car_client/src/models/favorite.dart';
import 'package:trip_car_client/src/models/media.dart';
import 'package:trip_car_client/src/models/review.dart';
import 'package:trip_car_client/src/models/size.dart';

class Food {
  String id;
  String name;
  double price;
  double discountPrice;
  Media image;
  String description;
  String ingredients;
  bool featured;
  Category category;
  List<Extra> extras;
  List<Extra> selectedExtras = [];
  List<Review> foodReviews;
  Size size;
  String preparationTime;
  String foodType;
  Favorite favorite;
  bool hasMedia;
  int restaurantId;
  String restaurantName;
  Food();

  Food.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    name = jsonMap['name'];
    price = double.parse(jsonMap["price"]);
    discountPrice = jsonMap['discount_price'] != null
        ? double.parse(jsonMap["discount_price"])
        : null;
    description = jsonMap['description'];
    ingredients = jsonMap['ingredients'];
    featured = jsonMap['featured'] ?? false;
    category = jsonMap['category'] != null
        ? Category.fromJSON(jsonMap['category'])
        : null;
    try {
      image =
          jsonMap['media'] != null ? Media.fromMap(jsonMap['media'][0]) : null;
    } catch (e) {
      image = null;
    }
    extras = jsonMap['extras'] != null
        ? List.from(jsonMap['extras'])
            .map((element) => Extra.fromJSON(element))
            .toList()
        : null;
    if (extras != null) selectedExtras.addAll(extras);
    foodReviews = jsonMap['food_reviews'] != null
        ? List.from(jsonMap['food_reviews'])
            .map((element) => Review.fromJSON(element))
            .toList()
        : null;
    size = jsonMap['size'] != null ? Size.fromJSON(jsonMap['size']) : null;
    preparationTime = jsonMap['preparation_time'];
    foodType = jsonMap['food_type'];
    hasMedia = jsonMap['has_media'];
    restaurantId = jsonMap['restaurant_id'];
    restaurantName = jsonMap['restaurant_name'];
    //favorite = jsonMap['favorite'] != null
    //    ? Favorite.fromJSON(jsonMap['favorite'])
    //    : null;
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["price"] = price;
    map["discountPrice"] = discountPrice;
    map["description"] = description;
    map["ingredients"] = ingredients;
    map["food_type"] = foodType;

    return map;
  }
}
