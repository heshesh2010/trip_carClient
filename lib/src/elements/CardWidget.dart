import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/route_argument.dart';

class CardWidget extends StatelessWidget {
  final CarData car;
  final String heroTag;

  CardWidget({Key key, this.car, this.heroTag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 292,
      margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 15,
              offset: Offset(0, 5)),
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Image of the card
              Container(
                  height: 150,
                  width: 292,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: car?.image ?? "",
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            car?.name ?? "",
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          SizedBox(height: 5),
                          car.carAverageReview == -1.0
                              ? Text(S.of(context).no_reviews)
                              : Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: Helper.getStarsList(
                                          car?.carAverageReview ?? 0.0),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "${S.of(context).based_on}  (${car.reviews?.length ?? 0}) ${S.of(context).rate}",
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              print('Go to map');
                              Navigator.of(context).pushNamed('Map',
                                  arguments: new RouteArgument(param: car));
                            },
                            child: Icon(Icons.directions,
                                color: Theme.of(context).primaryColor),
                            color: Theme.of(context).unselectedWidgetColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          Text(
                            Helper.getDistance(car.distance, context),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: 100,
            height: 30,
            child: Container(
              padding: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    car?.rentPricePerDay ?? "0",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    S.of(context).riyal_per_day,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              // color: Theme.of(context).accentColor.withOpacity(0.9),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.all(Radius.circular(
                        5.0) //                 <--- border radius here
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
