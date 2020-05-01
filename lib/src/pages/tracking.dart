import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/generated/i18n.dart';
import 'package:order_client_app/src/controllers/tracking_controller.dart';
import 'package:order_client_app/src/elements/CircularLoadingWidget.dart';
import 'package:order_client_app/src/elements/TrackingFoodItemWidget.dart';
import 'package:order_client_app/src/models/route_argument.dart';
import 'package:order_client_app/src/pages/chat.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackingWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  TrackingWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _TrackingWidgetState createState() => _TrackingWidgetState();
}

class _TrackingWidgetState extends StateMVC<TrackingWidget> {
  TrackingController _con;

  _TrackingWidgetState() : super(TrackingController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context).order_details,
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        body: widget.routeArgument.order == null ||
                widget.routeArgument.order.orderStatus.status.isEmpty
            ? CircularLoadingWidget(height: 300)
            : Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    padding: EdgeInsets.only(bottom: 100),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Theme(
                            data: theme,
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              title: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                          '${S.of(context).order_id}: #${widget.routeArgument.order.orderNumber}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption)),
                                  Text(
                                    '${widget.routeArgument.order.orderStatus.status}',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              children: List.generate(
                                  widget.routeArgument.order.foodOrders.length,
                                  (indexFood) {
                                return TrackingFoodItemWidget(
                                    order: widget.routeArgument.order,
                                    foodOrder: widget
                                        .routeArgument.order.foodOrders
                                        .elementAt(indexFood));
                              }),
                            ),
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: <Widget>[
                              buildText(context,
                                  '${S.of(context).total}:  ${widget.routeArgument.order.payment?.price.toString()}'),
                              SizedBox(height: 20),
                              buildText(context,
                                  '${S.of(context).payment_mode}:  ${widget.routeArgument.order.payment?.method}'),
                              SizedBox(height: 20),
                              buildText(context,
                                  '${S.of(context).confirm_payment}:  ${widget.routeArgument.order.payment?.status}'),
                              _buildProfileImage(),
                              _buildFullName(),
                              _buildSeparator(screenSize),
                              _buildGetInTouch(context),
                              _buildButtons(),
                            ],
                          ),
                          buildStepper(context),
                        ],
                      ),
                    ),
                  ),
                  buildRating(context)
                ],
              ));
  }

  Theme buildStepper(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Theme.of(context).focusColor,
      ),
      child: Stepper(
          physics: ClampingScrollPhysics(),
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return SizedBox(height: 0);
          },
          steps: _con.getTrackingSteps(context,
              widget.routeArgument.ordersStatus, widget.routeArgument.order),
          currentStep:
              int.tryParse(this.widget.routeArgument.order.orderStatus.id) - 1,
          onStepTapped: (step) {
            if (step <=
                int.tryParse(this.widget.routeArgument.order.orderStatus.id) -
                    1) {
              // sorry
            } else {
              setState(() {
                this.widget.routeArgument.order.orderStatus.id =
                    (step + 1).toString();
                _con.updateOrder(this.widget.routeArgument.order);
                // post to server new id
                 //  currentStep = step;
                 // when step more than 2 show message there will be charge and confrmation dailog 
                 // if in first step go
                 // if in last step 
                 
              });
            }
          }),
    );
  }

  Positioned buildRating(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 150,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.15),
                  offset: Offset(0, -2),
                  blurRadius: 5.0)
            ]),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "ماهو تقييمك للمطعم  ؟ ",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Text(
                "فضلا اضغط على النجوم بالاسفل ",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('submit_rate',
                      arguments: RouteArgument(
                          param: 'Order', order: widget.routeArgument.order));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: Image.asset('assets/img/stars.jpg').image,
                        fit: BoxFit.fitHeight),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildText(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: widget.routeArgument.order.restaurant.image != null
                ? CachedNetworkImageProvider(
                    widget.routeArgument.order.restaurant.image.thumb)
                : AssetImage('assets/img/default.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      widget.routeArgument.order.restaurant.name,
      style: _nameTextStyle,
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "تواصل مع  ${widget.routeArgument.order.restaurant.name},",
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => _launchCaller(),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Theme.of(context).accentColor,
                ),
                child: Center(
                  child: Text(
                    "اتصال ",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(order: widget.routeArgument.order),
                ),
              ),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                    border: Border.all(), color: Theme.of(context).accentColor),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "مراسلة",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchCaller() async {
    String url =
        'tel:${widget.routeArgument.order.restaurant.phone.toString()}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      FlushbarHelper.createInformation(message: 'هذا المطعم لا يملك هاتف')
          .show(_con.scaffoldKey.currentState.context);
    }
  }
}
