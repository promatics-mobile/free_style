import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_methods.dart';

class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(false) {
    checkLogin();
  }

  void checkLogin() {
    bool isLogin = sharedPreferences.getBool(PreferenceKeys.isLoginKey) ?? false;
    debugPrint("isLogin $isLogin");
    Future.delayed(const Duration(seconds: 3), () {
      hideKeyboard(navigatorKey.currentContext!);
      emit(isLogin);
    });
  }
}
