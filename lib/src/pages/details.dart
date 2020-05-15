import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:trip_car_client/src/controllers/restaurant_controller.dart';
import 'package:trip_car_client/src/elements/buildSeparator.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/route_argument.dart';

class DetailsWidget extends StatefulWidget {
  RouteArgument routeArgument;

  DetailsWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _DetailsWidgetState createState() {
    return _DetailsWidgetState();
  }
}

class _DetailsWidgetState extends StateMVC<DetailsWidget> {
  RestaurantController _con;
  final RoundedLoadingButtonController btnControllerSave =
      new RoundedLoadingButtonController();
  _DetailsWidgetState() : super(RestaurantController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForRestaurant(id: widget.routeArgument.id);
    _con.listenForGalleries(widget.routeArgument.id);
    _con.listenForRestaurantReviews(id: widget.routeArgument.id);
    _con.listenForFeaturedFoods(widget.routeArgument.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        key: _con.scaffoldKey,
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: RefreshIndicator(
          onRefresh: _con.refreshRestaurant,
          child: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: CustomSliverDelegate(
                    expandedHeight: 250,
                  ),
                ),
                SliverFillRemaining(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          width: 0.3,
                          color: Colors.grey,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    "مرسيدس سي ١٨٠",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: Helper.getStarsList(4),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("بناء على ١٢ رحلة"),
                                  ],
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
                                    Icons.recent_actors,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  title: Text(
                                    "بيانات الرحلة ",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                                Text(
                                  'الحد الاقصى للكيلو متر : 100 كيلو ',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'سعر الكيلو متر الأضافي : 10 ريال ',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText1,
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
                                    color: Theme.of(context).accentColor,
                                  ),
                                  title: Text(
                                    "بيانات السيارة ",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                                Text(
                                  'اللون : أسود ',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'الماركة : مرسيدس ',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'الموديل : 2014 ',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  color: Theme.of(context).primaryColor,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          _con.restaurant.address,
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
                                                      param: _con.restaurant));
                                            },
                                            child: Icon(
                                              Icons.directions,
                                              color:
                                                  Theme.of(context).hintColor,
                                              size: 24,
                                            ),
                                            color: Theme.of(context)
                                                .accentColor
                                                .withOpacity(0.9),
                                            shape: StadiumBorder(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 250,
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20),
                            child: RoundedLoadingButton(
                              child: Text(
                                "حجز الرحلة",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor),
                              ),
                              controller: btnControllerSave,
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                // btnControllerSave.stop();
                              },
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
  CustomSliverDelegate({
    @required this.expandedHeight,
    this.hideTitleWhenExpanded = false,
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
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        "https://saudishift.com/wp-content/uploads/2015/02/2.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          Positioned(
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage: CachedNetworkImageProvider(
                          "https://pngimage.net/wp-content/uploads/2018/05/default-user-profile-image-png-6.png"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ياسر القحطاني",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          "مالك السيارة",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
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
                        color: Colors.yellow,
                        elevation: 20.0,
                        child: Center(
                          child: Text(
                            "1500 ريال / اليوم",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ))))
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
