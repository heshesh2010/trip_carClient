import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/controllers/review_controller.dart';
import 'package:trip_car_client/src/elements/EmptyReviewsWidget.dart';
import 'package:trip_car_client/src/elements/MyReviewItemWidget.dart';
import 'package:trip_car_client/src/elements/PermissionDeniedWidget.dart';
import 'package:trip_car_client/src/helpers/shimmer_helper.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class ReviewsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ReviewsWidget({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _ReviewsWidgetState createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends StateMVC<ReviewsWidget> {
  ReviewsController _con;
  final scrollController = ScrollController();
  final Duration listShowItemDuration = Duration(milliseconds: 250);

  _ReviewsWidgetState() : super(ReviewsController()) {
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
            S.of(context).reviews,
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
                : _con.reviews.isEmpty
                    ? EmptyReviewsWidget()
                    : LiquidPullToRefresh(
                        onRefresh: _con.refreshReviews, // refresh callback
                        child: // scroll view
                            CustomScrollView(
                          // Must add scrollController to sliver root
                          controller: scrollController,

                          slivers: <Widget>[
                            LiveSliverList(
                              // And attach root sliver scrollController to widgets
                              controller: scrollController,

                              showItemDuration: listShowItemDuration,
                              itemCount: _con.reviews.length,
                              itemBuilder: buildAnimatedItem,
                            ),
                          ],
                        )));
  }

  Widget buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      // For example wrap with fade transition

      FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          // And slide transition
          child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.5, -0.1),
                end: Offset.zero,
              ).animate(animation),
              child:
                  MyReviewItemWidget(review: _con.reviews.elementAt(index))));
}
