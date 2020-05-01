import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/generated/i18n.dart';
import 'package:order_client_app/src/controllers/food_controller.dart';
import 'package:order_client_app/src/elements/AddToCartAlertDialog.dart';
import 'package:order_client_app/src/elements/ExtraItemWidget.dart';
import 'package:order_client_app/src/elements/ReviewsListWidget.dart';
import 'package:order_client_app/src/elements/ShoppingCartFloatButtonWidget.dart';
import 'package:order_client_app/src/helpers/helper.dart';
import 'package:order_client_app/src/models/route_argument.dart';

// ignore: must_be_immutable
class FoodWidget extends StatefulWidget {
  RouteArgument routeArgument;

  FoodWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _FoodWidgetState createState() {
    return _FoodWidgetState();
  }
}

class _FoodWidgetState extends StateMVC<FoodWidget> {
  FoodController _con;
  List<bool> isSelected;

  _FoodWidgetState() : super(FoodController()) {
    _con = controller;
  }

  @override
  void initState() {
    isSelected = [true, false];
    //   _con.listenForFood(foodId: widget.routeArgument.id);
    _con.food = widget.routeArgument.food;
    _con.calculateTotal();
    _con.listenForCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).food,
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      key: _con.scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 120),
            padding: EdgeInsets.only(bottom: 120),
            child: CustomScrollView(
              primary: true,
              shrinkWrap: false,
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.9),
                  expandedHeight: 200,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Hero(
                      tag: (widget.routeArgument.heroTag ??= "") +
                          widget.routeArgument.food.id,
                      child: Image.network(
                        widget.routeArgument.food.image.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Wrap(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.routeArgument.food.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  Text(
                                    widget.routeArgument.food.restaurant.name,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Helper.getPrice(
                                    widget.routeArgument.food.price,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  Text(
                                    widget.routeArgument.food.size == null
                                        ? "الحجم: افتراضي"
                                        : widget.routeArgument.food.size.name +
                                            "الحجم:",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 40),
                        Text(Helper.skipHtml(
                            widget.routeArgument.food.description)),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          leading: Icon(
                            Icons.add_circle,
                            color: Theme.of(context).hintColor,
                          ),
                          title: Text(
                            S.of(context).extras,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          subtitle: Text(
                            S.of(context).select_extras_to_add_them_on_the_food,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        ListView.separated(
                          padding: EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            return ExtraItemWidget(
                              extra: widget.routeArgument.food.extras
                                  .elementAt(index),
                              onChanged: () {
                                _con.calculateTotal();
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20);
                          },
                          itemCount: widget.routeArgument.food.extras == null
                              ? 0
                              : widget.routeArgument.food.extras.length,
                          primary: false,
                          shrinkWrap: true,
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          leading: Icon(
                            Icons.donut_small,
                            color: Theme.of(context).hintColor,
                          ),
                          title: Text(
                            S.of(context).ingredients,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                        Helper.applyHtml(
                            context, widget.routeArgument.food.ingredients,
                            style: TextStyle(fontSize: 12)),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          leading: Icon(
                            Icons.timer,
                            color: Theme.of(context).hintColor,
                          ),
                          title: Text(
                            S.of(context).time,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                        Text(widget.routeArgument.food.preparationTime,
                            style: TextStyle(fontSize: 12)),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          leading: Icon(
                            Icons.recent_actors,
                            color: Theme.of(context).hintColor,
                          ),
                          title: Text(
                            S.of(context).reviews,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                        ReviewsListWidget(
                          reviewsList: widget.routeArgument.food.foodReviews,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 32,
            right: 20,
            child: _con.loadCart
                ? SizedBox(
                    width: 60,
                    height: 60,
                    child: RefreshProgressIndicator(),
                  )
                : ShoppingCartFloatButtonWidget(
                    food: widget.routeArgument.food,
                  ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 190,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).focusColor.withOpacity(0.15),
                        offset: Offset(0, -2),
                        blurRadius: 5.0)
                  ]),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            S.of(context).quantity,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                _con.decrementQuantity();
                              },
                              iconSize: 30,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              icon: Icon(Icons.remove_circle_outline),
                              color: Theme.of(context).hintColor,
                            ),
                            Text(_con.quantity.toString(),
                                style: Theme.of(context).textTheme.subhead),
                            IconButton(
                              onPressed: () {
                                _con.incrementQuantity();
                              },
                              iconSize: 30,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              icon: Icon(Icons.add_circle_outline),
                              color: Theme.of(context).hintColor,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "طريقة تحضير الوجبة",
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ToggleButtons(
                                borderColor: Theme.of(context).hintColor,
                                fillColor: Theme.of(context).hintColor,
                                focusColor: Theme.of(context).focusColor,
                                borderWidth: 2,
                                selectedBorderColor:
                                    Theme.of(context).hintColor,
                                borderRadius: BorderRadius.circular(0),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'سفرى',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).focusColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'محلى',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).focusColor),
                                    ),
                                  ),
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    for (int i = 0;
                                        i < isSelected.length;
                                        i++) {
                                      isSelected[i] = i == index;
                                    }
                                    widget.routeArgument.food.foodType =
                                        isSelected[index] ? "سفري" : "محلي";
                                  });
                                },
                                isSelected: isSelected,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _con.food.favorite!=null
                              ? OutlineButton(
                                  onPressed: () {
                                    _con.removeFromFavorite(_con.food.favorite);
                                  },
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  color: Theme.of(context).hintColor,
                                  shape: StadiumBorder(),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).hintColor),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Theme.of(context).hintColor,
                                  ))
                              : FlatButton(
                                  onPressed: () {
                                    _con.addToFavorite(
                                        widget.routeArgument.food);
                                  },
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  color: Theme.of(context).accentColor,
                                  shape: StadiumBorder(),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Theme.of(context).hintColor,
                                  )),
                        ),
                        SizedBox(width: 10),
                        Stack(
                          fit: StackFit.loose,
                          alignment: AlignmentDirectional.centerEnd,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 110,
                              child: FlatButton(
                                onPressed: () {
                                  if (_con.isSameRestaurants(
                                      widget.routeArgument.food)) {
                                    _con.addToCart(widget.routeArgument.food);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        // return object of type Dialog
                                        return AddToCartAlertDialogWidget(
                                            oldFood: _con.cart?.food,
                                            newFood: widget.routeArgument.food,
                                            onPressed: (food, {reset: true}) {
                                              return _con.addToCart(
                                                  widget.routeArgument.food,
                                                  reset: true);
                                            });
                                      },
                                    );
                                  }
                                },
                                padding: EdgeInsets.symmetric(vertical: 14),
                                color: Theme.of(context).accentColor,
                                shape: StadiumBorder(),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    S.of(context).add_to_cart,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Helper.getPrice(
                                _con.total,
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .merge(TextStyle(
                                        color: Theme.of(context).hintColor)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
