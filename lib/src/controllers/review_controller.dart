import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:trip_car_client/src/models/order_entity.dart';
import 'package:trip_car_client/src/models/review_entity.dart';
import 'package:trip_car_client/src/models/user_review_entity.dart';
import 'package:trip_car_client/src/repository/review_repository.dart'
    as reviewRepo;

class ReviewsController extends ControllerMVC {
  List<ReviewData> reviews = <ReviewData>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  bool isLoading = true;
  UserReviewData userReview;
  GlobalKey<FormState> submitFormKey;

  ReviewsController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    submitFormKey = new GlobalKey<FormState>();
    listenForReviews();
    this.userReview = new UserReviewData.init(0);
  }

  void listenForReviews({String message}) async {
    final Stream<ReviewData> stream = await reviewRepo.getReviews();
    stream.listen((ReviewData _review) {
      setState(() {
        reviews.add(_review);
      });
    }, onError: (a) {
      setState(() {
        isLoading = false;
      });
      print(a);
      FlushbarHelper.createError(message: a.toString()).show(context);
    }, onDone: () {
      setState(() {
        isLoading = false;
      });
      if (message != null) {
        FlushbarHelper.createSuccess(message: message).show(context);
      }
    });
  }

  void addUserReview(OrderData order,
      RoundedLoadingButtonController btnControllerSubmit) async {
    if (submitFormKey.currentState.validate()) {
      submitFormKey.currentState.save();
      reviewRepo.addUserReview(userReview, order).then((value) {
        if (value is UserReviewData) {
          btnControllerSubmit.success();
          FlushbarHelper.createInformation(message: "تم ارسال التقييم بنجاح")
              .show(scaffoldKey.currentContext);
        } else {
          FlushbarHelper.createInformation(message: value.message)
              .show(scaffoldKey.currentContext);
        }
      });
    } else {
      btnControllerSubmit.reset();
    }
  }

  Future<void> refreshReviews() async {
    reviews.clear();
    listenForReviews(message: 'تم تحديث التقييمات بنجاح');
  }
}
