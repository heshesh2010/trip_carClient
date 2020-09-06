import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/helpers/maps_util.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/repository/car_repository.dart';
import 'package:trip_car_client/src/repository/settings_repository.dart'
    as sett;

class MapController extends ControllerMVC {
  CarData currentCar;
  List<CarData> topCars = <CarData>[];
  List<Marker> allMarkers = <Marker>[];
  LocationData currentLocation;
  Set<Polyline> polylines = new Set();
  CameraPosition cameraPosition;
  MapsUtil mapsUtil = new MapsUtil();
  Completer<GoogleMapController> mapController = Completer();

  MapController() {
    getCurrentLocation();
    getDirectionSteps();
  }

  void listenForNearCars(
      LocationData myLocation, LocationData areaLocation) async {
    final Stream<CarData> stream = await getNearCars(myLocation, areaLocation);
    stream.listen((CarData _car) {
      setState(() {
        topCars.add(_car);
      });
      Helper.getMarker(_car.toJson()).then((marker) {
        setState(() {
          allMarkers.add(marker);
        });
      });
    }, onError: (a) {}, onDone: () {});
  }

  void getCurrentLocation() async {
    try {
      currentLocation = await sett.getCurrentLocation();
      setState(() {
        cameraPosition = CameraPosition(
          target: LatLng(double.parse(currentCar.latitude),
              double.parse(currentCar.longitude)),
          zoom: 14.4746,
        );
      });
      Helper.getMyPositionMarker(
              currentLocation.latitude, currentLocation.longitude)
          .then((marker) {
        setState(() {
          allMarkers.add(marker);
        });
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }

  Future<void> goCurrentLocation() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 14.4746,
    )));
  }

  void getRestaurantsOfArea() async {
    setState(() {
      topCars = <CarData>[];
      LocationData areaLocation = LocationData.fromMap({
        "latitude": cameraPosition.target.latitude,
        "longitude": cameraPosition.target.longitude
      });
      if (cameraPosition != null) {
        listenForNearCars(currentLocation, areaLocation);
      } else {
        listenForNearCars(currentLocation, currentLocation);
      }
    });
  }

  void getDirectionSteps() async {
    currentLocation = await sett.getCurrentLocation();
    mapsUtil
        .get("origin=" +
            currentLocation.latitude.toString() +
            "," +
            currentLocation.longitude.toString() +
            "&destination=" +
            currentCar.latitude +
            "," +
            currentCar.longitude +
            "&key=${GlobalConfiguration().getString('google_maps_key')}")
        .then((String res) {
      setState(() {
        polylines.add(Polyline(
            polylineId: new PolylineId(currentLocation.hashCode.toString()),
            width: 3,
            geodesic: true,
            points: Helper.convertToLatLng(Helper.decodePoly(res)),
            color: Color(0xFFea5c44)));
      });
    });
  }

  Future refreshMap() async {
    setState(() {
      topCars = <CarData>[];
    });
    listenForNearCars(currentLocation, currentLocation);
  }
}
