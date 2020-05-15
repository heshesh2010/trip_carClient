import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/food_order.dart';
import 'package:trip_car_client/src/models/order.dart';

import 'ExtrasFoodOrderItemWidget.dart';

class TrackingFoodItemWidget extends StatelessWidget {
  final Order order;
  final FoodOrder foodOrder;

  const TrackingFoodItemWidget({Key key, this.foodOrder, this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2)),
          ],
        ),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          itemCount: order.foodOrders.length == 0 ? 0 : order.foodOrders.length,
          itemBuilder: (context, index) {
            return Theme(
              data: theme,
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        image: DecorationImage(
                            image: foodOrder.food.hasMedia
                                ? CachedNetworkImageProvider(
                                    foodOrder.food.image.thumb)
                                : Image.asset('assets/img/default_food.png')
                                    .image,
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 15),
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  foodOrder.food.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Helper.getPrice(
                                  Helper.getTotalOrderPrice(foodOrder),
                                  style: Theme.of(context).textTheme.display1),
                              Text(
                                foodOrder.food?.foodType ?? "",
                                //  DateFormat('yyyy-MM-dd').format(foodOrder.dateTime),
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                children: List.generate(
                    order.foodOrders.elementAt(index).orderFoodsExtras.length ==
                            0
                        ? 0
                        : order.foodOrders
                            .elementAt(index)
                            .orderFoodsExtras
                            .length, (indexFood) {
                  return ExtrasFoodOrderItemWidget(
                      extraFoodItem: order.foodOrders
                          .elementAt(index)
                          .orderFoodsExtras
                          .elementAt(indexFood));
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
