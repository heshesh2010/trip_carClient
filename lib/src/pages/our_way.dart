import 'package:flutter/material.dart';
import 'package:trip_car_client/src/repository/settings_repository.dart';

class OurWayWidget extends StatefulWidget {
  @override
  _OurWayWidgetState createState() => _OurWayWidgetState();
}

class _OurWayWidgetState extends State<OurWayWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          centerTitle: true,
          title: Text("طريقتنا"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
            color: Theme.of(context).hintColor,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 30),
              child: Container(
                child: Center(
                  child: Text(
                    setting?.value?.howUserWork ?? "لا يوجد محتوى",
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 10,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
