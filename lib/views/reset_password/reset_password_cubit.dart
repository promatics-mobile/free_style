import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/views/reset_password/reset_password_state.dart';

import '../../../main.dart';
import '../../network_class/web_urls.dart';
import '../../routes/route.dart';
import '../../utils/common_methods.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> implements NetworkResponse {
  String email;

  ResetPasswordCubit({required this.email})
    : super(ResetPasswordState(agree: false));

  var formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void callResetPasswordAPI() {
    var param = {"new_password": newPasswordController.text.trim(), "otp": otpController.text, "email": email};

    DioNetworkCall().callApiRequest(
      networkResponse: this,
      endUrl: resetPasswordUrl,
      requestCode: resetPasswordReq,
      json: param,
      method: "POST",
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    try {
      switch (requestCode) {
        case resetPasswordReq:
          final map = jsonDecode(response) as Map<String, dynamic>;
          break;
      }
    } on Exception catch (e, st) {
      debugPrint("Exception: $st");
    }
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    try {
      switch (requestCode) {
        case resetPasswordReq:
          var map = jsonDecode(response);
          Navigator.popUntil(
            navigatorKey.currentContext!,
            (route) => route.settings.name == AppRouter.logInScreen,
          );
          showToast(
            isError: false,
            message: "Password updated successfully, Please login to continue.",
          );
          break;
      }
    } on Exception catch (e, st) {
      debugPrint("Exception: $st");
    }
  }
}
