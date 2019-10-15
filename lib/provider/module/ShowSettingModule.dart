import 'package:flutter/material.dart';

class ShowSettingModule with ChangeNotifier {
  bool _isShowSetting = false;
  bool get value => _isShowSetting;

  void switchShowSetting() {
    print("switchShowSetting");
    _isShowSetting = !_isShowSetting;
    notifyListeners();
  }

  void setShowSettingVisible(bool visible) {
    _isShowSetting = visible;
    notifyListeners();
  }
}