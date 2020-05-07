import 'package:order_client_app/src/models/food.dart';

import 'orderFoodExtras.dart';

class FoodOrder {
  double price;
  String foodId;
  double quantity;
  List<OrderFoodExtras> orderFoodsExtras;
  String dateTime;
  FoodOrder();
  Food food;

  FoodOrder.fromJSON(Map<String, dynamic> jsonMap) {
    foodId = jsonMap['id'].toString();

    price = jsonMap['price'] != null ? double.parse(jsonMap["price"]) : 0.0;
    quantity = jsonMap['quantity'] != null
        ? double.parse(jsonMap["quantity"].toString())
        : 0.0;
    food = jsonMap['food'] != null ? Food.fromJSON(jsonMap['food']) : null;
    dateTime = jsonMap['updated_at'] != null ? jsonMap['updated_at'] : "";
    orderFoodsExtras = jsonMap['order_foods_extras'] != null
        ? List.from(jsonMap['order_foods_extras'])
            .map((element) => OrderFoodExtras.fromJSON(element))
            .toList()
        : null;
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["price"] = price;
    map["quantity"] = quantity;
    map["food_id"] = foodId;
    return map;
  }
}
