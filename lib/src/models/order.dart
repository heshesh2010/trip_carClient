import 'dart:convert';

import 'package:order_client_app/src/models/payment.dart';
import 'package:order_client_app/src/models/restaurant.dart';
import 'package:order_client_app/src/models/user.dart';

import 'food_order.dart';
import 'order_status.dart';

class Order {
  int orderNumber;
  double tax;

  User user;
  String date;
  OrderStatus orderStatus;
  List<FoodOrder> foodOrders;
  String foodType;
  Payment payment;
  Restaurant restaurant;
  Order(
      {this.orderNumber,
      this.tax,
      this.user,
      this.date,
      this.foodOrders,
      this.orderStatus,
      this.foodType,
      this.payment,
      this.restaurant});

  String toJson() => json.encode(toMap());

  Order.fromJSON(Map<String, dynamic> json) {
    orderNumber = json["id"];
    // userId: json["user_id"],
    //orderStatusId: json["order_status_id"],
    // tax = (json["tax"] as num).toDouble();
    // hint: json["hint"],
    date = json["updated_date"].toString();
    //  updatedAt: DateTime.parse(json["updated_at"]),
    // paymentId: json["payment_id"] == null ? null : json["payment_id"],
    //  foodType = json["food_type"];
    payment = json["payment"] == null ? null : Payment.fromMap(json["payment"]);
  

    // customFields: List<dynamic>.from(json["custom_fields"].map((x) => x)),
    user = json['user'] != null ? User.fromJSON(json['user']) : new User();
    orderStatus = json['order_status'] != null
        ? OrderStatus.fromJSON(json['order_status'])
        : new OrderStatus();
    foodOrders = json['food_orders'] != null
        ? List.from(json['food_orders'])
            .map((element) => FoodOrder.fromJSON(element))
            .toList()
        : null;
    restaurant = json['resturant'] != null
        ? Restaurant.fromJSON(json['resturant'])
        : null;
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["tax"] = tax??null; // array
    map["reference_id"] = payment?.referenceId??null; // array
    map["method"] = payment?.method??null; // array
//  map["payment"] = payment.toMap(); // object
    return map;
  }

 Map toMapUpdateStatus() {
    var map = new Map<String, dynamic>();
  //   map["user_id"] = user.id;
  //  map["order_id"] = orderNumber;
    map["status_id"] = orderStatus.id;
//  map["payment"] = payment.toMap(); // object
    return map;
  }


   

}

enum Status { ORDER_RECEIVED, DELIVERED }

final statusValues = EnumValues(
    {"Delivered": Status.DELIVERED, "Order Received": Status.ORDER_RECEIVED});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
