import 'extra.dart';

class OrderFoodExtras {
  double price;
  Extra extra;
  OrderFoodExtras();

  OrderFoodExtras.fromJSON(Map<String, dynamic> jsonMap)
      : price =
            jsonMap['price'] != null ? double.parse(jsonMap["price"]) : null,
        extra =
            jsonMap['extra'] != null ? Extra.fromJSON(jsonMap['extra']) : null;
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["price"] = price;
    return map;
  }
}
