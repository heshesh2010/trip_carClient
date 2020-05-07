import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/controllers/messages_controller.dart';
import 'package:order_client_app/src/helpers/helper.dart';
import 'package:order_client_app/src/helpers/shimmer_helper.dart';
import 'package:order_client_app/src/models/Message.dart';
import 'package:order_client_app/src/models/order.dart';
import 'package:order_client_app/src/models/recentConversations.dart';

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class ChatScreen extends StatefulWidget {
  final RecentConversations recentConversations;
  final Order order;
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

  ChatScreenState(RecentConversations recentConversations)
      : super(recentConversations == null
            ? MessagesController()
            : MessagesController(conversationId: recentConversations.id)) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
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

    Message chatMessage = new Message(
      message: text,
      sentBy: "user",
      orderId: widget.recentConversations == null
          ? widget.order.orderNumber
          : widget.recentConversations.orderId,
      updatedAt: formattedDate,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _con.messages.add(chatMessage);
      _con.sendMessage(
          text,
          widget.recentConversations == null
              ? widget.order.orderNumber
              : widget.recentConversations.orderId);
    });
    chatMessage.animationController.forward();
  }

  void dispose() {
    for (Message message in _con.messages)
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
        title: Text(
          widget.recentConversations == null
              ? "محادثة مع ${widget.order.restaurant.name}   اوردر رقم # ${widget.order.orderNumber}"
              : "محادثة مع ${widget.recentConversations.restaurant.name}   اوردر رقم # ${widget.recentConversations.orderId}",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: _con.isLoading
          ? ShimmerHelper(type: Type.orders)
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
                              final Message message = _con.messages[index];
                              final bool isMe = message.sentBy == 'user';
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

  buildMessage(Message message, bool isMe) {
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
            backgroundImage: _con.currentUser.media != null
                ? CachedNetworkImageProvider(_con.currentUser.media.first.thumb)
                : Image.asset('assets/img/default.png').image,
          ),
          msg,
        ],
      );
    }
    return Row(
      children: <Widget>[
        msg,
        CircleAvatar(
          radius: 35.0,
          backgroundImage: widget.recentConversations.restaurant.image != null
              ? CachedNetworkImageProvider(
                  widget.recentConversations.restaurant.image.thumb)
              : Image.asset('assets/img/default.png').image,
        ),
      ],
    );
  }
}
