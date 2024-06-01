// this page is used to handle main layout of our app,
// that have HomeScreen, ProfileScreen, NewArticlePage, SearchPage, NotificationScreen
// Responsibilities: Nguyen Phuoc Truong

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:news_reading/core/app_export.dart';
import 'package:news_reading/pages/home_screen/home_screen.dart';
import 'package:news_reading/pages/login_screen/login_screen.dart';
import 'package:news_reading/pages/new_article_page/new_article_page.dart';
import 'package:news_reading/pages/notification/notification.dart';
import 'package:news_reading/pages/profile_screen/profile_screen.dart';
import 'package:news_reading/pages/search_page/search_page.dart';
import 'package:news_reading/provider/home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key})
      : super(
          key: key,
        );

  @override
  _HomePageState createState() => _HomePageState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: HomePage(),
    );
  }
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  // This is a build method for a widget, which describes the part of the user interface represented by the widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This is a bottom navigation bar. It's a strip at the bottom of the screen with buttons to navigate between different views in the app.
      bottomNavigationBar: ConvexAppBar(
        // The style of the tab items. In this case, the items react with a circular animation when clicked.
        style: TabStyle.reactCircle,
        // The items in the navigation bar. Each item has an icon and a title.
        items: [
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.person, title: "Profile"),
          TabItem(icon: Icons.add, title: "Add"),
          TabItem(icon: Icons.search, title: "Search"),
          TabItem(icon: Icons.notifications, title: "Notifications"),
        ],
        activeColor: Colors.white,
        initialActiveIndex: 0,
        // A function that's called when an item is tapped. The function updates the current page index.
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),

      // Pages
      // The main content of the scaffold. It's an array of widgets that represent different pages in the app.
      // The displayed page corresponds to the current page index.
      body: <Widget>[
        HomeScreen(),
        // If the user is not logged in, show the Login screen/New Article screen. Otherwise, show the new article page.
        (context.watch<HomeProvider>().isLogin == false)
            ? LoginScreen()
            : ProfileScreen(),
        (context.watch<HomeProvider>().isLogin == false)
            ? LoginScreen()
            : NewArticlePage(),
        SearchPage(),
        NotificationScreen(),
      ][currentPageIndex],
    );
  }
}
