import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/controllers/messages_controller.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/helpers/shimmer_helper.dart';
import 'package:trip_car_client/src/models/conversation_entity.dart';
import 'package:trip_car_client/src/models/message_entity.dart';
import 'package:trip_car_client/src/models/order_entity.dart';
import 'package:trip_car_client/src/pages/pages.dart';

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class ChatScreen extends StatefulWidget {
  final ConversationData recentConversations;
  final OrderData order;
  ChatScreen({this.order, this.recentConversations});

  @override
  State createState() => new ChatScreenState(recentConversations);
}

class ChatScreenState extends StateMVC<ChatScreen>
    with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing =
      false; // make it true whenever the user is typing in the input field.
  MessagesController _con;
  AnimationController animationController;

  ChatScreenState(ConversationData recentConversations)
      : super(recentConversations == null
            ? MessagesController()
            : MessagesController(conversationId: recentConversations.id)) {
    _con = controller;
  }

  /* Modify _handleSubmitted to update _isComposing to false
  when the text field is cleared.*/
  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    var now = new DateTime.now();
    var formatter = new DateFormat("yyyy-MM-dd HH:mm:ss");
    String formattedDate = formatter.format(now);

    MessageData chatMessage = new MessageData(
      message: text,
      sentBy: "user",
      orderId: widget.recentConversations == null
          ? widget.order.id
          : widget.recentConversations.orderId,
      updatedAt: formattedDate,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _con.messages.insert(0, chatMessage);
      _con.sendMessage(
        text,
        widget.recentConversations == null
            ? widget.order.id
            : widget.recentConversations.orderId,
        widget.recentConversations == null
            ? widget.order.car.id
            : widget.recentConversations.carId,
      );
    });
    chatMessage.animationController.forward();
  }

  void dispose() {
    for (MessageData message in _con.messages)
      if (message.animationController != null) {
        message.animationController.dispose();
      }
    super.dispose();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "اكتب الرسالة.."),
              ),
            ),
            new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? new CupertinoButton(
                        child: new Text("ارسال"),
                        onPressed: _isComposing
                            ? () => _handleSubmitted(_textController.text)
                            : null,
                      )
                    : new IconButton(
                        icon: new Icon(
                          Icons.send,
                          color: Theme.of(context).hintColor,
                        ),
                        onPressed: _isComposing
                            ? () => _handleSubmitted(_textController.text)
                            : null,
                      )),
          ]),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border:
                      new Border(top: new BorderSide(color: Colors.grey[200])))
              : null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context)
              .push(new MaterialPageRoute<String>(
                  builder: (_) => PagesWidget(
                        currentTab: 4,
                        scaffoldKey2: _con.scaffoldKey,
                      )))
              .then((String value) {}),
        ),
        title: Text(
          widget.recentConversations == null
              ? " ${S.of(context).chat_with} ${widget.order.car.user.username}   ${S.of(context).order_id} # ${widget.order.id}"
              : " ${S.of(context).chat_with} ${widget.recentConversations.car.user.username}   ${S.of(context).order_id} ${widget.recentConversations.orderId}",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: _con.isLoading
          ? ShimmerHelper(type: Type.product)
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        child: ListView.builder(
                            reverse: false,
                            padding: EdgeInsets.only(top: 15.0),
                            itemCount: _con.messages.length,
                            itemBuilder: (BuildContext context, int index) {
                              final MessageData message = _con.messages[index];
                              final bool isMe = message.sentBy == "user";
                              return buildMessage(message, isMe);
                            }),
                      ),
                    ),
                  ),
                  _buildTextComposer(),
                ],
              ),
            ),
    );
  }

  buildMessage(MessageData message, bool isMe) {
    final Container msg = Container(
        margin: isMe
            ? EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 5.0,
              )
            : EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                right: 5.0,
              ),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 50,
              color: Theme.of(context).hintColor.withOpacity(0.2),
            )
          ],
          color: isMe ? Theme.of(context).primaryColor : Color(0xFFFFEFEE),
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(60.0),
                  bottomLeft: Radius.circular(15.0),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(60.0),
                  bottomRight: Radius.circular(15.0),
                ),
        ),
        child: isMe
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(Helper.getTimeOnly(message.updatedAt),
                      style: Theme.of(context).textTheme.caption),
                  Text(
                    message.message,
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    Helper.getTimeOnly(message.updatedAt),
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    message.message,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ));
    if (isMe) {
      return Row(
        children: <Widget>[
          CircleAvatar(
              radius: 35.0,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: _con.user.image ?? "",
                imageBuilder: (context, imageProvider) => Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading2.gif',
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )),
          msg,
        ],
      );
    }
    return Row(
      children: <Widget>[
        msg,
        CircleAvatar(
          radius: 35.0,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: widget.recentConversations.car.user.image ?? "",
            imageBuilder: (context, imageProvider) => Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Image.asset(
              'assets/img/loading2.gif',
              fit: BoxFit.cover,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ],
    );
  }
}
