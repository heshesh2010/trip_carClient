import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../generated/i18n.dart';
import '../controllers/review_controller.dart';
import '../models/route_argument.dart';

class SubmitReviewWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  SubmitReviewWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _SubmitReviewWidgetState createState() {
    return _SubmitReviewWidgetState();
  }
}

class _SubmitReviewWidgetState extends StateMVC<SubmitReviewWidget> {
  ReviewsController _con;
  final RoundedLoadingButtonController _btnControllerSubmit =
      new RoundedLoadingButtonController();
  _SubmitReviewWidgetState() : super(ReviewsController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.userReview.orderId = widget.routeArgument.order.id.toString();
    _con.userReview.userId =
        int.parse(widget.routeArgument.order.userId.toString());
    _con.userReview.carId =
        int.parse(widget.routeArgument.order.carId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.routeArgument.order.car.image,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 110,
                        child: Chip(
                          padding: EdgeInsets.all(10),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  widget?.routeArgument?.order?.car
                                      ?.carAverageReview
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .display2
                                      .merge(TextStyle(
                                          color: Theme.of(context).hintColor))),
                              Icon(
                                Icons.star_border,
                                color: Theme.of(context).hintColor,
                                size: 30,
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
                  Positioned(
                    top: 30,
                    right: 15,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).accentColor,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.routeArgument.order.car.name,
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.display2,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.15),
                          offset: Offset(0, -2),
                          blurRadius: 5.0)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(S.of(context).how_would_you_rate_this_car_,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subhead),
                    SizedBox(height: 10),
                    RatingBar(
                        initialRating: 3,
                        itemCount: 5,
                        // ignore: missing_return
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return Icon(
                                Icons.sentiment_very_dissatisfied,
                                color: Colors.red,
                              );
                            case 1:
                              return Icon(
                                Icons.sentiment_dissatisfied,
                                color: Colors.redAccent,
                              );
                            case 2:
                              return Icon(
                                Icons.sentiment_neutral,
                                color: Colors.amber,
                              );
                            case 3:
                              return Icon(
                                Icons.sentiment_satisfied,
                                color: Colors.lightGreen,
                              );
                            case 4:
                              return Icon(
                                Icons.sentiment_very_satisfied,
                                color: Colors.green,
                              );
                          }
                        },
                        onRatingUpdate: (rating) {
                          _con.userReview.carStars = rating.toInt();
                          print(rating);
                        }),
                    SizedBox(height: 10),
                    Form(
                      key: _con.submitFormKey,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        onSaved: (input) => _con.userReview.carComment = input,
                        validator: (input) => input.length < 3 || input.isEmpty
                            ? S.of(context).should_be_more_than_3_letters
                            : null,
                        decoration: InputDecoration(
                          labelText: S.of(context).tell_us_about_this_car,
                          labelStyle:
                              TextStyle(color: Theme.of(context).hintColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).tell_us_about_this_car,
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          prefixIcon: Icon(Icons.rate_review,
                              color: Theme.of(context).hintColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    RoundedLoadingButton(
                      child: Text(
                        S.of(context).submit,
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                      controller: _btnControllerSubmit,
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        _con.addUserReview(
                            widget.routeArgument.order, _btnControllerSubmit);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
