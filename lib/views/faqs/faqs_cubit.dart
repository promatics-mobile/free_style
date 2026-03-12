import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:free_style/views/faqs/faq_model.dart';

part 'faqs_state.dart';

class FaqsCubit extends Cubit<FaqState> implements NetworkResponse {
  FaqsCubit() : super(FaqInitial()){
    callGetFaqsApi();
  }

  List<Faqs> faqList = [];

  void callGetFaqsApi() {
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      endUrl: getFaqsUrl,
      requestCode: getFaqsReq,
      showLoader: true,
      method: 'GET',
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    // Handle error if needed
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case getFaqsReq:
        var map = jsonDecode(response);
        FaqModel model = FaqModel.fromJson(map);
        if (model.success == true) {
          faqList = model.faqs ?? [];
          emit(FaqInitial());
        }
        break;
    }
  }
}
