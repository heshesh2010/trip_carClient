import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:restaurant_rlutter_ui/src/models/food.dart';
import 'package:restaurant_rlutter_ui/src/models/gallery.dart';
import 'package:restaurant_rlutter_ui/src/models/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/models/review.dart';
import 'package:restaurant_rlutter_ui/src/repository/food_repository.dart';
import 'package:restaurant_rlutter_ui/src/repository/gallery_repository.dart';
import 'package:restaurant_rlutter_ui/src/repository/restaurant_repository.dart';

class RestaurantController extends ControllerMVC {
  Restaurant restaurant;
  List<Gallery> galleries = <Gallery>[];
  List<Food> foods = <Food>[];
  List<Food> trendingFoods = <Food>[];
  List<Food> featuredFoods = <Food>[];
  List<Review> reviews = <Review>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  RestaurantController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForRestaurant({String id, String message}) async {
    final Stream<Restaurant> stream = await getRestaurant(id);
    stream.listen((Restaurant _restaurant) {
      setState(() => restaurant = _restaurant);
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Verify your internet connection'),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listenForGalleries(String idRestaurant) async {
    final Stream<Gallery> stream = await getGalleries(idRestaurant);
    stream.listen((Gallery _gallery) {
      setState(() => galleries.add(_gallery));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForRestaurantReviews({String id, String message}) async {
    final Stream<Review> stream = await getRestaurantReviews(id);
    stream.listen((Review _review) {
      setState(() => reviews.add(_review));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForFoods(String idRestaurant) async {
    final Stream<Food> stream = await getFoodsOfRestaurant(idRestaurant);
    stream.listen((Food _food) {
      setState(() => foods.add(_food));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  void listenForTrendingFoods(String idRestaurant) async {
    final Stream<Food> stream = await getTrendingFoodsOfRestaurant(idRestaurant);
    stream.listen((Food _food) {
      setState(() => trendingFoods.add(_food));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  void listenForFeaturedFoods(String idRestaurant) async {
    final Stream<Food> stream = await getFeaturedFoodsOfRestaurant(idRestaurant);
    stream.listen((Food _food) {
      setState(() => featuredFoods.add(_food));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> refreshRestaurant() async {
    var _id = restaurant.id;
    restaurant = new Restaurant();
    galleries.clear();
    reviews.clear();
    featuredFoods.clear();
    listenForRestaurant(id: _id, message: 'Restaurant refreshed successfuly');
    listenForRestaurantReviews(id: _id);
    listenForGalleries(_id);
    listenForFeaturedFoods(_id);
  }
}
