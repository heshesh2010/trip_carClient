import 'package:flutter/material.dart';
import 'package:trip_car_client/src/models/food.dart';

typedef FoodBoolFunc = void Function(Food food, {bool reset});

class AddToCartAlertDialogWidget extends StatelessWidget {
  final Food oldFood;
  final Food newFood;
  final FoodBoolFunc onPressed;

  const AddToCartAlertDialogWidget({
    Key key,
    @required this.oldFood,
    @required this.newFood,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("تنبيه !"),
//      content: Column(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          Text("You want to reset your cart and add this food ?"),
//          SizedBox(height: 10),
//          Text("Because you must add foods of the same restaurant.(${oldFood.restaurant.name})"),
//        ],
//      ),
      contentPadding: EdgeInsets.symmetric(vertical: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
            child: Text(
              "يجب عليك اختيار فقط المنتجات من نفس المطعم",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          InkWell(
            splashColor: Theme.of(context).accentColor,
            focusColor: Theme.of(context).accentColor,
            highlightColor: Theme.of(context).primaryColor,
            onTap: () {
              onPressed(newFood, reset: true);
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.15),
                      blurRadius: 5,
                      offset: Offset(0, 2)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: 'new_restaurant' +
                        this.newFood?.restaurantId.toString(),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                this.newFood?.restaurantName ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.subhead,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'اعاده ضبط سلة الشراء',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            splashColor: Theme.of(context).accentColor,
            focusColor: Theme.of(context).accentColor,
            highlightColor: Theme.of(context).primaryColor,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.15),
                      blurRadius: 5,
                      offset: Offset(0, 2)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag:
                        'old_restaurant' + this.oldFood.restaurantId.toString(),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                this.oldFood.restaurantName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.subhead,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'الحفاظ على الوجبات القديمة من هذا المطعم',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: new Text("اعاده ضبط"),
          onPressed: () {
            onPressed(newFood, reset: true);
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: new Text("اغلاق"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
