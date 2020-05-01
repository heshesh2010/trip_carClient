import 'package:flutter/material.dart';
import 'package:order_client_app/src/helpers/shimmer_helper.dart';
import 'package:order_client_app/src/models/restaurant.dart';
import 'package:order_client_app/src/models/route_argument.dart';

import 'CardWidget.dart';

class CardsCarouselWidget extends StatefulWidget {
  List<Restaurant> restaurantsList;
  String heroTag;

  CardsCarouselWidget({Key key, this.restaurantsList, this.heroTag})
      : super(key: key);

  @override
  _CardsCarouselWidgetState createState() => _CardsCarouselWidgetState();
}

class _CardsCarouselWidgetState extends State<CardsCarouselWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.restaurantsList.isEmpty
        ? ShimmerHelper(
            type: Type.statics,
          )
        : Container(
            height: 288,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.restaurantsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('Details',
                        arguments: RouteArgument(
                          id: widget.restaurantsList.elementAt(index).id,
                          heroTag: widget.heroTag,
                        ));
                  },
                  child: CardWidget(
                      restaurant: widget.restaurantsList.elementAt(index),
                      heroTag: widget.heroTag),
                );
              },
            ),
          );
  }
}
