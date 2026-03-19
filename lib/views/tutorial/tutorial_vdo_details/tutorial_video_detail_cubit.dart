import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/views/tutorial/tutorial_vdo_details/tutorial_video_detail_state.dart';

import '../../../network_class/api_service.dart';
import '../../../network_class/web_urls.dart';
import '../../../utils/common_methods.dart';
import '../tutorial_cubit.dart';

class TutorialVdoDetailCubit extends Cubit<TutorialVdoDetailState> implements NetworkResponse {
  String tutorialId = "";
  String skillId = "";
  String difficultyLevel = "";
  String submissionStatus = "";
  bool isVidSubReq = false;
  TutorialModel? tutorialModel;

  TutorialVdoDetailCubit({required this.tutorialId, required this.skillId})
    : super(TutorialVdoDetailState()) {
    if (tutorialId.isNotEmpty) {
      callTutorialDetailsApi(tutorialId);
      callSkillDetailsApi(skillId);
    }
  }

  void callTutorialDetailsApi(String id) {
    DioNetworkCall().callApiRequest(
      endUrl: getTutorialDetailsUrl + id,
      method: "GET",
      requestCode: getTutorialDetailsReq,
      networkResponse: this,
      showLoader: true,
    );
  }

  void callSkillDetailsApi(String id) {
    DioNetworkCall().callApiRequest(
      endUrl: getSkillDetailsUrl + id,
      method: "GET",
      requestCode: getSkillDetailsReq,
      networkResponse: this,
    );
  }

  void callUploadVideoApi() {
    DioNetworkCall().callApiRequest(
      endUrl: uploadVideoUrl,
      method: "POST",
      fileKey: "video",
      requestCode: getTutorialDetailsReq,
      networkResponse: this,
      showLoader: true,
    );
  }

  void callSubmitMarkWatchedApi() {
    DioNetworkCall().callApiRequest(
      endUrl: submitSkillUrl,
      method: "POST",
      requestCode: submitSkillReq,
      json: {"skill_id": skillId},
      networkResponse: this,
      showLoader: true,
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {}

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case getTutorialDetailsReq:
        var data = jsonDecode(response);
        if (data['tutorial'] != null) {
          tutorialModel = TutorialModel.fromJson(data['tutorial']);
        }
        emit(TutorialVdoDetailState());
        break;

      case submitSkillReq:
        showToast(isError: false, message: "Mark watched successfully");
        emit(TutorialVdoDetailState());
        callSkillDetailsApi(skillId);
        break;

      case getSkillDetailsReq:
        var data = jsonDecode(response);
        var list = data['skill'] as List;

        if (list.isNotEmpty) {
          var item = list.first;
          difficultyLevel = item['difficulty_level'];
          isVidSubReq = item['is_vid_sub_req']??false;
          submissionStatus = item['skill_status'] ?? "not_submitted";
        }

        debugPrint("DL::$difficultyLevel,VIDEO_REQ::$isVidSubReq,SS::$submissionStatus");
        emit(TutorialVdoDetailState());
        break;
    }
  }
}
