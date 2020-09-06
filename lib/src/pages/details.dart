import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/controllers/restaurant_controller.dart';
import 'package:trip_car_client/src/elements/ReviewsListWidget.dart';
import 'package:trip_car_client/src/elements/buildSeparator.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/order_entity.dart';
import 'package:trip_car_client/src/models/route_argument.dart';
import 'package:trip_car_client/src/repository/settings_repository.dart';

import '../repository/settings_repository.dart' as settingRepo;

class CarWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  CarWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _DetailsWidgetState createState() {
    return _DetailsWidgetState();
  }
}

class _DetailsWidgetState extends StateMVC<CarWidget> {
  CarController con;
  final RoundedLoadingButtonController btnControllerSave =
      new RoundedLoadingButtonController();

  _DetailsWidgetState() : super(CarController()) {
    con = controller;
  }

  @override
  void initState() {
    //  _con.listenForCar(id: widget.routeArgument.id);
    //   _con.listenForCarReviews(id: widget.routeArgument.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        key: con.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context).order_details,
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: RefreshIndicator(
          onRefresh: con.refreshRestaurant,
          child: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: CustomSliverDelegate(
                      expandedHeight: 250,
                      car: widget.routeArgument.car,
                      con: con),
                ),
                SliverFillRemaining(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border(
                        top: BorderSide(
                          width: 0.3,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.routeArgument?.car?.name ??
                                        "اسم السياره",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  widget.routeArgument?.car?.carAverageReview ==
                                          -1.0
                                      ? Text(S.of(context).no_reviews)
                                      : Column(
                                          children: [
                                            Row(
                                              //   mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: Helper.getStarsList(
                                                      widget.routeArgument?.car
                                                              ?.carAverageReview ??
                                                          0.0),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${S.of(context).based_on}  (${widget.routeArgument.car.reviews?.length ?? 0}) ${S.of(context).rate}",
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  BuildSeparator(screenSize),
                                  ListTile(
                                    dense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                    leading: Icon(
                                      Icons.border_color,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    title: Text(
                                      S.of(context).trip_details,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                  Text(
                                    "${S.of(context).rent_km}  ${widget.routeArgument.car.maxNumberOfKilometers?.length ?? 0} ${S.of(context).km}",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "${S.of(context).extra_km_price}  ${widget.routeArgument.car.priceOfIncreaseKilometers?.length ?? 0} ${S.of(context).riyal}",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  BuildSeparator(screenSize),
                                  ListTile(
                                    dense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                    leading: Icon(
                                      Icons.directions_car,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    title: Text(
                                      S.of(context).information,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.routeArgument.car?.address ??
                                              "لايوجد عنوان",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style:
                                              Theme.of(context).textTheme.body2,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: SizedBox(
                                          width: 42,
                                          height: 42,
                                          child: FlatButton(
                                            padding: EdgeInsets.all(0),
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  'Map',
                                                  arguments: new RouteArgument(
                                                      param: widget
                                                          .routeArgument.car));
                                            },
                                            child: Icon(
                                              Icons.directions,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 24,
                                            ),
                                            color: Theme.of(context)
                                                .unselectedWidgetColor
                                                .withOpacity(0.9),
                                            shape: StadiumBorder(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  widget.routeArgument.car.reviews.isEmpty
                                      ? SizedBox(height: 5)
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: ListTile(
                                            dense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0),
                                            leading: Icon(
                                              Icons.recent_actors,
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                            title: Text(
                                              S.of(context).what_they_say,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                            ),
                                          ),
                                        ),
                                  widget.routeArgument.car.reviews.isEmpty
                                      ? SizedBox(height: 5)
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: ReviewsListWidget(
                                              reviewsList: widget
                                                  .routeArgument.car.reviews),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  CarController con;
  CarData car;
  CustomSliverDelegate({
    @required this.expandedHeight,
    this.hideTitleWhenExpanded = false,
    this.car,
    this.con,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          SizedBox(
              height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
              width: double.infinity,
              child: Container(
                  child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: car?.image ?? "",
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.fitHeight,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ))),
          Positioned(
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 35.0,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: car.user?.image ?? "",
                        imageBuilder: (context, imageProvider) => Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fill),
                          ),
                        ),
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading2.gif',
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car.user?.username ?? "",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          S.of(context).car_owner,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 250,
                      child: FlatButton(
                        child: Text(
                          S.of(context).booking,
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                        //  controller: btnControllerSave,
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          con?.user?.apiToken != null
                              ? show(context)
                              : FlushbarHelper.createError(
                                      message: "يجب تسجيل الدخول اولا")
                                  .show(context);
                          // btnControllerSave.stop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: -1,
            left: 0,
            right: 0,
          ),
          Positioned(
              left: -80.0,
              right: 100.0,
              top: cardTopPosition > 0 ? cardTopPosition : 0,
              bottom: 30.0,
              child: Opacity(
                  opacity: percent,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 80 * percent, horizontal: 120 * percent),
                      child: Card(
                        color: Theme.of(context).highlightColor,
                        elevation: 20.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              car?.rentPricePerDay ?? "0",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              S.of(context).riyal_per_day,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ))))
        ],
      ),
    );
  }

  show(context) async {
    DateTimeRange picked;
    if (DateTime.now().isAfter(DateTime.parse(car.availableDates.first.from))) {
      picked = await showDateRangePicker(
          initialEntryMode: DatePickerEntryMode.calendar,
          context: context,
          // currentDate: DateTime.parse(car.availableDates.first.from),
          saveText: S.of(context).booking,
          firstDate: DateTime.now(),
          lastDate: DateTime.parse(car.availableDates.first.to),
          confirmText: S.of(context).booking,
          locale: settingRepo.setting.value.mobileLanguage.value);
    } else {
      picked = await showDateRangePicker(
          initialEntryMode: DatePickerEntryMode.calendar,
          context: context,
          // currentDate: DateTime.parse(car.availableDates.first.from),
          saveText: S.of(context).booking,
          firstDate: DateTime.parse(car.availableDates.first.from),
          lastDate: DateTime.parse(car.availableDates.first.to),
          confirmText: S.of(context).booking,
          locale: settingRepo.setting.value.mobileLanguage.value);
    }
    int total = (int.parse(car?.rentPricePerDay ?? 0) * picked.duration.inDays);
    double tax = total * (setting.value.defaultTax / 100);
    double totalAfterTax = tax + total;

    OrderData _order = new OrderData();
    _order.payment..price = totalAfterTax;
    _order.car..id = car.id;
    _order..from = Helper.getDateOnly(picked.start.toString());
    _order..to = Helper.getDateOnly(picked.end.toString());

    showDialog(
      context: context,
      child: new AlertDialog(
        title: Text("${S.of(context).confirmation}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                " ${S.of(context).selected_date} ${picked.duration.inDays} ${S.of(context).day} "),
            Text(
                " ${S.of(context).order_from} ${Helper.getDateOnly(picked.start.toString())} "),
            Text(
                "${S.of(context).order_to}${Helper.getDateOnly(picked.end.toString())} "),
            Text("${S.of(context).subtotal} $total ${S.of(context).riyal}"),
            Text("${S.of(context).tax} $tax ${S.of(context).riyal}"),
            Text(
                "${S.of(context).total} $totalAfterTax ${S.of(context).riyal} "),
          ],
        ),
        actions: [
          new FlatButton(
            child: Text("${S.of(context).pay}"),
            onPressed: () => Navigator.of(context)
                .pushNamed('Checkout', arguments: RouteArgument(order: _order)),
          ),
          new FlatButton(
            child: Text("${S.of(context).cancel}"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
