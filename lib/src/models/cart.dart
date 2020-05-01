import 'package:order_client_app/src/models/food.dart';

import 'CartExtra.dart';

class Cart {
  String id;
  Food food;
  double quantity;
  int userId;
  List<CartExtra> extras;
  Cart();

  Cart.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    quantity =
        jsonMap['quantity'] != null ? jsonMap['quantity'].toDouble() : 0.0;
    food =
        jsonMap['food'] != null ? Food.fromJSON(jsonMap['food']) : new Food();
    extras = jsonMap['cart_extras'] != null
        ? List<CartExtra>.from(
            jsonMap["cart_extras"].map((x) => CartExtra.fromMap(x)))
        : [];

    food.price = getFoodPrice();
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["quantity"] = quantity;
    map["food_id"] = food.id;
    map["user_id"] = userId;
    map["extras"] = food.selectedExtras.map((element) => element.id).toList();
    return map;
  }

  double getFoodPrice() {
    double result = food.price;
    if (extras.isNotEmpty) {
      extras.forEach((CartExtra extra) {
        result += extra.cartExtra.price != null ? extra.cartExtra.price : 0;
      });
    }
    return result;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }
}
