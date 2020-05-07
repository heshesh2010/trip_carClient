import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/controllers/rating_controller.dart';
import 'package:order_client_app/src/elements/FoodRatingListWidget.dart';
import 'package:order_client_app/src/models/route_argument.dart';

class SubmitRate extends StatefulWidget {
  final RouteArgument routeArgument;

  SubmitRate({Key key, this.routeArgument}) : super(key: key);

  @override
  SubmitRateState createState() => SubmitRateState();
}

class SubmitRateState extends StateMVC<SubmitRate> {
  RatingController _con;

  SubmitRateState() : super(RatingController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "تقييم المطعم والوجبات",
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: CustomSliverDelegate(
                routeArgument: widget.routeArgument,
                expandedHeight: 200,
              ),
            ),
            SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: FoodOrderRatingListWidget(
                      order: widget.routeArgument.order, controller: _con),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  RouteArgument routeArgument;
  CustomSliverDelegate({
    @required this.expandedHeight,
    this.hideTitleWhenExpanded = false,
    this.routeArgument,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      routeArgument.order.restaurant.image.thumb),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 120,
            bottom: -80.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 100 * percent, horizontal: 100 * percent),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Text(
                          " التقييم الحالي: ${routeArgument.order.restaurant.name} ",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        buildRateIcon(),
                      ],
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

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Widget buildRateIcon() {
    switch (routeArgument.order.restaurant.rate.toInt()) {
      case 0:
        return Icon(
          Icons.sentiment_very_dissatisfied,
          color: Colors.red,
        );
      case 1:
        return Icon(
          Icons.sentiment_dissatisfied,
          color: Colors.redAccent,
        );
      case 2:
        return Icon(
          Icons.sentiment_neutral,
          color: Colors.amber,
        );
      case 3:
        return Icon(
          Icons.sentiment_satisfied,
          color: Colors.lightGreen,
        );
      case 4:
        return Icon(
          Icons.sentiment_very_satisfied,
          color: Colors.green,
        );
      default:
        return null;
    }
  }
}
