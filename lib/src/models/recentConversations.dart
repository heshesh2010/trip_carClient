import 'dart:convert';

import 'package:order_client_app/src/models/restaurant.dart';

import 'Message.dart';
import 'order.dart';

class RecentConversations {
  int id;
  int userId;
  int restaurantId;
  String createdAt;
  String updatedAt;
  int orderId;
  Restaurant restaurant;
  Order order;
  Message message;

  RecentConversations({
    this.id,
    this.userId,
    this.restaurantId,
    this.createdAt,
    this.updatedAt,
    this.orderId,
    this.restaurant,
    this.order,
    this.message,
  });

  factory RecentConversations.fromJson(String str) =>
      RecentConversations.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecentConversations.fromMap(Map<String, dynamic> json) =>
      RecentConversations(
        id: json["id"],
        userId: json["user_id"],
        restaurantId: json["restaurant_id"],
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        orderId: json["order_id"],
        restaurant: Restaurant.fromJSON(json["restaurant"]),
        order: Order.fromJSON(json["order"]),
        message: json["latest_message"] != null
            ? Message.fromMap(json["latest_message"])
            : json["message"] != null ? Message.fromMap(json["message"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "message": message.toMap(),
      };
}
