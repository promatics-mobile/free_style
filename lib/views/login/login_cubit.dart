import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../network_class/dio_network_class.dart';
import '../../network_class/network_response.dart';
import 'login_state.dart';


enum LoginType { email, phone }

class LogInCubit extends Cubit<LogInState>  {
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

  void callSignInAPI() {
    final Map<String, dynamic> param = {
      "type": loginType == LoginType.email ? "email" : "phone",
      //"role": selectedRole.name,
    };

    if (loginType == LoginType.email) {
      param["email"] = emailController.text.trim().toLowerCase();
      param["password"] = passwordController.text.trim();
    } else {
      param["mobile"] = phoneController.text.trim();
    }

   /* DioNetworkClass.fromNetworkClass(
      networkResponse: this,
      endUrl: signInUrl,
      requestCode: signInReq,
      jsonBody: param,
    ).callRequestServiceHeader(true, "post");*/
  }


}
