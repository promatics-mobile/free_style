import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:free_style/routes/route.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

var navigatorKey = GlobalKey<NavigatorState>();
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
        colorScheme: ColorScheme.fromSeed(
            seedColor: CommonColors.themeColor)),
    routerConfig: router,
    builder: (context, child) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
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
      );
    },
  ));
}


