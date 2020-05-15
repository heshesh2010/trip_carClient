import 'package:trip_car_client/src/models/food.dart';
import 'package:trip_car_client/src/models/payment.dart';

import 'order.dart';
import 'order_status.dart';

class RouteArgument {
  int id;
  String heroTag;
  Food food;
  dynamic param;
  Order order;
  List<OrderStatus> ordersStatus;
  Payment payment;
  RouteArgument(
      {this.id,
      this.heroTag,
      this.param,
      this.food,
      this.order,
      this.ordersStatus,
      this.payment});

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}
