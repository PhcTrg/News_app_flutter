import 'package:flutter/material.dart';
import 'package:news_reading/pages/home_page/home_page.dart';
import 'package:news_reading/pages/new_article_page/new_article_page.dart';
import '../pages/article_screen/article_screen.dart';
import '../pages/profile_screen/profile_screen.dart';
import '../pages/splashscreen_screen/splashscreen_screen.dart';

class AppRoutes {
  static const String splashscreenScreen = '/splashscreen_screen';

  static const String articleScreen = '/article_screen';

  static const String profileScreen = '/profile_screen';

  static const String newArticlePage = '/new_article_page';

  static const String homeRoute = '/home_page';

  static const String loginRoute = '/login_screen';

  static Map<String, WidgetBuilder> get routes => {
        splashscreenScreen: SplashscreenScreen.builder,
        articleScreen: (context) => ArticleScreen(),
        profileScreen: ProfileScreen.builder,
        newArticlePage: NewArticlePage.builder,
        // loginRoute: LoginScreen.builder,
        homeRoute: HomePage.builder
      };
}
