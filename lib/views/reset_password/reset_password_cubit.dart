import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/views/reset_password/reset_password_state.dart';

import '../../../main.dart';
import '../../utils/common_constants.dart';


class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordState(agree: false));

  var formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();



  void callResetPasswordAPI() {
    var param = {
      "new_password": newPasswordController.text.trim(),
      "confirm_password": confirmPasswordController.text.trim(),
      "token": sharedPreferences.getString(PreferenceKeys.tokenKey),
    };

 /*   DioNetworkClass.fromNetworkClass(
      networkResponse: this,
      endUrl: resetPasswordUrl,
      requestCode: resetPasswordReq,
      jsonBody: param,
    ).callRequestServiceHeader(true, "post");*/
  }
/*
  @override
  void onApiError({required int requestCode, required String response}) {
    try {
      switch (requestCode) {
        case resetPasswordReq:
          final map = jsonDecode(response) as Map<String, dynamic>;
          CommonToast.show(
            map.getFormattedMessage(),
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
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

          if (map["success"] == true) {
            CommonToast.show(
              map["message"] ?? "Password reset successfully",
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );

            router.go(AppRouter.signInScreen);
          }

          break;
      }
    } on Exception catch (e, st) {
      debugPrint("Exception: $st");
    }
  }*/
}
