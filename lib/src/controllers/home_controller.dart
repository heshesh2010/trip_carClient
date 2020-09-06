import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/category.dart';
import 'package:trip_car_client/src/models/review_entity.dart';
import 'package:trip_car_client/src/repository/car_repository.dart';
import 'package:trip_car_client/src/repository/category_repository.dart';
import 'package:trip_car_client/src/repository/settings_repository.dart';

class HomeController extends ControllerMVC {
  List<Category> categories = <Category>[];
  List<CarData> topCars = <CarData>[];
  List<CarData> recentCars = <CarData>[];

  List<ReviewData> recentReviews = <ReviewData>[];

  HomeController() {
    listenForCategories();
    listenForTopCars();
    listenForRecentCars();

    listenForRecentReviews();
  }

  void listenForCategories() async {
    final Stream<Category> stream = await getCategories();
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForTopCars() async {
    getCurrentLocation().then((LocationData _locationData) async {
      final Stream<CarData> stream =
          await getTopCars(_locationData, _locationData);
      stream.listen((CarData _car) {
        setState(() => topCars.add(_car));
      }, onError: (a) {
        print(a);
      }, onDone: () {});
    });
  }

  void listenForRecentCars() async {
    getCurrentLocation().then((LocationData _locationData) async {
      final Stream<CarData> stream =
          await getRecentCars(_locationData, _locationData);
      stream.listen((CarData _car) {
        setState(() => recentCars.add(_car));
      }, onError: (a) {
        print(a);
      }, onDone: () {});
    });
  }

  void listenForRecentReviews() async {
    final Stream<ReviewData> stream = await getRecentReviews();
    stream.listen((ReviewData _review) {
      setState(() => recentReviews.add(_review));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> refreshHome() async {
    categories = <Category>[];
    topCars = <CarData>[];
    recentReviews = <ReviewData>[];
    listenForCategories();
    listenForTopCars();
    listenForRecentReviews();
  }
}
