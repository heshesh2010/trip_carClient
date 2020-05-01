import 'dart:convert';


class Pivot {
  int orderId;
  int foodId;
  int quantity;
  String foodType;

  Pivot({
    this.orderId,
    this.foodId,
    this.quantity,
    this.foodType,
  });

  factory Pivot.fromJson(String str) => Pivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
    orderId: json["order_id"],
    foodId: json["food_id"],
    quantity: json["quantity"],
    foodType: json["food_type"],
  );

  Map<String, dynamic> toMap() => {
    "order_id": orderId,
    "food_id": foodId,
    "quantity": quantity,
    "food_type": foodType,
  };
}