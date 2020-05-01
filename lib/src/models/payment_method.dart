class PaymentMethod {
  String name;
  String description;
  String logo;
  String route;
  bool isDefault;

  PaymentMethod(this.name, this.description, this.route, this.logo,
      {this.isDefault = false});
}

class PaymentMethodList {
  List<PaymentMethod> _paymentsList;
  List<PaymentMethod> _cashList;

  PaymentMethodList() {
    this._paymentsList = [
      new PaymentMethod("دفع الكترونى", "اضغط للدفع بواسطة البطاقات الأئتمانية",
          "Checkout", "assets/img/visacard.png",
          isDefault: true),
    ];
    this._cashList = [
      new PaymentMethod("دفع عند الاستلام", "للدفع عند الذهاب للمطعم",
          "PayOnPickup", "assets/img/pay_pickup.png"),
    ];
  }

  List<PaymentMethod> get paymentsList => _paymentsList;
  List<PaymentMethod> get cashList => _cashList;
}
