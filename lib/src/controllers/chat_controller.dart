import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/conversation_entity.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/repository/conversation_repository.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class ChatController extends ControllerMVC {
  List<ConversationData> recentConversation = <ConversationData>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  bool isLoading = true;
  UserDataUser user = new UserDataUser();

  ChatController() {
    listenForUser();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForRecentConversations();
  }

  void listenForUser() {
    getCurrentUser().then((_user) {
      setState(() {
        user = _user;
      });
    });
  }

  void listenForRecentConversations({String message}) async {
    final Stream<ConversationData> stream = await getRecentConversations();
    stream.listen((ConversationData _recentConversation) {
      setState(() {
        recentConversation.add(_recentConversation);
      });
    }, onError: (a) {
      FlushbarHelper.createError(message: a.toString()).show(context);
      setState(() {
        isLoading = false;
      });
      print(a);
    }, onDone: () {
      setState(() {
        isLoading = false;
      });
      if (message != null) {
        FlushbarHelper.createSuccess(message: message).show(context);
      }
    });
  }

  Future<void> refreshRecentConversations() async {
    recentConversation.clear();
    listenForRecentConversations(message: 'تم تحديث قائمه المحادثات');
  }
}
