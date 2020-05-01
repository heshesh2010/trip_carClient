import 'dart:convert';

import 'package:order_client_app/src/models/Conversation.dart';

import 'Message.dart';

class RecentConversations {
  Conversation conversation;
  Message message;

  RecentConversations({
    this.conversation,
    this.message,
  });

  factory RecentConversations.fromJson(String str) => RecentConversations.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecentConversations.fromMap(Map<String, dynamic> json) => RecentConversations(
    conversation: Conversation.fromJSON(json["conversation"]),
    message: Message.fromMap(json["message"]),
  );

  Map<String, dynamic> toMap() => {
    "conversation": conversation.toMap(),
    "message": message.toMap(),
  };
}