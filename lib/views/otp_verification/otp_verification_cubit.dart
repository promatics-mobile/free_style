import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';

import 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final String email;
  final String phone;
  final String countryCode;
  final bool isFromSignIn;
  final bool isFromForgotPassword;

  OtpVerificationCubit({
    required this.email,
    required this.phone,
    required this.countryCode,
    this.isFromSignIn = false,
    this.isFromForgotPassword = false,
  }) : super(OtpVerificationState(remainingTime: 0, timer: null,btnLoader: false,agree: false));

  var formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  bool onComplete = false;
  String _otpCode = "";

  void toggleAgree() {
    emit(state.copyWith(agree: !state.agree));
  }

  void onCompleteOtpFunc(){
    if (onComplete) {
      _otpCode = otpController.text;

    }
  }

  void startTimer() {
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
    final param = {
      "email": email,
      "otp": otpController.text.trim(),
      "mobile": {"number": phone},
    };

    /*DioNetworkClass.fromNetworkClass(
      networkResponse: this,
      endUrl: verifyEmailPhoneOTPUrl,
      requestCode: verifyEmailPhoneOTPReq,
      jsonBody: param,
    ).callRequestServiceHeader(true, "post");*/
  }

  void callVerifyPhoneOtpAPI() {
    final param = {
      "mobile": phone,
      "otp": otpController.text.trim(),
    };

    /*DioNetworkClass.fromNetworkClass(
      networkResponse: this,
      endUrl: verifyPhoneOTPUrl,
      requestCode: verifyPhoneOTPReq,
      jsonBody: param,
    ).callRequestServiceHeader(true, "post");*/
  }


  void callForgotPasswordOtpVerifyAPI() {
    final param = {
      "email": email,
      "otp": otpController.text.trim(),
    };

   /* DioNetworkClass.fromNetworkClass(
      networkResponse: this,
      endUrl: forgotPasswordVerifyOtpUrl,
      requestCode: forgotPasswordVerifyOtpReq,
      jsonBody: param,
    ).callRequestServiceHeader(true, "post");*/
  }

  void callResendEmailOtpAPI() {
    otpController.clear();

    final param = {"email": email};

    /*DioNetworkClass.fromNetworkClass(
      networkResponse: this,
      endUrl: resendMailOtpUrl,
      requestCode: resendMailOtpReq,
      jsonBody: param,
    ).callRequestServiceHeader(true, "post");*/
  }

