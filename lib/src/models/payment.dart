import 'dart:convert';

class Payment {
  int id;
  double price;
  int userId;
  int status;
  String method;
  String referenceId;
  double tax;
  Payment( 
      {this.id,
      this.price,
      this.userId,
      this.status,
      this.method,
      this.tax,
      this.referenceId});

  factory Payment.fromJson(String str) => Payment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Payment.fromMap(Map<String, dynamic> json) => Payment(
        id: json["id"],
        userId: json["user_id"],
        status: json["order_status_id"],
        method: json["method"],
      );

  Map<String, dynamic> toMap() => {
        "method": method,
        "reference_id": referenceId,
      };
}
