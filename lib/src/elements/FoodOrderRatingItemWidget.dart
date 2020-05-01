import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:order_client_app/generated/i18n.dart';
import 'package:order_client_app/src/controllers/rating_controller.dart';
import 'package:order_client_app/src/models/food_order.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

// ignore: must_be_immutable
class FoodOrderRatingItemWidget extends StatelessWidget {
  FoodOrder foodOrder;
  final RoundedLoadingButtonController btnControllerSave =
      new RoundedLoadingButtonController();
  RatingController con;
  int listIndex;
  FoodOrderRatingItemWidget({Key key, this.foodOrder, this.con, this.listIndex})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
      decoration: new BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor,
            blurRadius: 10.0, // has the effect of softening the shadow
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Image of the card
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  foodOrder.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .merge(TextStyle(letterSpacing: 1.3)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "ما رايك بهذه الوجبة؟",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .merge(TextStyle(letterSpacing: 1.3)),
                ),
                SizedBox(
                  height: 10,
                ),
                RatingBar(
                  initialRating: 3,
                  itemCount: 5,
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
                      default:
                        return null;
                    }
                  },
                  onRatingUpdate: (rating) {
                    con.rateValue = rating;
                    print(rating);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: con.formKeys[listIndex],
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (input) => con.rateComment = input,
                      validator: (input) => input.length < 3
                          ? S.of(context).should_be_more_than_3_letters
                          : null,
                      decoration: InputDecoration(
                        labelText: "التعليق",
                        labelStyle:
                            TextStyle(color: Theme.of(context).hintColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: "فضلا اكتب التقييم هنا ",
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).hintColor.withOpacity(0.7)),
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
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 250,
                  margin:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  child: RoundedLoadingButton(
                    child: Text(
                      "ارسال",
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                    controller: btnControllerSave,
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      con.addFoodRating(foodOrder, btnControllerSave,listIndex);
                     // btnControllerSave.stop();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
