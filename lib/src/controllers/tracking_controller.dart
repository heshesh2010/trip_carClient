import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/src/helpers/helper.dart';
import 'package:trip_car_client/src/models/order_entity.dart';
import 'package:trip_car_client/src/models/order_status_entity.dart';
import 'package:trip_car_client/src/models/user_entity.dart';
import 'package:trip_car_client/src/repository/user_repository.dart';

class TrackingController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  bool loading = false;

  UserDataUser currentUser;
  getUser() async {
    this.currentUser = await getCurrentUser();
  }

  TrackingController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  List<Step> getTrackingSteps(
      BuildContext context, ordersStatus, OrderData order) {
    List<Step> _orderStatusSteps = [];
    ordersStatus.forEach((OrderStatusData _orderStatus) {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          _orderStatus.name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: order.statusId == _orderStatus.id
            ? Text(
                " أخر تحديث للحاله : ${Helper.getTimeOnly(order.updatedAt)}",
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
              )
            : SizedBox(height: 0),
        content: SizedBox(
            width: double.infinity,
            child: Text(
              '${Helper.skipHtml("")}',
            )),
        isActive: (int.tryParse(order.statusId.toString())) >=
            (int.tryParse(_orderStatus.id.toString())),
      ));
    });
    return _orderStatusSteps;
  }
}
