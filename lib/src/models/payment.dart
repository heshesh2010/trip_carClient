import 'dart:convert';

class Payment {
  int id;
  double price;
  int userId;
  String status;
  String method;
  String referenceId;
  Payment(
      {this.id,
      this.price,
      this.userId,
      this.status,
      this.method,
      this.referenceId});

  factory Payment.fromJson(String str) => Payment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Payment.fromMap(Map<String, dynamic> json) => Payment(
        id: json["id"],
        userId: json["user_id"],
        status: json["status"],
        method: json["method"],
        price: double.parse(json["price"]),
      );

  Map<String, dynamic> toMap() => {
        "method": method,
        "reference_id": referenceId,
      };
}
