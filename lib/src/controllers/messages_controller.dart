import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/models/Message.dart';
import 'package:order_client_app/src/models/user.dart';
import 'package:order_client_app/src/repository/message_repository.dart';
import 'package:order_client_app/src/repository/message_repository.dart'
    as messageRepo;
import 'package:order_client_app/src/repository/user_repository.dart';

class MessagesController extends ControllerMVC {
  List<Message> messages = <Message>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  User user;
  bool isLoading = false;

  getUser() async {
    this.user = await getCurrentUser();
  }

  MessagesController({conversationId}) {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    if (conversationId != null)
      listenForMessages(conversationId: conversationId);
    getUser();
  }

  void listenForMessages({conversationId, message}) async {
    setState(() {
      isLoading = true;
    });
    final Stream<Message> stream = await getMessages(conversationId);
    stream.listen((Message _message) {
      setState(() {
        messages.add(_message);
      });
    }, onError: (a) {
      setState(() {
        isLoading = false;
      });
      FlushbarHelper.createError(message: "حدث خطأ بالاتصال")
          .show(scaffoldKey.currentState.context);
    }, onDone: () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void sendMessage(String message, int senderId, int receiverId, int orderId) {
    setState(() {
      isLoading = true;
    });
    messageRepo
        .updateMessages(message, senderId, receiverId, orderId)
        .then((value) {
      if (value is Message) {
        setState(() {
          isLoading = false;
          //refreshRecentConversations(value.conversationId);
        });
      } else {
        FlushbarHelper.createError(message: "حدث خطأ بالاتصال")
            .show(scaffoldKey.currentState.context);
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Future<void> refreshRecentConversations(conversationId) async {
    messages.clear();
    listenForMessages(
        conversationId: conversationId, message: 'تم تحديث المحادثه');
  }
}
