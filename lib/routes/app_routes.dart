import 'package:flutter/material.dart';
import 'package:news_reading/pages/home_page/home_page.dart';
import 'package:news_reading/pages/new_article_page/new_article_page.dart';
import 'package:news_reading/pages/update_user_page/update_user_page.dart';
import 'package:news_reading/pages/user_profile/user_profile.dart';
import '../pages/article_screen/article_screen.dart';
import '../pages/onboard/onboarding.dart';
import '../pages/profile_screen/profile_screen.dart';

class AppRoutes {
  static const String splashscreenScreen = '/splashscreen_screen';
  static const String articleScreen = '/article_screen';
  static const String profileScreen = '/profile_screen';
  static const String newArticlePage = '/new_article_page';
  static const String homeRoute = '/home_page';
  static const String loginRoute = '/login_screen';
  static const String searchRoute = '/search';
  static const String onBoard = '/on_board';
  static const String profileDetails = '/profile_details';
  static const String userProfile = '/user_profile';

  static Map<String, WidgetBuilder> get routes => {
        articleScreen: (context) => ArticleScreen(),
        profileScreen: ProfileScreen.builder,
        newArticlePage: NewArticlePage.builder,
        homeRoute: HomePage.builder,
        onBoard: (context) => OnBoarding(),
        profileDetails: (context) => ProfileDetails(),
        userProfile: (context) => UserProfile()
      };
}
