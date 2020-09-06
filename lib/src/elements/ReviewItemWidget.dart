import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/car_entity.dart';

class ReviewItemWidget extends StatelessWidget {
  final CarDataReview review;

  ReviewItemWidget({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            height: 75,
            width: 75,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: review?.user?.image ?? "",
              placeholder: (context, url) => Image.asset(
                'assets/img/loading.gif',
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )),
        SizedBox(width: 15),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 10),
              Row(
                children: Helper.getStarsList(review?.stars?.toDouble() ?? 0.0),
              ),
              Text(
                review?.createdAt ?? "",
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 10),
              Text(
                review?.comment ?? "لا يوجد تعليق",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.body2,
              ),
              Text(
                this.review.user?.username ?? "فلان",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        )
      ],
    );
  }
}
