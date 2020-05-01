import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';

enum Type {
  faq,
  extra,
  product,
  cards,
  orders,
  image,
  images,
  complex,
  statics
}

class ShimmerHelper extends StatefulWidget {
  final Type type;
  const ShimmerHelper({Key key, @required this.type}) : super(key: key);
  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<ShimmerHelper> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colr;
//  final Common common = Common();

  @override
  void initState() {
    start(context);
    _startAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        switch (widget.type) {
          case Type.extra:
            return extra();
            break;
          case Type.faq:
            return faq();
            break;
          case Type.cards:
            return card();
            break;
          case Type.orders:
            return shimmerList(orders());
            break;
          case Type.image:
            return image();
            break;
          case Type.images:
            return shimmerList(image());
            break;
          case Type.complex:
            return complex();
            break;
          case Type.product:
            return product();
            break;
          case Type.statics:
            return statics();
          default:
            return CircularProgressIndicator();
        }
      },
    );
  }

  Widget shimmerGrid(bool preview) {
    return GridView.builder(
      padding: EdgeInsets.all(2),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: preview ? 4 : 3,
          childAspectRatio: preview ? 0.85 : 0.95,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4),
      itemCount: preview ? 8 : 50,
      itemBuilder: (c, int i) {
        return service();
      },
    );
  }

  Widget service() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1.75,
          ),
          color: _colr.value,
          shape: BoxShape.circle),
    );
  }

  Widget faq() {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: _colr.value,
            elevation: 0,
            centerTitle: true,
            bottom: PreferredSize(
              child: Container(
                decoration: BoxDecoration(
                    color: _colr.value,
                    borderRadius: BorderRadius.circular(20)),
              ),
              preferredSize: Size.fromHeight(30),
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //       SearchBarWidget(),
            SizedBox(height: 15),

            ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 5),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: 3,
              separatorBuilder: (context, index) {
                return SizedBox(height: 15);
              },
              itemBuilder: (context, indexFaq) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        height: 20,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: _colr.value,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5))),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: _colr.value,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ));
  }

  Widget product() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                color: _colr.value, borderRadius: BorderRadius.circular(10)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: _colr.value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: _colr.value),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: _colr.value),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: _colr.value),
          ),
        ),
      ],
    );
  }

  Widget statics() {
    return Container(
        height: 300,
        child: shimmerListAsRow(Container(
          width: 292,
          margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
          decoration: BoxDecoration(
            color: _colr.value,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.1),
                  blurRadius: 15,
                  offset: Offset(0, 5)),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Image of the card
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(),
                          Container(),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }

  Widget extra() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                color: _colr.value, borderRadius: BorderRadius.circular(10)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: _colr.value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: _colr.value),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: _colr.value),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget shimmerList(Widget shimmer) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (c, int i) {
        return shimmer;
      },
    );
  }

  Widget shimmerListAsRow(Widget shimmer) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: 2,
      itemBuilder: (c, int i) {
        return shimmer;
      },
    );
  }

  Widget complex() {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (c, int i) {
        return orders();
      },
    );
  }

  Widget orders() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: _colr.value),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 15,
                  width: 150,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: _colr.value,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 12,
                  width: 100,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: _colr.value,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget card() {
    return Container(
      height: 130,
      child: shimmerListAsRow(Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        width: 100,
        height: 130,
        decoration: BoxDecoration(
          color: _colr.value,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      )),
    );
  }

  Widget image() {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 35.0,
                backgroundColor: _colr.value,
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 12,
                    width: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: _colr.value,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Container(
                      height: 12,
                      width: 50,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: _colr.value,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                height: 12,
                width: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: _colr.value,
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(height: 5.0),
            ],
          ),
        ],
      ),
    );
  }

  void start(BuildContext context) {
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _colr = ColorTween(begin: Colors.black45, end: Colors.grey.shade100)
        .animate(CurvedAnimation(
            parent: _controller,
            curve: Interval(0.1, 1, curve: Curves.easeIn)));
  }

  Future _startAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
      _startAnimation();
    } on TickerCanceled {}
  }
}
