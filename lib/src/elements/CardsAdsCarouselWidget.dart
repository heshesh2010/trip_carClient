import 'package:flutter/material.dart';
import 'package:order_client_app/src/helpers/shimmer_helper.dart';
import 'package:order_client_app/src/models/ad.dart';

import 'CardAdWidget.dart';

class CardsAdsCarouselWidget extends StatefulWidget {
  final List<Ad> adsList;
  String heroTag;

  CardsAdsCarouselWidget({Key key, this.adsList, this.heroTag})
      : super(key: key);

  @override
  _CardsCarouselWidgetState createState() => _CardsCarouselWidgetState();
}

class _CardsCarouselWidgetState extends State<CardsAdsCarouselWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.adsList.isEmpty
        ? ShimmerHelper(
            type: Type.statics,
          )
        : Container(
            height: 288,
            child: ListView.builder(
              reverse: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.adsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: CardAdWidget(
                      ad: widget.adsList.elementAt(index),
                      heroTag: widget.heroTag),
                );
              },
            ),
          );
  }
}