/*  @override
  void onApiError({required int requestCode, required String response}) {
    try {
      switch (requestCode) {
        case verifyEmailPhoneOTPReq:
          final map = jsonDecode(response) as Map<String, dynamic>;
          CommonToast.show(
            map.getFormattedMessage(),
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          break;
          case resendMailOtpReq:
          final map = jsonDecode(response) as Map<String, dynamic>;
          CommonToast.show(
            map.getFormattedMessage(),
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          break;

          case verifyPhoneOTPReq:
          final map = jsonDecode(response) as Map<String, dynamic>;
          CommonToast.show(
            map.getFormattedMessage(),
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          break;
          case forgotPasswordVerifyOtpReq:
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
        case verifyEmailPhoneOTPReq:
          final map = jsonDecode(response);

          sharedPreferences.setString(PreferenceKeys.tokenKey, map["data"]["token"]??"");
          final data = map["data"];
          if (data == null) return;

          final userMap = data["user"];
          if (userMap == null) return;

          // Basic user data
          sharedPreferences.setString(
            PreferenceKeys.userIdKey,
            userMap["_id"] ?? "",
          );
          sharedPreferences.setString(
            PreferenceKeys.firstNameKey,
            userMap["first_name"] ?? "",
          );
          sharedPreferences.setString(
            PreferenceKeys.lastNameKey,
            userMap["last_name"] ?? "",
          );
          sharedPreferences.setString(
            PreferenceKeys.emailKey,
            userMap["email"] ?? "",
          );
          debugPrint("The token is ::::${map["data"]["token"]}");
          CommonToast.show(
            map["message"] ?? "Verified successfully",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          switch (selectedRole) {
            case Role.customer:
              router.go(AppRouter.homeScreen);
              break;
            case Role.company:
              router.push(AppRouter.companyCompleteProfileScreen,extra:  {"type": selectedRole.name},);
              // router.go(AppRouter.companyHomeScreen);
              break;
            case Role.delivery_partner:
              router.push(AppRouter.companyCompleteProfileScreen,extra:  {"type": selectedRole.name},);
              break;
          }

          // router.push(AppRouter.companyCompleteProfileScreen,extra:  {"type": selectedRole.name},);
          break;

          case resendMailOtpReq:
          final map = jsonDecode(response);

          CommonToast.show(
            map["message"] ,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          break;

          case verifyPhoneOTPReq:
          final map = jsonDecode(response);
          var data = map['data'];

          // Save token
          sharedPreferences.setString(
            PreferenceKeys.tokenKey,
            data["token"] ?? "",
          );

          final userMap = data["user"];
          if (userMap == null) return;

          // Basic user data
          sharedPreferences.setString(
            PreferenceKeys.userIdKey,
            userMap["_id"] ?? "",
          );
          sharedPreferences.setString(
            PreferenceKeys.firstNameKey,
            userMap["first_name"] ?? "",
          );
          sharedPreferences.setString(
            PreferenceKeys.lastNameKey,
            userMap["last_name"] ?? "",
          );
          sharedPreferences.setString(
            PreferenceKeys.emailKey,
            userMap["email"] ?? "",
          );

          if (userMap["mobile"] != null) {
            final mobile = userMap["mobile"];
            sharedPreferences.setString(
              PreferenceKeys.mobileKey,
              "${mobile["country_code"] ?? ""}${mobile["number"] ?? ""}",
            );
          }

          sharedPreferences.setString(
            PreferenceKeys.approvalStatusKey,
            userMap["approval_status"] ?? "",
          );
          sharedPreferences.setBool(
            PreferenceKeys.isActiveKey,
            userMap["is_active"] ?? false,
          );

          // Onboarding data
          final onboarding = userMap["onboarding"];
          final bool isOnboardingCompleted =
              onboarding?["is_completed"] ?? false;
          final int currentStep = onboarding?["current_step"] ?? 0;

          sharedPreferences.setBool(
            PreferenceKeys.isOnBoardingCompleteKey,
            isOnboardingCompleted,
          );
          sharedPreferences.setString(
            PreferenceKeys.onboardingStepKey,
            currentStep.toString(),
          );


          if(selectedRole!=Role.customer){
            if (!isOnboardingCompleted) {
              CommonToast.show(
                "Onboarding is not completed. Please complete your onboarding first.",
              );
              router.go(
                AppRouter.companyCompleteProfileScreen,
                extra: {"type": selectedRole.name},
              );
              return;
            }

          }
          debugPrint("We are here ::::1");

          if (sharedPreferences.getString(PreferenceKeys.approvalStatusKey) ==
              "approved") {

            switch (selectedRole) {
              case Role.customer:
                router.go(AppRouter.homeScreen);
                break;
              case Role.company:
                router.go(AppRouter.companyHomeScreen);
                break;
              case Role.delivery_partner:
                router.go(AppRouter.deliveryHomeScreen);
                break;
            }
          } else if(sharedPreferences.getString(PreferenceKeys.approvalStatusKey) ==
              "rejected"){

            CommonToast.show(
              "Your request was rejected by the admin",
            );

            // router.go(AppRouter.profileSuccessScreen,
            //   extra: {"approval": sharedPreferences.getString(PreferenceKeys.approvalStatusKey)});
          }else{
            CommonToast.show(
              "Your request is pending. Please wait for approval.",
            );

          }


          break;

        case forgotPasswordVerifyOtpReq:
          final map = jsonDecode(response);

          if (map["success"] == true) {

            final resetToken = map["data"]?["reset_token"] ?? "";

            sharedPreferences.setString(
              PreferenceKeys.tokenKey,
              resetToken,
            );

            CommonToast.show(
              map["message"] ?? "OTP verified successfully",
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );

            router.push(
              AppRouter.resetPasswordScreen,
            );
          }

          break;

      }
    } on Exception catch (e, st) {
      debugPrint("Exception: $st");
    }
  }*/
}
