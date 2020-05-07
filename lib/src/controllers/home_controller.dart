import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/models/ad.dart';
import 'package:order_client_app/src/models/category.dart';
import 'package:order_client_app/src/models/food.dart';
import 'package:order_client_app/src/models/restaurant.dart';
import 'package:order_client_app/src/models/review.dart';
import 'package:order_client_app/src/repository/ads_repository.dart';
import 'package:order_client_app/src/repository/category_repository.dart';
import 'package:order_client_app/src/repository/food_repository.dart';
import 'package:order_client_app/src/repository/restaurant_repository.dart';
import 'package:order_client_app/src/repository/settings_repository.dart';

class HomeController extends ControllerMVC {
  List<Category> categories = <Category>[];
  List<Restaurant> topRestaurants = <Restaurant>[];
  List<Ad> ads = <Ad>[];

  List<Review> recentReviews = <Review>[];
  List<Food> trendingFoods = <Food>[];

  bool trendingFoodsIsEmpty = false;

  HomeController() {
    listenForAds();
    listenForCategories();
    listenForTopRestaurants();
    listenForRecentReviews();
    listenForTrendingFoods();
  }

  void listenForCategories() async {
    final Stream<Category> stream = await getCategories();
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForAds() async {
    final Stream<Ad> stream = await getAds();
    stream.listen((Ad _ad) {
      setState(() => ads.add(_ad));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForTopRestaurants() async {
    getCurrentLocation().then((LocationData _locationData) async {
      final Stream<Restaurant> stream =
          await getNearRestaurants(_locationData, _locationData);
      stream.listen((Restaurant _restaurant) {
        setState(() => topRestaurants.add(_restaurant));
      }, onError: (a) {}, onDone: () {});
    });
  }

  void listenForRecentReviews() async {
    final Stream<Review> stream = await getRecentReviews();
    stream.listen((Review _review) {
      setState(() => recentReviews.add(_review));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForTrendingFoods() async {
    final Stream<Food> stream = await getTrendingFoods();
    stream.listen((Food _food) {
      setState(() => trendingFoods.add(_food));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      setState(
          () => trendingFoodsIsEmpty = trendingFoods.isEmpty ? true : false);
    });
  }

  Future<void> refreshHome() async {
    categories = <Category>[];
    topRestaurants = <Restaurant>[];
    recentReviews = <Review>[];
    trendingFoods = <Food>[];
    ads = <Ad>[];
    listenForAds();
    listenForCategories();
    listenForTopRestaurants();
    listenForRecentReviews();
    listenForTrendingFoods();
  }
}
