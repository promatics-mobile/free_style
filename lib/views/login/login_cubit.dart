import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/network_class/web_urls.dart';

import '../../../main.dart';
import '../../network_class/api_response.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import 'login_state.dart';


enum LoginType { email, phone }

class LogInCubit extends Cubit<LogInState>  implements NetworkResponse{
  LogInCubit() : super(LogInState(agree: false));

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  LoginType loginType = LoginType.email;

  String countryCode = '+91';
  int phoneMaxLength = 10;

  void updateCountryCode(String code) {
    countryCode = code.startsWith('+') ? code : '+$code';
    debugPrint("Code:::::: $countryCode");

    switch (countryCode) {
      case '+91':
        phoneMaxLength = 10;
        break;

      case '+1':
        phoneMaxLength = 10;
        break;

      case '+44':
        phoneMaxLength = 10;
        break;

      case '+971':
        phoneMaxLength = 9;
        break;

      case '+49':
        phoneMaxLength = 11;
        break;

      default:
        phoneMaxLength = 12;
    }
    emit(state.copyWith());
  }

  void changeLoginType(LoginType type) {
    clear();
    loginType = type;
    emit(state.copyWith());
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
  }

  void callLoginApi() {
    final Map<String, dynamic> param = {};

    if (loginType == LoginType.email) {
      param["email"] = emailController.text;
      param["password"] = passwordController.text;
    } else {
      param["mobile"] = {"country_code": countryCode, "number": phoneController.text};
    }

    DioNetworkCall().callApiRequest(
      networkResponse: this,
      endUrl: loginUrl,
      requestCode: loginReq,
      json: param, method: 'POST',
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    switch (requestCode) {
      case loginReq:
        var data = jsonDecode(response);
        break;
    }
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case loginReq:
        var map = jsonDecode(response);

        if(loginType == LoginType.email){
          sharedPreferences.setString(PreferenceKeys.tokenKey, map["token"]);
          sharedPreferences.setString(PreferenceKeys.userIdKey, map['user']["_id"] ?? "");
          sharedPreferences.setString(PreferenceKeys.fullNameKey, map['user']["name"] ?? "");
          sharedPreferences.setString(PreferenceKeys.emailKey, map['user']["email"] ?? "");
          router.go(AppRouter.homeScreen);
        }else{
          router.push(
            AppRouter.otpVerificationScreen,
            extra: {
              "number": loginType == LoginType.phone ? phoneController.text : "",
              "country_code": loginType == LoginType.phone ? countryCode : "",
              "verification_type": "login",
            },
          );
        }

        break;
    }
  }

}
