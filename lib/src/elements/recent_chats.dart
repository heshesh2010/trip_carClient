import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:trip_car_client/src/controllers/chat_controller.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/conversation_entity.dart';
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
                final ConversationData recentConversations =
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
                      color: recentConversations.latestMessage.seen == 0
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
                              child: recentConversations.latestMessage.sentBy ==
                                      "carOwner"
                                  ? CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          recentConversations.car.user.image ??
                                              "",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/img/loading2.gif',
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )
                                  : CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: _con.user.image ?? "",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/img/loading2.gif',
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                            ),
                            SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  recentConversations.latestMessage.sentBy ==
                                          'carOwner'
                                      ? recentConversations
                                              .car.user?.username ??
                                          "مالك السياره"
                                      : _con.user.username ?? "انا",
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
                                    recentConversations.latestMessage.message,
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
                                  .latestMessage.updatedAt
                                  .toString()),
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            recentConversations.latestMessage.seen == 0
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
