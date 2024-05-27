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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    PrefUtils().init()
  ]).then((value) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeProvider()),
          ChangeNotifierProvider(create: (context) => ArticleProvider()),
          ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor:
              Colors.blue // This sets the primary color to a specific color.
          ),
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
                  scrollBehavior:
                      NoThumbScrollBehavior().copyWith(scrollbars: false),
                  navigatorKey: NavigatorService.navigatorKey,
                  localizationsDelegates: [
                    AppLocalizationDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],
                  supportedLocales: [Locale('en', '')],
                  initialRoute: AppRoutes.homeRoute,
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
