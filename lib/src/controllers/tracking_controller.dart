import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/src/helpers/helper.dart';
import 'package:order_client_app/src/models/order.dart';
import 'package:order_client_app/src/models/order_status.dart';
import 'package:order_client_app/src/models/user.dart';
import 'package:order_client_app/src/repository/order_repository.dart'
    as orderRepo;
import 'package:order_client_app/src/repository/user_repository.dart';

class TrackingController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  bool loading = false;

  User currentUser;
  getUser() async {
    this.currentUser = await getCurrentUser();
  }

  TrackingController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void updateOrder(Order order) async {
    setState(() {
      loading = true;
    });
    orderRepo.updateOrder(order).then((value) {
      if (value is Order) {
        setState(() {
          loading = false;
        });
        FlushbarHelper.createSuccess(message: 'تم اضافه تحديث حاله الطلب بنجاح')
            .show(scaffoldKey.currentContext);

        Future.delayed(Duration(seconds: 3)).then((__) {
          Navigator.pop(scaffoldKey.currentContext);
        });
      } else {
        setState(() {
          loading = false;
        });
        FlushbarHelper.createError(message: 'حدث خطأ تاكد من اتصالك بالانترنت')
            .show(scaffoldKey.currentContext);
      }
    });
  }

  List<Step> getTrackingSteps(BuildContext context, ordersStatus, Order order) {
    List<Step> _orderStatusSteps = [];
    ordersStatus.forEach((OrderStatus _orderStatus) {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          _orderStatus.status,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: order.orderStatus.id == _orderStatus.id
            ? Text(
                " أخر تحديث للحاله : ${Helper.getTimeOnly(order.date)}",
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
              )
            : SizedBox(height: 0),
        content: SizedBox(
            width: double.infinity,
            child: Text(
              '${Helper.skipHtml("")}',
            )),
        isActive: (int.tryParse(order.orderStatus.id)) >=
            (int.tryParse(_orderStatus.id)),
      ));
    });
    return _orderStatusSteps;
  }
}
