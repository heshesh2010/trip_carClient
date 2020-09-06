import 'package:flutter/material.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/route_argument.dart';

import 'CardWidget.dart';
import 'EmptyReviewsWidget.dart';

class CardsCarouselWidget extends StatefulWidget {
  final List<CarData> carsList;
  final String heroTag;

  CardsCarouselWidget({Key key, this.heroTag, this.carsList}) : super(key: key);

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
    return widget.carsList.isEmpty
        ? EmptyReviewsWidget()
        : Container(
            height: 288,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.carsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('Car',
                        arguments: RouteArgument(
                          car: widget.carsList.elementAt(index),
                          heroTag: widget.heroTag,
                        ));
                  },
                  child: CardWidget(
                      car: widget.carsList.elementAt(index),
                      heroTag: widget.heroTag),
                );
              },
            ),
          );
  }
}
