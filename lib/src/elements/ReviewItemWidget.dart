import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:order_client_app/src/helpers/helper.dart';
import 'package:order_client_app/src/models/review.dart';

// ignore: must_be_immutable
class ReviewItemWidget extends StatelessWidget {
  Review review;

  ReviewItemWidget({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Wrap(
        direction: Axis.horizontal,
        runSpacing: 10,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    image: DecorationImage(
                        image: this.review.user.image != null
                            ? CachedNetworkImageProvider(
                                this.review.user.image.thumb)
                            : Image.asset('assets/img/default.png').image)),
              ),
              SizedBox(width: 15),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            review.user.name,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.title.merge(
                                TextStyle(color: Theme.of(context).hintColor)),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                          child: Chip(
                            padding: EdgeInsets.all(0),
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(review.rate.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .merge(TextStyle(
                                            color:
                                                Theme.of(context).hintColor))),
                                Icon(
                                  Icons.star_border,
                                  color: Theme.of(context).hintColor,
                                  size: 16,
                                ),
                              ],
                            ),
                            backgroundColor:
                                Theme.of(context).accentColor.withOpacity(0.9),
                            shape: StadiumBorder(),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      review.user.bio
                          .substring(0, min(30, review.user.bio.length)),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              )
            ],
          ),
          Text(
            Helper.skipHtml(review.review),
            style: Theme.of(context).textTheme.body1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 3,
          )
        ],
      ),
    );
  }
}
