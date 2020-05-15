import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/controllers/home_controller.dart';
import 'package:trip_car_client/src/elements/CardsCarouselWidget.dart';
import 'package:trip_car_client/src/elements/CaregoriesCarouselWidget.dart';
import 'package:trip_car_client/src/elements/FoodsCarouselWidget.dart';
import 'package:trip_car_client/src/elements/ReviewsListWidget.dart';
import 'package:trip_car_client/src/elements/SearchBarWidget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {
  HomeController _con;
  _HomeWidgetState() : super(HomeController()) {
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _con.refreshHome,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBarWidget(),
            ),
            ListTile(
              leading: Icon(
                Icons.directions_car,
                color: Theme.of(context).hintColor,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.yellow, // Text colour here
                      width: 2.0, // Underline width
                    ))),
                    child: Text(
                      "السيارات المضافة حديثا",
                      style: TextStyle(
                        color: Colors.black, // Text colour here
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                S.of(context).ordered_by_nearby_first,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            CardsCarouselWidget(
                restaurantsList: _con.topRestaurants,
                heroTag: 'home_top_restaurants'),
            _con.trendingFoodsIsEmpty
                ? Container()
                : ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    leading: Icon(
                      Icons.trending_up,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(S.of(context).trending_this_week,
                        style: Theme.of(context).textTheme.display1),
                    subtitle: Text(
                      S.of(context).double_click_on_the_food_to_add_it_to_the,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .merge(TextStyle(fontSize: 11)),
                    ),
                  ),
            _con.trendingFoodsIsEmpty
                ? Container()
                : FoodsCarouselWidget(
                    foodsList: _con.trendingFoods,
                    heroTag: 'home_food_carousel'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.category,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  S.of(context).food_categories,
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            CategoriesCarouselWidget(
              categories: _con.categories,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 20),
                leading: Icon(
                  Icons.recent_actors,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  S.of(context).recent_reviews,
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ReviewsListWidget(reviewsList: _con.recentReviews),
            ),
          ],
        ),
      ),
    );
  }
}
