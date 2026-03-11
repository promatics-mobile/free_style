import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:free_style/utils/common_methods.dart';

import '../../../main.dart';
import '../../network_class/api_service.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> implements NetworkResponse {
  final String email;
  final String phone;
  final String countryCode;
  final String verificationType;

  OtpVerificationCubit({
    required this.email,
    required this.phone,
    required this.countryCode,
    required this.verificationType,
  }) : super(OtpVerificationState(remainingTime: 0, timer: null, btnLoader: false, agree: false));

  var formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  bool onComplete = false;
  String _otpCode = "";

  void toggleAgree() {
    emit(state.copyWith(agree: !state.agree));
  }

  void onCompleteOtpFunc() {
    if (onComplete) {
      _otpCode = otpController.text;
    }
  }

  void startTimer() {
    emit(state.copyWith(remainingTime: 119));
    state.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isClosed) {
        timer.cancel();
        return;
      }
      if (state.remainingTime > 0) {
        emit(state.copyWith(remainingTime: state.remainingTime - 1));
        debugPrint("remainingTime::::${state.remainingTime}");
      } else {
        timer.cancel();
        emit(state.copyWith(isButtonEnabled: true));
      }
    });
  }

  void callVerifyEmailPhoneOtpAPI() {
    Map<String, dynamic> param = {"otp": otpController.text.trim()};
    if (email.isNotEmpty) {
      param['email'] = email;
    }
    if (phone.isNotEmpty) {
      param['mobile'] = {"country_code": countryCode, "number": phone};
    }

    DioNetworkCall().callApiRequest(
      networkResponse: this,
      endUrl: verifyOtpUrl,
      requestCode: verifyOtpReq,
      json: param,
      showLoader: true,
      method: 'POST',
    );
  }

  void callForgotPasswordOtpVerifyAPI() {
    final param = {"email": email, "otp": otpController.text.trim()};

    DioNetworkCall().callApiRequest(
      networkResponse: this,
      endUrl: verifyOtpUrl,
      requestCode: verifyOtpReq,
      json: param,
      method: 'POST',
    );
  }

  void callResendOtpApi() {
    otpController.clear();

    Map<String, dynamic> param = {};
    if (email.isNotEmpty) {
      param['email'] = email;
    }
    if (phone.isNotEmpty) {
      param['mobile'] = {"country_code": countryCode, "number": phone};
    }

    DioNetworkCall().callApiRequest(
      networkResponse: this,
      endUrl: resendOtpUrl,
      requestCode: resendOtpReq,
      json: param,
      showLoader: true,
      method: 'POST',
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    try {
      switch (requestCode) {
        case verifyOtpReq:
          final map = jsonDecode(response);
          break;

          case resendOtpReq:
          final map = jsonDecode(response);
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
        case verifyOtpReq:
          final map = jsonDecode(response);

          sharedPreferences.setString(PreferenceKeys.tokenKey, map["token"]);
          sharedPreferences.setString(PreferenceKeys.userIdKey, map["_id"] ?? "");
          sharedPreferences.setString(PreferenceKeys.fullNameKey, map["full_name"] ?? "");
          sharedPreferences.setString(PreferenceKeys.emailKey, map["email"] ?? "");

          router.go(AppRouter.homeScreen);

          break;


        case resendOtpReq:
          final map = jsonDecode(response);
          showToast(isError: false, message: "OTP resend successfully");
          break;
      }
    } on Exception catch (e, st) {
      debugPrint("Exception: $st");
    }
  }
}
