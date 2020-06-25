import 'package:flutter/cupertino.dart';

class ConfigProvider extends ChangeNotifier{
  bool isRTL = false;
  Locale locale = Locale('en', 'US');

  bool get getRTL => this.isRTL;

  Locale get getLanguage => this.locale;

  setRTL(bool flag) {
    this.isRTL = flag;
    notifyListeners();
  }

  setLanguage(Locale locale) {
    this.locale = locale;
    notifyListeners();
  }
}