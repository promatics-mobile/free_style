import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/generated/assets.dart';
import 'package:free_style/views/splash/splash_cubit.dart';

import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_methods.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SplashCubit(),
        child: BlocListener<SplashCubit, bool>(
          listener: (context, isLogin) {
            debugPrint("isLogin::$isLogin");
            hideKeyboard(context);

            if (isLogin) {
              router.go(AppRouter.homeScreen);
            } else {
              router.go(AppRouter.walkThroughScreen);
            }
          },
          child: Container(
            color: CommonColors.themeColor,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(size(context).width * numD1),
              child: Image.asset(
                Assets.iconsAppLogo,
                height: size(context).width / 2,
                width: size(context).width / 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
