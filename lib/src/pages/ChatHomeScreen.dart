import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/controllers/chat_controller.dart';
import 'package:trip_car_client/src/elements/EmptyReviewsWidget.dart';
import 'package:trip_car_client/src/elements/recent_chats.dart';
import 'package:trip_car_client/src/helpers/shimmer_helper.dart';

class ChatHomeScreenWidget extends StatefulWidget {
  @override
  _ChatHomeScreenWidgetState createState() => _ChatHomeScreenWidgetState();
}

class _ChatHomeScreenWidgetState extends StateMVC<ChatHomeScreenWidget> {
  ChatController _con;

  _ChatHomeScreenWidgetState() : super(ChatController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: _con.isLoading
          ? ShimmerHelper(type: Type.images)
          : _con.recentConversation.isEmpty
              ? EmptyReviewsWidget()
              : Center(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              RecentChats(_con),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
