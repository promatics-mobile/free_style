import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_style/main.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:meta/meta.dart';

import '../../network_class/api_service.dart';
import '../../routes/route.dart';
import '../../utils/common_methods.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> implements NetworkResponse{

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  ContactUsCubit() : super(ContactUsInitial()){
    nameController.text = sharedPreferences.getString(PreferenceKeys.fullNameKey)??"";
    emailController.text = sharedPreferences.getString(PreferenceKeys.emailKey)??"";
  }



  void callContactUsApi() {
    DioNetworkCall().callApiRequest(
      endUrl: contactUsUrl,
      method: "POST",
      requestCode: contactUsReq,
      networkResponse: this,
      showLoader: true,
      json: {
        "name": nameController.text,
        "email": emailController.text,
        "description": messageController.text},
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    switch (requestCode) {
      case contactUsReq:
        var data = jsonDecode(response);
        break;
    }
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case contactUsReq:
        var data = jsonDecode(response) as Map;
        router.pop();
        showToast(isError: false, message: "Request submitted successfully");
        break;
    }
  }
}
