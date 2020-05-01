import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/models/recentConversations.dart';
import 'package:order_client_app/src/models/user.dart';
import 'package:order_client_app/src/repository/conversation_repository.dart';
import 'package:order_client_app/src/repository/user_repository.dart';

class ChatController extends ControllerMVC {
  List<RecentConversations> recentConversation = <RecentConversations>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  bool isLoading = true;
  User user;
  getUser() async {
    this.user = await getCurrentUser();
  }

  ChatController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    getUser();
    listenForRecentConversations();
  }

  void listenForRecentConversations({String message}) async {
    final Stream<RecentConversations> stream = await getRecentConversations();
    stream.listen((RecentConversations _recentConversation) {
      setState(() {
        recentConversation.add(_recentConversation);
      });
    }, onError: (a) {
      FlushbarHelper.createError(message: a.toString())
          .show(scaffoldKey.currentState.context);
      setState(() {
        isLoading = false;
      });
      print(a);
    }, onDone: () {
      setState(() {
        isLoading = false;
      });
      if (message != null) {
        FlushbarHelper.createSuccess(message: message)
            .show(scaffoldKey.currentState.context);
      }
    });
  }

  Future<void> refreshRecentConversations() async {
    recentConversation.clear();
    listenForRecentConversations(message: 'تم تحديث قائمه المحادثات');
  }
}