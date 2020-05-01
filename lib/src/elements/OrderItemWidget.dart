import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:order_client_app/generated/i18n.dart';
import 'package:order_client_app/src/helpers/helper.dart';
import 'package:order_client_app/src/models/order.dart';
import 'package:order_client_app/src/models/order_status.dart';
import 'package:order_client_app/src/models/route_argument.dart';

class OrderItemWidget extends StatelessWidget {
  final Order order;
  final List<OrderStatus> orderStatus;

  const OrderItemWidget({Key key, this.order, this.orderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // splashColor: Theme.of(context).primaryColor,
      // focusColor: Theme.of(context).focusColor,
      //highlightColor: Theme.of(context).primaryColor,

      onTap: () {
        if (orderStatus.isNotEmpty && orderStatus != null)
          Navigator.of(context).pushNamed('Tracking',
              arguments:
                  RouteArgument(order: order, ordersStatus: orderStatus));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                    image: order.restaurant?.image != null
                        ? CachedNetworkImageProvider(
                            order.restaurant.image.thumb,
                          )
                        : Image.asset('assets/img/default.png').image,
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
                          '${S.of(context).order_id}:#${order.orderNumber.toString()}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          order.restaurant?.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.caption,
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
                          order.payment != null
                              ? order.payment.price ?? 0.0
                              : 0.0,
                          style: Theme.of(context).textTheme.headline4),
                      Text(
                        Helper.getDateOnly(order.date),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        Helper.getTimeOnly(order.date),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        order.orderStatus.status,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
