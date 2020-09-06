import 'package:flutter/cupertino.dart';

class Setting {
  String appName = "TRIP-1";
  double defaultTax;
  String defaultCurrency;
  bool currencyRight = false;

  ValueNotifier<Locale> mobileLanguage = new ValueNotifier(Locale('ar', 'SA'));
  String appVersion;
  bool enableVersion = true;
  String howUserWork;

  ValueNotifier<Brightness> brightness = new ValueNotifier(Brightness.light);

  Setting();

  Setting.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      appName = jsonMap['app_name'] ?? "TRIP-1";
      mobileLanguage.value = Locale(jsonMap['mobile_language'] ?? "ar", 'SA');
      appVersion = jsonMap['app_version'] ?? '';
      enableVersion =
          jsonMap['enable_version'] == null || jsonMap['enable_version'] == '0'
              ? false
              : true;
      defaultTax = double.tryParse(jsonMap['default_tax'] ?? 0) ?? 0.0;
      defaultCurrency = jsonMap['default_currency'] ?? 'ر.س';
      currencyRight =
          jsonMap['currency_right'] == null || jsonMap['currency_right'] == '0'
              ? false
              : true;
      howUserWork = jsonMap['How_user_work'] ?? '';
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["app_name"] = appName;
    map["default_tax"] = defaultTax;
    map["default_currency"] = defaultCurrency;
    map["currency_right"] = currencyRight;
    map["mobile_language"] = mobileLanguage.value.languageCode;
    map["How_user_work"] = howUserWork;

    return map;
  }
}
