import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/order_entity.dart';
import 'package:trip_car_client/src/models/route_argument.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderData order;
  final List<OrderDataStatus> orderStatus;

  const OrderItemWidget({Key key, this.order, this.orderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // splashColor: Theme.of(context).primaryColor,
      // focusColor: Theme.of(context).focusColor,
      //highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).pushNamed('Tracking',
            arguments: RouteArgument(order: order, ordersStatus: orderStatus));
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
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: order?.car?.image ?? "",
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
                          '${S.of(context).order_id}:#${order.id.toString()}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          order?.car?.name ?? "لا يوجد",
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
                      Helper.getPrice(order.payment?.price ?? 0.0, context),
                      Text(
                        Helper.getDateOnly(order.updatedAt ?? ""),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        Helper.getTimeOnly(order.updatedAt ?? ""),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        order.status?.name ?? "",
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
