import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/restaurant.dart';
import 'package:trip_car_client/src/models/route_argument.dart';

class CardWidget extends StatelessWidget {
  Restaurant restaurant;
  String heroTag;

  CardWidget({Key key, this.restaurant, this.heroTag}) : super(key: key);
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
              Hero(
                tag: this.heroTag + restaurant.id.toString(),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "https://saudishift.com/wp-content/uploads/2015/02/2.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                ),
              ),

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "مرسيدس c180 موديل 2019",
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Row(
                                children: Helper.getStarsList(restaurant.rate),
                              ),
                              Text(
                                "بناء على 14 رحلة ",
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: Theme.of(context).textTheme.caption,
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
                                  arguments:
                                      new RouteArgument(param: restaurant));
                            },
                            child: Icon(Icons.directions,
                                color: Theme.of(context).focusColor),
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          Text(
                            Helper.getDistance(restaurant.distance),
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
                    "550",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    "ريال/يوم",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              // color: Theme.of(context).accentColor.withOpacity(0.9),
              decoration: BoxDecoration(
                color: Colors.white,
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
