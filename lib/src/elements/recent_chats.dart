import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:trip_car_client/src/controllers/chat_controller.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/recentConversations.dart';
import 'package:trip_car_client/src/pages/chat.dart';

class RecentChats extends StatelessWidget {
  final ChatController _con;
  RecentChats(this._con);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: LiquidPullToRefresh(
            //   key: _refreshIndicatorKey,
            onRefresh: _con.refreshRecentConversations,

            child: ListView.builder(
              itemCount: _con.recentConversation.length,
              itemBuilder: (BuildContext context, int index) {
                final RecentConversations recentConversations =
                    _con.recentConversation[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        recentConversations: recentConversations,
                      ),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, right: 5.0, left: 5),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: recentConversations.message.seen == 0
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).accentColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 50,
                          color: Theme.of(context).hintColor.withOpacity(0.1),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                                radius: 35.0,
                                backgroundImage: recentConversations
                                            .message.sentBy ==
                                        "user"
                                    ? _con.currentUser.media != null
                                        ? CachedNetworkImageProvider(
                                            _con.currentUser.media.first.thumb)
                                        : Image.asset('assets/img/default.png')
                                            .image
                                    : recentConversations.restaurant.image !=
                                            null
                                        ? CachedNetworkImageProvider(
                                            recentConversations
                                                .restaurant.image.url)
                                        : Image.asset('assets/img/default.png')
                                            .image),
                            SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  recentConversations.message.sentBy == 'user'
                                      ? _con.currentUser.name
                                      : recentConversations.restaurant.name,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    //   fontSize: 15.0,
                                    //    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Text(
                                    recentConversations.message.message,
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              Helper.getDateOnly(recentConversations
                                  .message.updatedAt
                                  .toString()),
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            recentConversations.message.seen == 0
                                ? Container(
                                    width: 40.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'جديد',
                                      style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Text(''),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
