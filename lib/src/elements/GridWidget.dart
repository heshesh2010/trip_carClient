import 'package:flutter/material.dart';
import 'package:trip_car_client/src/elements/GridItemWidget.dart';
import 'package:trip_car_client/src/models/car_entity.dart';

class GridWidget extends StatelessWidget {
  final List<CarData> carsList;
  final String heroTag;
  GridWidget({Key key, this.carsList, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(vertical: 10),
      crossAxisCount:
          MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
      children: List.generate(carsList.length, (index) {
        return GridItemWidget(car: carsList.elementAt(index), heroTag: heroTag);
      }),
    );
  }
}
