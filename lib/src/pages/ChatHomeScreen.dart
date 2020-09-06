import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/controllers/chat_controller.dart';
import 'package:trip_car_client/src/elements/EmptyReviewsWidget.dart';
import 'package:trip_car_client/src/elements/PermissionDeniedWidget.dart';
import 'package:trip_car_client/src/elements/recent_chats.dart';
import 'package:trip_car_client/src/helpers/shimmer_helper.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class ChatHomeScreenWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ChatHomeScreenWidget({Key key, this.parentScaffoldKey}) : super(key: key);

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
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).chat,
          style: Theme.of(context)
              .textTheme
              .title
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      key: _con.scaffoldKey,
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : _con.isLoading
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
