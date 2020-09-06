import 'package:flutter/material.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/route_argument.dart';

class GridItemWidget extends StatelessWidget {
  final CarData car;
  final String heroTag;

  GridItemWidget({Key key, this.car, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('Car',
            arguments: RouteArgument(id: car.id, heroTag: heroTag));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            //   color: Theme.of(context).c,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.05),
                  offset: Offset(0, 5),
                  blurRadius: 5)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Hero(
                tag: heroTag + car.id.toString(),
                child: Image.network(
                  car.image,
                  fit: BoxFit.cover,
                  height: 82,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              car.name,
              style: Theme.of(context).textTheme.body1,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            SizedBox(height: 2),
            Row(
              children: Helper.getStarsList(car.carAverageReview),
            ),
          ],
        ),
      ),
    );
  }
}
