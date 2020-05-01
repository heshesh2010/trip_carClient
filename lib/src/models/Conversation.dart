import 'dart:convert';

import 'package:order_client_app/src/models/user.dart';


import 'order.dart';

class Conversation {
  int id;
  int senderId;
  int receiverId;
  DateTime createdAt;
  DateTime updatedAt;
  int orderId;
  Order order;
  User sender;
  User receiver;

  Conversation(
      {this.id,
      this.senderId,
      this.receiverId,
      this.createdAt,
      this.updatedAt,
      this.orderId,
      this.order,
      this.sender,
      this.receiver});

  factory Conversation.fromJson(String str) =>
      Conversation.fromJSON(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Conversation.fromJSON(Map<String, dynamic> json) => Conversation(
      id: json["id"],
      senderId: json["sender_id"],
      receiverId: json["receiver_id"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      orderId: json["order_id"],
      order: json['order'] != null ? Order.fromJSON(json["order"]) : null,
      sender: json['sender'] != null ? User.fromJSON(json["sender"]) : null,
      receiver:
          json['receiver'] != null ? User.fromJSON(json["receiver"]) : null);

  Map<String, dynamic> toMap() => {
        "id": id,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "order_id": orderId == null ? null : orderId,
      };
}
