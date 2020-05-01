import 'package:order_client_app/src/models/category.dart';
import 'package:order_client_app/src/models/extra.dart';
import 'package:order_client_app/src/models/favorite.dart';
import 'package:order_client_app/src/models/media.dart';
import 'package:order_client_app/src/models/restaurant.dart';
import 'package:order_client_app/src/models/review.dart';
import 'package:order_client_app/src/models/size.dart';

class Food {
  String id;
  String name;
  double price;
  double discountPrice;
  Media image;
  String description;
  String ingredients;
  bool featured;
  Restaurant restaurant;
  Category category;
  List<Extra> extras;
  List<Extra> selectedExtras = [];
  List<Review> foodReviews;
  Size size;
  String preparationTime;
  String foodType;
  Favorite favorite;

  Food();

  Food.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    name = jsonMap['name'];
    price = jsonMap['price'].toDouble();
    discountPrice = jsonMap['discount_price'] != null
        ? jsonMap['discount_price'].toDouble()
        : null;
    description = jsonMap['description'];
    ingredients = jsonMap['ingredients'];
    featured = jsonMap['featured'] ?? false;
    restaurant = jsonMap['restaurant'] != null
        ? Restaurant.fromJSON(jsonMap['restaurant'])
        : null;
    category = jsonMap['category'] != null
        ? Category.fromJSON(jsonMap['category'])
        : null;
    image =
        jsonMap['media'] != null ? Media.fromJSON(jsonMap['media'][0]) : null;
    extras = jsonMap['extras'] != null
        ? List.from(jsonMap['extras'])
            .map((element) => Extra.fromJSON(element))
            .toList()
        : null;
    selectedExtras.addAll(extras);
    foodReviews = jsonMap['food_reviews'] != null
        ? List.from(jsonMap['food_reviews'])
            .map((element) => Review.fromJSON(element))
            .toList()
        : null;
    size = jsonMap['size'] != null ? Size.fromJSON(jsonMap['size']) : null;
    preparationTime = jsonMap['preparation_time'];
    foodType = jsonMap['food_type'];
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
