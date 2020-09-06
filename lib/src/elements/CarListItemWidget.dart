import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/route_argument.dart';

// ignore: must_be_immutable
class CarListItemWidget extends StatelessWidget {
  String heroTag;
  CarData car;

  CarListItemWidget({Key key, this.heroTag, this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).pushNamed('Food',
            arguments: new RouteArgument(heroTag: this.heroTag, car: this.car));
      },
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: heroTag + car.id.toString(),
              child: Container(
                height: 60,
                width: 60,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: car?.image ?? "",
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
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
                          car.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        Text(
                          car.user.username ?? "",
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    children: [
                      int.parse(car?.rentPricePerDay ?? 0) != 0
                          ? Helper.getDiscountPrice(
                              double.parse(car.rentPricePerDay),
                              style: Theme.of(context).textTheme.headline3,
                            )
                          : Container(),
                      Helper.getPrice(
                          double.parse(car.rentPricePerDay), context),
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
