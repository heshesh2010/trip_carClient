import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/models/car_entity.dart';

class WalkthroughController extends ControllerMVC {
  List<CarData> topCars = <CarData>[];

  WalkthroughController() {
    //listenForTopRestaurants();
  }
//  void listenForTopRestaurants() async {
//    LocationData _locationData = await getCurrentLocation();
//    final Stream<Restaurant> stream = await getNearRestaurants(_locationData, _locationData);
//    stream.listen((Restaurant _restaurant) {
//      setState(() => topRestaurants.add(_restaurant));
//    }, onError: (a) {}, onDone: () {});
//  }
}
