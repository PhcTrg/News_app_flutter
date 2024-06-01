import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_reading/Services/notifi_service.dart';
import 'package:news_reading/provider/article_provider.dart';
import 'package:news_reading/provider/home_provider.dart';
import 'package:news_reading/provider/profile_provider.dart';
import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

// disable default scrollbar
class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}

// This is the main function where the app starts execution.
void main() {
  // Ensures that widget binding has been done before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes the notification service.
  NotificationService().initNotification();

  // Waits for preferred screen orientations and preferences to be initialized.
  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    PrefUtils().init()
  ]).then((value) {
    // Runs the app after the above operations are done.
    runApp(
      // MultiProvider is used for multiple providers.
      // It merges multiple providers into a single linear widget tree.
      MultiProvider(
        providers: [
          // Provides HomeProvider to the rest of the widgets.
          ChangeNotifierProvider(create: (context) => HomeProvider()),
          // Provides ArticleProvider to the rest of the widgets.
          ChangeNotifierProvider(create: (context) => ArticleProvider()),
          // Provides ProfileProvider to the rest of the widgets.
          ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ],
        child: MyApp(),
      ),
    );
  });
}

// MyApp is the root widget of your application.
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Sets the primary color of the theme.
      theme: ThemeData(primaryColor: Colors.blue),
      home: Sizer(
        builder: (context, orientation, deviceType) {
          return ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
            child: Consumer<ThemeProvider>(
              builder: (context, provider, child) {
                return MaterialApp(
                  title: 'news_reading',
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                  // Sets the scroll behavior of the app.
                  scrollBehavior:
                      NoThumbScrollBehavior().copyWith(scrollbars: false),
                  // Sets the navigator key of the app.
                  navigatorKey: NavigatorService.navigatorKey,
                  // Sets the localization delegates.
                  localizationsDelegates: [
                    AppLocalizationDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],
                  // Sets the locales that this app has been localized for.
                  supportedLocales: [Locale('en', '')],
                  // Sets the initial route of the app.
                  initialRoute: AppRoutes.homeRoute,
                  // Defines the available named routes and the widgets to build when navigating to those routes.
                  routes: AppRoutes.routes,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
