import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:news_reading/core/app_export.dart';
import 'package:news_reading/pages/home_screen/home_screen.dart';
import 'package:news_reading/pages/login_screen/login_screen.dart';
import 'package:news_reading/pages/new_article_page/new_article_page.dart';
import 'package:news_reading/pages/profile_screen/profile_screen.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/pages/splashscreen_screen/splashscreen_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Nav bar
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        items: [
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.person, title: "Profile"),
          TabItem(icon: Icons.add, title: "Add"),
          TabItem(icon: Icons.search, title: "Search"),
          TabItem(icon: Icons.notifications, title: "Notifications"),
        ],
        activeColor: Colors.white,
        initialActiveIndex: 0,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      // bottomNavigationBar: NavigationBar(
      // onDestinationSelected: (int index) {
      //   setState(() {
      //     currentPageIndex = index;
      //   });
      // },
      //   indicatorColor: Colors.blue,
      //   selectedIndex: currentPageIndex,
      //   destinations: const <Widget>[
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.home),
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Home',
      //     ),
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.person),
      //       icon: Icon(Icons.person_outlined),
      //       label: 'Profile',
      //     ),
      //     NavigationDestination(
      //       icon: Badge(child: Icon(Icons.notifications_sharp)),
      //       label: 'Notifications',
      //     ),
      //     // NavigationDestination(
      //     //   icon: Badge(
      //     //     label: Text('2'),
      //     //     child: Icon(Icons.messenger_sharp),
      //     //   ),
      //     //   label: 'Messages',
      //     // ),
      //   ],
      // ),

      // Pages
      body: <Widget>[
        HomeScreen(),
        (context.watch<HomeProvider>().futureUser == null)
            ? LoginScreen()
            : ProfileScreen(),
        (context.watch<HomeProvider>().futureUser == null)
            ? LoginScreen()
            : NewArticlePage(),
      ][currentPageIndex],
    );
  }
}
