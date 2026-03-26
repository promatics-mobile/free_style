import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/routes/route.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/local_notification_service/local_notification_service.dart';
import 'package:free_style/views/dashboard/dashboard_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

var navigatorKey = GlobalKey<NavigatorState>();
var shellNavigatorKey = GlobalKey<NavigatorState>();
LocalNotificationService localNotification = LocalNotificationService();
late SharedPreferences sharedPreferences;


@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint("Notification title BG : ${message.notification?.title.toString()}");
  debugPrint("Notification Body BG : ${message.notification?.body.toString()}");
  debugPrint("Notification Data BG : ${message.data}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  localNotification.init();

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

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => DashboardCubit(0))],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: fontFamily,
          scaffoldBackgroundColor: CommonColors.themeColor,
          canvasColor: CommonColors.themeColor,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(seedColor: CommonColors.themeColor),
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
              child: SafeArea(bottom: true, top: false, child: child ?? const SizedBox()),
            ),
          );
        },
      ),
    ),
  );
}
