import 'package:flutter/material.dart';
import 'package:order_client_app/src/controllers/rating_controller.dart';
import 'package:order_client_app/src/elements/EmptyReviewsWidget.dart';
import 'package:order_client_app/src/models/order.dart';

import 'FoodOrderRatingItemWidget.dart';
import 'ResturantRatingItemWidget.dart';

// ignore: must_be_immutable
class FoodOrderRatingListWidget extends StatelessWidget {
  Order order;
  RatingController controller;
  FoodOrderRatingListWidget({Key key, this.order, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return order.foodOrders.isEmpty
        ? EmptyReviewsWidget()
        :

        //   ShimmerHelper(type: Type.orders,)
        SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RestaurantRatingItemWidget(
                  restaurant: order.restaurant,
                ),
                ListView.separated(
                  itemBuilder: (context, index) {
                    return FoodOrderRatingItemWidget(
                        foodOrder: order.foodOrders.elementAt(index),
                        con: controller,
                        listIndex:index);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20);
                  },
                  itemCount: order.foodOrders.length,
                  primary: false,
                  shrinkWrap: true,
                ),
              ],
            ),
          );
  }
}
