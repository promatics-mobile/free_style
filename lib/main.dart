import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:free_style/routes/route.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

var navigatorKey = GlobalKey<NavigatorState>();
var shellNavigatorKey = GlobalKey<NavigatorState>();
late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    title: appName,
    theme: ThemeData(
        useMaterial3: true,
        fontFamily: fontFamily,
        scaffoldBackgroundColor: CommonColors.themeColor,
        canvasColor: CommonColors.themeColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: CommonColors.themeColor,
          surface: CommonColors.themeColor
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    ),
    routerConfig: router,
    builder: (context, child) {
      return Container(
        color: CommonColors.themeColor,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          child: SafeArea(
            bottom: true,
            top: false,
            child: child ?? const SizedBox(),
          ),
        ),
      );
    },
  ));
}


