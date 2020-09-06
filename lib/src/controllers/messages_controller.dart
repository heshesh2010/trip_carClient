import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/message_entity.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/repository/message_repository.dart';
import 'package:trip_car_client/src/repository/message_repository.dart'
    as messageRepo;
import 'package:trip_car_client/src/repository/user_repository.dart';

class MessagesController extends ControllerMVC {
  List<MessageData> messages = <MessageData>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  UserDataUser user;
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
    final Stream<MessageData> stream = await getMessages(conversationId);
    stream.listen((MessageData _message) {
      setState(() {
        messages.add(_message);
      });
    }, onError: (a) {
      setState(() {
        isLoading = false;
      });
      FlushbarHelper.createError(message: a.toString()).show(context);
    }, onDone: () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void sendMessage(String message, int orderId, int restaurantId) {
    setState(() {
      isLoading = true;
    });
    messageRepo.updateMessages(message, orderId, restaurantId).then((value) {
      if (value is MessageData) {
        setState(() {
          isLoading = false;
          //refreshRecentConversations(value.conversationId);
        });
      } else {
        FlushbarHelper.createSuccess(message: "تم ارسال الرساله بنجاح")
            .show(context);

        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Future<void> refreshRecentConversations(conversationId) async {
    messages.clear();
    listenForMessages(
        conversationId: conversationId, message: 'Chat refreshed successfuly');
  }
}
