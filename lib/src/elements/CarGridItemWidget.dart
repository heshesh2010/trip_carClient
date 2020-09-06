import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/route_argument.dart';

class CarGridItemWidget extends StatelessWidget {
  final String heroTag;
  final CarData car;

  CarGridItemWidget({Key key, this.heroTag, this.car}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('Car',
            arguments: new RouteArgument(heroTag: this.heroTag, car: this.car));
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Hero(
                  tag: heroTag + car.id.toString(),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: car.image != null
                              ? CachedNetworkImageProvider(car.image)
                              : Image.asset('assets/img/default_food.png')
                                  .image,
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                car?.name ?? "",
                style: Theme.of(context).textTheme.body2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text(
                car.user.username ?? "",
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: 60,
            height: 30,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child:
                  Helper.getPrice(double.parse(car.rentPricePerDay), context),
              color: Theme.of(context).accentColor.withOpacity(0.9),
              shape: StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
