import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/food.dart';
import 'package:trip_car_client/src/models/route_argument.dart';

class FoodsCarouselItemWidget extends StatelessWidget {
  double marginLeft;
  Food food;
  String heroTag;

  FoodsCarouselItemWidget({Key key, this.heroTag, this.marginLeft, this.food})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.white10,
      onTap: () {
        Navigator.of(context).pushNamed('Food',
            arguments: RouteArgument(food: food, heroTag: heroTag));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              Hero(
                tag: heroTag + food.id,
                child: Container(
                  margin: EdgeInsets.only(left: this.marginLeft, right: 20),
                  width: 100,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: food.image != null
                              ? CachedNetworkImageProvider(
                                  "https://saudishift.com/wp-content/uploads/2015/02/2.png")
                              : Image.asset('assets/img/default_food.png')
                                  .image)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 25, top: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Theme.of(context).accentColor),
                alignment: AlignmentDirectional.topEnd,
                child: Helper.getPrice(
                  food.price,
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .merge(TextStyle(color: Theme.of(context).focusColor)),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
              width: 100,
              margin: EdgeInsets.only(left: this.marginLeft, right: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    "مرسيدس موديل 2018",
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    "احمد القحطاني " ?? "",
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
