import 'package:flutter/material.dart';
import 'package:trip_car_client/src/elements/EmptyReviewsWidget.dart';
import 'package:trip_car_client/src/models/review_entity.dart';

import 'MyReviewItemWidget.dart';

// ignore: must_be_immutable
class RecentReviewsListWidget extends StatelessWidget {
  List<ReviewData> reviewsList;

  RecentReviewsListWidget({Key key, this.reviewsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return reviewsList.isEmpty
        ? EmptyReviewsWidget()
        :

        //   ShimmerHelper(type: Type.orders,)
        ListView.separated(
            reverse: true,
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return MyReviewItemWidget(review: reviewsList.elementAt(index));
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
