class PaymentMethod {
  String name;
  String description;
  String logo;
  String route;
  bool isDefault;

  PaymentMethod(this.name, this.description, this.route, this.logo, {this.isDefault = false});
}

class PaymentMethodList {
  List<PaymentMethod> _paymentsList;
  List<PaymentMethod> _cashList;

  PaymentMethodList() {
    this._paymentsList = [
      new PaymentMethod("Visa Card", "اضغط للدفع بواسطة Visa Card", "/Checkout", "assets/img/visacard.png",
          isDefault: true),
      new PaymentMethod("MasterCard", "اضغط للدفع بواسطة MasterCard", "/Checkout", "assets/img/mastercard.png"),
   //   new PaymentMethod("PayPal", "Click to pay with your PayPal account", "/PayPal", "assets/img/paypal.png"),
    ];
    this._cashList = [
 //     new PaymentMethod("Cash on Delivery", "Click to pay cash on delivery", "/CashOnDelivery", "assets/img/cash.png"),
      new PaymentMethod("دفع عند الاستلام", "للدفع عند الذهاب للمطعم", "/PayOnPickup", "assets/img/pay_pickup.png"),
    ];
  }

  List<PaymentMethod> get paymentsList => _paymentsList;
  List<PaymentMethod> get cashList => _cashList;
}
