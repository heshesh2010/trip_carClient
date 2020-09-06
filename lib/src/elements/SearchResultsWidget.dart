import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:trip_car_client/src/models/car_entity.dart';

import '../../generated/i18n.dart';
import '../controllers/search_controller.dart';
import '../elements/CardWidget.dart';
import '../elements/CircularLoadingWidget.dart';
import '../models/route_argument.dart';

class SearchResultWidget extends StatefulWidget {
  final String heroTag;

  SearchResultWidget({Key key, this.heroTag}) : super(key: key);

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends StateMVC<SearchResultWidget> {
  SearchController _con;
  CarDataModel _selectedModelValue;
  CarDataYear _selectedYearValue;
  CarDataCity _selectedCityValue;
  CarDataSubModel _selectedSubModelValue;
  final RoundedLoadingButtonController _btnControllerLogin =
      new RoundedLoadingButtonController();

  _SearchResultWidgetState() : super(SearchController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              trailing: IconButton(
                icon: Icon(Icons.close),
                color: Theme.of(context).hintColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                S.of(context).search,
                style: Theme.of(context).textTheme.display1,
              ),
              subtitle: Text(
                S.of(context).ordered_by_nearby_first,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onSubmitted: (text) async {
                    await _con.refreshSearch(search: text);
                    _con.saveSearch(text);
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: S.of(context).search_for_restaurants_or_foods,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .caption
                        .merge(TextStyle(fontSize: 14)),
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).accentColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.1))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.3))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.1))),
                  ),
                ),
              ),
              Expanded(
                child: RoundedLoadingButton(
                  child: Text(
                    S.of(context).search,
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  controller: _btnControllerLogin,
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    _con.refreshSearch(
                        selectedCityValue: _selectedCityValue,
                        selectedModelValue: _selectedModelValue,
                        selectedSubModelValue: _selectedSubModelValue,
                        controller: _btnControllerLogin);
                  },
                ),
              )
            ],
          ),
          buildCarModelAndSubModel(context),
          _con.cars.isEmpty
              ? CircularLoadingWidget(height: 288)
              : Expanded(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          title: Text(
                            S.of(context).recent_cars,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _con.cars.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('Car',
                                  arguments: RouteArgument(
                                    car: _con.cars.elementAt(index),
                                    heroTag: widget.heroTag,
                                  ));
                            },
                            child: CardWidget(
                                car: _con.cars.elementAt(index),
                                heroTag: widget.heroTag),
                          );
                        },
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Padding buildCarModelAndSubModel(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 5, left: 5, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2),
                        width: 1.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                ),
                child: DropdownButtonFormField<CarDataModel>(
                  value: _selectedModelValue,
                  items: _con.models
                      .map((CarDataModel model) => DropdownMenuItem(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(model.name),
                            ),
                            value: model,
                          ))
                      .toList(),
                  hint: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(S.of(context).car_marka),
                  ),
                  onChanged: (CarDataModel value) {
                    setState(() {
                      _selectedSubModelValue = null;
                      _con.listenForSubModels(value.id);
                      _con.car.model = value;
                      _selectedModelValue = value;
                    });
                  },
                  /*validator: (CarDataModel value) {
                    if (value == null) {
                      return S.of(context).you_should_choose_car_model;
                    } else {
                      return null;
                    }
                  },*/
                  isExpanded: true,
                  //  value: cat
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2),
                        width: 1.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                ),
                child: DropdownButtonFormField<CarDataSubModel>(
                  value: _selectedSubModelValue,
                  items: _con.subModels
                      .map((CarDataSubModel subModels) => DropdownMenuItem(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(subModels.name),
                            ),
                            value: subModels,
                          ))
                      .toList(),
                  hint: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(S.of(context).choose_car_sub_model),
                  ),
                  onChanged: (CarDataSubModel subModel) {
                    setState(() {
                      _con.car.subModel = subModel;
                      _selectedSubModelValue = subModel;
                    });
                  },
                  /* validator: (CarDataSubModel value) {
                    if (value == null) {
                      return S.of(context).you_should_choose_car_type;
                    } else {
                      return null;
                    }
                  },*/
                  isExpanded: true,
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2),
                        width: 1.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                ),
                child: DropdownButtonFormField<CarDataCity>(
                  value: _selectedCityValue,
                  items: _con.cities
                      .map((CarDataCity city) => DropdownMenuItem(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(city.name),
                            ),
                            value: city,
                          ))
                      .toList(),
                  hint: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(S.of(context).choose_car_city),
                  ),
                  onChanged: (CarDataCity carDataCity) {
                    setState(() {
                      _con.car.city = carDataCity;
                      _selectedCityValue = carDataCity;
                    });
                  },
                  /*   validator: (CarDataCity value) {
            if (value == null) {
              return S.of(context).should_choose_your_city;
            } else {
              return null;
            }
          },*/
                  isExpanded: true,
                  //  value: cat
                ),
              ),
            )
          ],
        ));
  }
}
