import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/routes/route.dart';

import '../../network_class/api_service.dart';
import '../../network_class/web_urls.dart';
import '../../utils/common_methods.dart';

part 'submit_proof_state.dart';

class SubmitProofCubit extends Cubit<SubmitProofState> implements NetworkResponse {
  String id = "";
  String type = "";
  String missionName = "";
  String missionDetails = "";
  String previewVideoPath = "";
  String previewVideoThumbnailPath = "";
  Map<String, dynamic> videoSubmissionDetails = {};


  SubmitProofCubit({required this.id, required this.type}) : super(SubmitProofInitial()) {
    if(type == "skill_tree"){
     callSkillDetailsApi(id);
    }
  }

  void onAddVideoForPreview(String filePath) {
    previewVideoPath = filePath;
    debugPrint("previewVideoPath::$previewVideoPath");

    generateThumbnailFile(filePath).then((thumb) {
      debugPrint("thumb::$thumb");
      if (thumb != null) {
        previewVideoThumbnailPath = thumb.path;
        emit(SubmitProofInitial());
      }
    });
    emit(SubmitProofInitial());
    callUploadVideoApi(File(previewVideoPath));
  }

  void callSkillDetailsApi(String id) {
    DioNetworkCall().callApiRequest(
      endUrl: getSkillDetailsUrl + id,
      method: "GET",
      requestCode: getSkillDetailsReq,
      networkResponse: this,
    );
  }

  void callUploadVideoApi(File filePath) {
    DioNetworkCall().callApiRequest(
      endUrl: uploadVideoUrl,
      method: "POST",
      fileKey: "video",
      file: filePath,
      requestCode: uploadVideoReq,
      networkResponse: this,
      showLoader: true,
    );
  }

  void callSubmitMarkWatchedApi() {
    DioNetworkCall().callApiRequest(
      endUrl: submitSkillUrl,
      method: "POST",
      requestCode: submitSkillReq,
      json: {
        "skill_id": id,
        "file": videoSubmissionDetails,
      },
      networkResponse: this,
      showLoader: true,
    );
  }

  void callSubmitChallengeApi() {
    DioNetworkCall().callApiRequest(
      endUrl: submitDailyChallengeUrl,
      method: "POST",
      requestCode: submitDailyChallengeReq,
      json: {
        "challenge_id": id,
        "file": videoSubmissionDetails,
      },
      networkResponse: this,
      showLoader: true,
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {}

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case submitSkillReq:
        showToast(isError: false, message: "Mark watched successfully");
        router.pop();
        break;

        case submitDailyChallengeReq:
        showToast(isError: false, message: "Challenge submitted successfully");
        router.pop();
        break;

      case uploadVideoReq:
        var data = jsonDecode(response);

        if(data['file'] !=null){
          videoSubmissionDetails = data['file'];
        }

        debugPrint("videoSubmissionDetails::$videoSubmissionDetails");
        emit(SubmitProofInitial());

        break;

      case getSkillDetailsReq:
        var data = jsonDecode(response);
        var list = data['skill'] as List;

        if (list.isNotEmpty) {
          var item = list.first;
          missionName = item['name'];
        }

        emit(SubmitProofInitial());
        break;
    }
  }
}
