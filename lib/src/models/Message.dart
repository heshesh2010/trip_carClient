import 'dart:convert';

import 'package:flutter/animation.dart';

class Message {
  int id;
  int conversationId;
  String sentBy;
  String message;
  int seen;
  String createdAt;
  String updatedAt;
  int orderId;
  AnimationController animationController;

  Message({
    this.id,
    this.conversationId,
    this.sentBy,
    this.message,
    this.seen,
    this.createdAt,
    this.updatedAt,
    this.animationController,
    this.orderId,
  });

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json["id"],
        conversationId: json["conversation_id"],
        sentBy: json["sent_by"],
        message: json["message"],
        seen: json["seen"],
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["message"] = message ?? null; // array
    map["order_id"] = orderId.toString() ?? null; // array
    // "seen": seen,
    // "created_at": createdAt.toString(),
    // "updated_at": updatedAt.toString(),
    // "user": user.toMap(),
    return map;
  }
}
