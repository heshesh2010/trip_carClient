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

  PaymentMethodList() {
    this._paymentsList = [
      new PaymentMethod("دفع الكترونى", "اضغط للدفع بواسطة البطاقات الأئتمانية",
          "Checkout", "assets/img/visacard.png",
          isDefault: true),
    ];
  }

  List<PaymentMethod> get paymentsList => _paymentsList;
}
