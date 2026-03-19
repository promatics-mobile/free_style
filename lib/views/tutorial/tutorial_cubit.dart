import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:meta/meta.dart';

part 'tutorial_state.dart';

class TutorialCubit extends Cubit<TutorialState> implements NetworkResponse {
  String skillId = "";
  List<TutorialModel> tutorialsList = [];

  TutorialCubit({required this.skillId}) : super(TutorialInitial()) {
    if (skillId.isNotEmpty) {
      callTutorialListApi(skillId);
    }
  }

  void callTutorialListApi(String id) {
    DioNetworkCall().callApiRequest(
      endUrl: getTutorialsListUrl + id,
      method: "GET",
      requestCode: getTutorialsListReq,
      networkResponse: this,
      showLoader: true
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {}

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case getTutorialsListReq:
        var data = jsonDecode(response);
        if (data['tutorials'] != null) {
          var list = data['tutorials']['tutorials'] as List;
          tutorialsList = list.map((e) => TutorialModel.fromJson(e)).toList();
        }
        emit(TutorialInitial());
        break;
    }
  }
}
