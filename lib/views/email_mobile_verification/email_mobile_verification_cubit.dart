import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/main.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/views/dashboard/dashboard_cubit.dart';
import 'package:meta/meta.dart';

import '../../network_class/web_urls.dart';
import '../../routes/route.dart';

part 'email_mobile_verification_state.dart';

class EmailMobileVerificationCubit extends Cubit<EmailMobileVerificationState>
    implements NetworkResponse {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String countryCode = '+91';
  int phoneMaxLength = 10;
  String currentType = "";

  EmailMobileVerificationCubit() : super(EmailMobileVerificationInitial()) {
    emailController.text = sharedPreferences.getString(PreferenceKeys.emailKey) ?? "";
    phoneController.text = sharedPreferences.getString(PreferenceKeys.mobileKey) ?? "";
    countryCode = sharedPreferences.getString(PreferenceKeys.countryCodeKey) ?? "";
  }

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
    emit(EmailMobileVerificationInitial());
  }

  void selectVerificationType(String type) {
    currentType = type;
    emit(EmailMobileVerificationInitial());
  }


  void callEmailVerifyApi(String type) {
    selectVerificationType(type);

    Map<String, dynamic> map = {};

    if (type == "email") {
      map["email"] = emailController.text;
    } else {
      map["mobile"] = {
        "country_code": countryCode,
        "number": phoneController.text
      };
    }

    DioNetworkCall().callApiRequest(
        endUrl: emailMobileVerifyUrl,
        method: "PATCH",
        requestCode: emailMobileVerifyReq,
        showLoader: true,
        json: map,
        networkResponse: this);
  }


  @override
  void onApiError({required int requestCode, required String response}) {
    switch (requestCode) {
      case emailMobileVerifyReq:
        break;
    }
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case emailMobileVerifyReq:
        if (currentType == "email") {

          router.push(
            AppRouter.otpVerificationScreen,
            extra: {
              "email": emailController.text,
              "verification_type": "email_mobile_verify",
            },
          ).then((value){
            navigatorKey.currentContext!.read<DashboardCubit>().callGetProfileApi();
            emailController.text = sharedPreferences.getString(PreferenceKeys.emailKey) ?? "";
          });

        } else {
          router.push(
            AppRouter.otpVerificationScreen,
            extra: {
              "number": phoneController.text,
              "country_code": countryCode,
              "verification_type": "email_mobile_verify",
            },
          ).then((value){
            emailController.text = sharedPreferences.getString(PreferenceKeys.emailKey) ?? "";
            phoneController.text = sharedPreferences.getString(PreferenceKeys.mobileKey) ?? "";
            countryCode = sharedPreferences.getString(PreferenceKeys.countryCodeKey) ?? "";
            navigatorKey.currentContext!.read<DashboardCubit>().callGetProfileApi();
          });
        }



        break;
    }
  }


}
