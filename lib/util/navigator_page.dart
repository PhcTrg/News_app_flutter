import 'package:flutter/material.dart';
import 'package:news_reading/core/app_export.dart';

class NavigatorPage {
  void navigateLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginRoute);
  }

  void navigateHome(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeRoute);
  }
}
