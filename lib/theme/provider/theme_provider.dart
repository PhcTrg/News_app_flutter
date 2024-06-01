// this page is used to manage theme and color
// Responsibilities: Nguyen Phuoc Truong

import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class ThemeProvider extends ChangeNotifier {
  themeChange(String themeType) async {
    PrefUtils().setThemeData(themeType);
    notifyListeners();
  }
}
