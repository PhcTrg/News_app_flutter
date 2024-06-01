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

  // static Widget builder(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (context) => HomeProvider(),
  //     child: HomePage(),
  //   );
  // }
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Nav bar
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        items: [
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.add, title: "Add"),
          TabItem(icon: Icons.person, title: "Profile"),
        ],
        activeColor: Colors.white,
        initialActiveIndex: 0,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),

      // Pages
      body: <Widget>[
        SearchPage(),
        NewArticlePage(),
        ProfileScreen(),
      ][currentPageIndex],
    );
  }
}
