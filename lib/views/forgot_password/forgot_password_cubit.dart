import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/utils/common_methods.dart';
import '../../network_class/web_urls.dart';
import '../../routes/route.dart';
part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> implements NetworkResponse {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  TextEditingController emailController= TextEditingController();



  void callForgotPasswordApi() {
    DioNetworkCall().callApiRequest(endUrl: forgotPasswordUrl,
        method: "POST",
        requestCode: forgotPasswordReq,
        networkResponse: this,
        json: {"email":emailController.text}
    );
  }


  @override
  void onApiError({required int requestCode, required String response}) {
    switch (requestCode){
      case forgotPasswordReq:
        emit(ForgotPasswordInitial());
        break;
    }

  }

  @override
  void onResponse({required int requestCode, required String response}) {
   switch (requestCode){
     case forgotPasswordReq:
       router.push(
         AppRouter.resetPasswordScreen,
         extra: {
           "email": emailController.text,
           "isReset": true
         },
       );

       showToast(isError: false, message: "Otp sent successfully");

       break;
   }
  }

}