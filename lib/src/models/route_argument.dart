import 'package:trip_car_client/src/models/car_entity.dart';
import 'package:trip_car_client/src/models/order_entity.dart';

class RouteArgument {
  int id;
  String heroTag;
  dynamic param;
  OrderData order;
  List<OrderDataStatus> ordersStatus;
  OrderDataPayment payment;
  CarData car;
  int total;
  RouteArgument(
      {this.id,
      this.heroTag,
      this.param,
      this.order,
      this.ordersStatus,
      this.car,
      this.total,
      this.payment});

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}
