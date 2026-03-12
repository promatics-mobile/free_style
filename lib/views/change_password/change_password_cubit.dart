import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/utils/common_methods.dart';

import '../../network_class/api_service.dart';
import '../../network_class/web_urls.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> implements NetworkResponse {
  bool currentPass = false;
  bool newPass = true;
  bool confirmPass = true;
  var currentController = TextEditingController();
  var newController = TextEditingController();
  var confirmController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  ChangePasswordCubit() : super(ChangePasswordState());

  void currentPassFn() {
    currentPass = !currentPass;
    emit(state.copyWith());
  }

  void newPassFn() {
    newPass = !newPass;
    emit(state.copyWith());
  }

  void confirmPassFn() {
    confirmPass = !confirmPass;
    emit(state.copyWith());
  }

  void callChangePasswordApi() {
    DioNetworkCall().callApiRequest(
      endUrl: changePasswordUrl,
      method: "POST",
      requestCode: changePasswordReq,
      networkResponse: this,
      showLoader: true,
      json: {"current_password": currentController.text, "new_password": newController.text},
    );
  }

  @override
  void onApiError({Key? key, required int requestCode, required String response}) {
    switch (requestCode) {
      case changePasswordReq:
        var data = jsonDecode(response);
        break;
    }
  }

  @override
  void onResponse({Key? key, required int requestCode, required String response}) {
    switch (requestCode) {
      case changePasswordReq:
        var data = jsonDecode(response) as Map;
        currentController.clear();
        newController.clear();
        confirmController.clear();
        formKey.currentState!.reset();
        showToast(isError: false, message: "Password changed successfully");

        emit(ChangePasswordState());
        break;
    }
  }
}

class ChangePasswordState {
  String? title;

  ChangePasswordState({this.title});

  ChangePasswordState copyWith({String? title}) {
    return ChangePasswordState(title: title ?? this.title);
  }
}
