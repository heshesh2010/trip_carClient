import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:order_client_app/src/models/user.dart';

class Message {
  int id;
  int conversationId;
  int userId;
  String message;
  int seen;
  String createdAt;
  String updatedAt;
  User user;
  int senderId;
  int reciverId;
 AnimationController animationController;
int orderId;
  Message({
    this.id,
    this.conversationId,
    this.userId,
    this.message,
    this.seen,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.reciverId,
    this.senderId,
    this.animationController, 
    this.orderId
  });

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
    id: json["id"],
    conversationId: json["conversation_id"],
    userId: json["user_id"],
    message: json["message"],
    seen: json["seen"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    user:  json["user"]!=null?User.fromJSON(json["user"]):null,
  );

  Map<String, dynamic> toMap() => {
    "sender_id": reciverId,
    "reciver_id": senderId,
    "order_id": orderId,
    "message": message,
   // "seen": seen,
   // "created_at": createdAt.toString(),
   // "updated_at": updatedAt.toString(),
   // "user": user.toMap(),
  };
}