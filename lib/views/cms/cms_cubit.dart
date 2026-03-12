import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/network_class/api_response.dart';

import '../../network_class/api_service.dart';
import '../../network_class/web_urls.dart';
import 'cms_state.dart';

class CmsCubit extends Cubit<CmsState> implements NetworkResponse {
  String cmsData = "";

  CmsCubit(String type) : super(CmsState()) {
    callCmsApi(type.replaceAll(" & ", "_").replaceAll(" ", "_").toLowerCase());
  }

  void callCmsApi(String type) {
    DioNetworkCall().callApiRequest(
      endUrl: cmsApiUrl,
      method: "GET",
      requestCode: cmsApiReq,
      networkResponse: this,
      showLoader: true,
      query: {"type": type},
    );
  }

  @override
  void onApiError({Key? key, required int requestCode, required String response}) {
    switch (requestCode) {
      case cmsApiReq:
        var data = jsonDecode(response);
        break;
    }
  }

  @override
  void onResponse({Key? key, required int requestCode, required String response}) {
    switch (requestCode) {
      case cmsApiReq:
        var data = jsonDecode(response) as Map;
        if (data['policy'] != null) {
          cmsData = data['policy']['description'];
        }
        emit(CmsState());
        break;
    }
  }
}
