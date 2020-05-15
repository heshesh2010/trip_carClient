import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/recentConversations.dart';
import 'package:trip_car_client/src/models/user.dart';
import 'package:trip_car_client/src/repository/conversation_repository.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class ChatController extends ControllerMVC {
  List<RecentConversations> recentConversation = <RecentConversations>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  bool isLoading = true;
  User currentUser;
  getUser() async {
    this.currentUser = await getCurrentUser();
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
