import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/controllers/map_controller.dart';
import 'package:trip_car_client/src/elements/CardsCarouselWidget.dart';
import 'package:trip_car_client/src/elements/CircularLoadingWidget.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/route_argument.dart';

class MapWidget extends StatefulWidget {
  RouteArgument routeArgument;

  MapWidget({Key key, this.routeArgument}) : super(key: key);
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends StateMVC<MapWidget> {
  MapController _con;

  _MapWidgetState() : super(MapController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.currentCar = widget.routeArgument.param as CarData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).maps_explorer,
          style: Theme.of(context)
              .textTheme
              .title
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.my_location,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {
              _con.goCurrentLocation();
            },
          )
        ],
      ),
      body: Stack(
//        fit: StackFit.expand,
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          _con.cameraPosition == null
              ? CircularLoadingWidget(height: 0)
              : GoogleMap(
                  mapToolbarEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: _con.cameraPosition,
                  markers: Set.from(_con.allMarkers),
                  onMapCreated: (GoogleMapController controller) {
                    _con.mapController.complete(controller);
                  },
                  onCameraMove: (CameraPosition cameraPosition) {
                    _con.cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    _con.getRestaurantsOfArea();
                  },
                  polylines: _con.polylines,
                ),
          CardsCarouselWidget(
            carsList: _con.topCars,
            heroTag: 'map_restaurants',
          ),
        ],
      ),
    );
  }
}
