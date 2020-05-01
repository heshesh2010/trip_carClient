import 'package:flutter/material.dart';
import 'package:order_client_app/src/elements/CircularLoadingWidget.dart';
import 'package:order_client_app/src/elements/EmptyReviewsWidget.dart';
import 'package:order_client_app/src/elements/ReviewItemWidget.dart';
import 'package:order_client_app/src/helpers/shimmer_helper.dart';
import 'package:order_client_app/src/models/review.dart';

import 'EmptyNotificationsWidget.dart';

// ignore: must_be_immutable
class ReviewsListWidget extends StatelessWidget {
  List<Review> reviewsList;

  ReviewsListWidget({Key key, this.reviewsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return reviewsList.isEmpty
        ?  EmptyReviewsWidget():


 //   ShimmerHelper(type: Type.orders,)
        ListView.separated(
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return ReviewItemWidget(review: reviewsList.elementAt(index));
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 20);
            },
            itemCount: reviewsList.length,
            primary: false,
            shrinkWrap: true,
          );
  }
}
