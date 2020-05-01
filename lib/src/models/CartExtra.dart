import 'extra.dart';

class CartExtra {
  int extraId;
  int cartId;
  Extra cartExtra;

  CartExtra({
    this.extraId,
    this.cartId,
    this.cartExtra,
  });

  factory CartExtra.fromMap(Map<String, dynamic> json) => CartExtra(
        extraId: json["extra_id"],
        cartId: json["cart_id"],
        cartExtra: Extra.fromJSON(json["cart_extra"]),
      );

  Map<String, dynamic> toMap() => {
        "extra_id": extraId,
        "cart_id": cartId,
        "cart_extra": cartExtra.toMap(),
      };
}
