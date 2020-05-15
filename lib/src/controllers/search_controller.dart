import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/restaurant.dart';
import 'package:trip_car_client/src/repository/restaurant_repository.dart';
import 'package:trip_car_client/src/repository/search_repository.dart';
import 'package:trip_car_client/src/repository/settings_repository.dart';

class SearchController extends ControllerMVC {
  List<Restaurant> restaurants = <Restaurant>[];

  SearchController() {
    listenForRestaurants();
  }

  void listenForRestaurants({String search}) async {
    if (search == null) {
      search = await getRecentSearch();
    }
    LocationData _locationData = await getCurrentLocation();
    final Stream<Restaurant> stream =
        await searchRestaurants(search, _locationData);
    stream.listen((Restaurant _restaurant) {
      setState(() => restaurants.add(_restaurant));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> refreshSearch(search) async {
    restaurants = <Restaurant>[];
    listenForRestaurants(search: search);
  }

  void saveSearch(String search) {
    setRecentSearch(search);
  }
}
