import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/controllers/tracking_controller.dart';
import 'package:trip_car_client/src/elements/buildRateIcon.dart';
import 'package:trip_car_client/src/models/route_argument.dart';
import 'package:trip_car_client/src/pages/chat.dart';
import 'package:trip_car_client/src/pages/pages.dart';
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
    double total = widget.routeArgument.order.payment.price /
        ((100 + widget.routeArgument.order.tax) / 100);
    double tax = total / 100 * widget.routeArgument.order.tax;
    double totalAfterTax = tax + total;
    return Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          leading: new IconButton(
            icon:
                new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
            onPressed: () => Navigator.of(context)
                .push(new MaterialPageRoute<String>(
                    builder: (_) => PagesWidget(
                        scaffoldKey2: _con.scaffoldKey, currentTab: 3)))
                .then((String value) {}),
          ),
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
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Theme(
                      data: theme,
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                    '${S.of(context).order_id}: #${widget.routeArgument.order.id}',
                                    style:
                                        Theme.of(context).textTheme.caption)),
                            Text(
                              '${widget.routeArgument.order.status.name}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: [
                              buildText(context,
                                  '${S.of(context).order_from}:  ${widget.routeArgument.order.from}'),
                              buildText(context,
                                  '${S.of(context).order_to}:  ${widget.routeArgument.order.to}'),
                            ],
                          ),
                          SizedBox(height: 20),

                          Row(
                            children: [
                              buildText(context,
                                  '${S.of(context).subtotal} ${total.toStringAsFixed(2)}'),
                            ],
                          ),

                          SizedBox(height: 20),

                          Row(
                            children: [
                              buildText(context,
                                  '${S.of(context).tax} (${widget.routeArgument.order.tax}%): ${tax.toStringAsFixed(2)} ${S.of(context).riyal}'),
                            ],
                          ),
                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildText(context,
                                  '${S.of(context).total}: ${totalAfterTax.toStringAsFixed(2)}'),
                              SizedBox(width: 10),
                            ],
                          ),

                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildProfileImage(),
                              Column(
                                children: [
                                  _buildFullName(),
                                  _buildGetInTouch(context),
                                ],
                              ),
                              if (widget.routeArgument.order.statusId == 2 ||
                                  widget.routeArgument.order.statusId == 3 ||
                                  widget.routeArgument.order.statusId == 4)
                                buildRow(),
                            ],
                          ),
                          SizedBox(height: 40),
                          buildTextCaption(context, S.of(context).order_note),
                          SizedBox(height: 20),
                          //    BuildSeparator(screenSize),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.routeArgument.order.statusId == 4) buildRating(context),
          ],
        ));
  }

  Expanded buildRow() {
    return Expanded(
      child: Row(
        children: [
          buildCallButton(),
          buildMessageButton(),
        ],
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
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: widget?.routeArgument?.order?.car?.image ?? "",
            imageBuilder: (context, imageProvider) => Container(
              width: 60.0,
              height: 60.0,
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
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      widget?.routeArgument?.order?.car?.name ?? "لا يوجد",
      style: _nameTextStyle,
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (widget.routeArgument?.order?.car?.carAverageReview ?? 0) == -1
                  ? Text(S.of(context).no_reviews)
                  : buildRateIcon(
                      widget.routeArgument?.order?.car?.carAverageReview ?? 0,
                      context),
              SizedBox(
                width: 5,
              ),
              Text(
                "${S.of(context).based_on}  (${widget.routeArgument?.order?.car?.reviews?.length ?? 0}) ${S.of(context).rate}",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildMessageButton() {
    return Container(
      width: 30,
      child: IconButton(
          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
          icon: Icon(Icons.message),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(order: widget.routeArgument.order),
              ),
            );
          }),
    );
  }

  Container buildCallButton() {
    return Container(
      width: 30,
      child: IconButton(
          icon: Icon(Icons.phone),

          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
          //   icon: FaIcon(FontAwesomeIcons.phone),
          onPressed: () {
            _launchCaller();
          }),
    );
  }

  Positioned buildRating(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
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
                  S.of(context).how_would_you_rate_this_car_,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Text(
                S.of(context).tell_us_about_this_car,
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
                        image: Image.asset('assets/img/rate.png').image,
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

  _launchCaller() async {
    String url = 'tel:${widget.routeArgument.order.car.user.phone.toString()}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      FlushbarHelper.createInformation(message: 'هذا المستخدم لا يملك هاتف')
          .show(_con.scaffoldKey.currentState.context);
    }
  }

  Padding buildTextCaption(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
