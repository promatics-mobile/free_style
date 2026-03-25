import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_style/network_class/api_response.dart';

import '../../main.dart';
import '../../network_class/api_service.dart';
import '../../network_class/web_urls.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_methods.dart';
import '../search_players/search_players_cubit.dart';

part 'other_profile_state.dart';

class OtherProfileCubit extends Cubit<OtherProfileState> implements NetworkResponse {
  final String userId;

  OtherProfileCubit(this.userId) : super(OtherProfileState(user: null)) {
    debugPrint("userId:::: $userId");

    callGetOtherProfileApi();
  }

  String getButtonText() {
    final relation = state.user?.relationStatus;

    if (relation?.isFriend == true) return "Unfollow";
    if (relation?.isRequestSent == true) return "Requested";
    if (relation?.isRequestReceived == true) return "Accept";

    return "Follow";
  }

  void handleButtonTap() {
    final relation = state.user?.relationStatus;
    final userId = state.user?.user?.sId ?? "";
    final relationId = relation?.relationId ?? "";

    if (relation?.isFriend == true) {
      callUnfollowApi(relationId);
    } else {
      callFollowApi(userId);
    }
  }

  void callGetOtherProfileApi() {
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl: "$getOtherPlayerProfileUrl/$userId",
      requestCode: getOtherPlayerProfileReq,
      showLoader: true,
      json: {},
    );
  }

  void callFollowApi(String id) {
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'POST',
      endUrl: "$followUrl?sendTo=$id",
      requestCode: followReq,
      json: {},
    );
  }

  void callUnfollowApi(String id) {
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl: "$unFollowUrl?relation_id=$id",
      requestCode: unFollowReq,
      json: {},
    );
  }

  void callCancelRequestApi(String id) {
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'POST',
      endUrl: "$cancelSentReqUrl?request_id=$id",
      requestCode: cancelSentReqReq,
      json: {},
    );
  }

  void callRoomIdApi() async {
    Map<String, dynamic> map = {
      "sender_id": sharedPreferences.getString(PreferenceKeys.userIdKey),
      "receiver_id": state.user!.user!.sId,
    };

    DioNetworkCall().callApiRequest(
        endUrl: createRoomApiUrl,
        networkResponse: this,
        requestCode: createRoomApiReq,
        method: "POST",
        showLoader: true,
        json: map);
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    emit(state.copyWith());
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case getOtherPlayerProfileReq:
        var map = jsonDecode(response);

        if (map["success"] == true) {
          UserProfileModel userProfile = UserProfileModel.fromJson(map);

          emit(state.copyWith(user: userProfile));
        }

        break;

      case followReq:
        var map = jsonDecode(response);

        if (map["success"] == true) {
          showToast(isError: false, message: "Followed Successfully!");

          callGetOtherProfileApi();

          emit(state.copyWith());
        }

      case unFollowReq:
        var map = jsonDecode(response);

        if (map["success"] == true) {
          showToast(isError: false, message: "UnFollowed Successfully!");

          callGetOtherProfileApi();

          emit(state.copyWith());
        }

        break;

      case cancelSentReqReq:
        var map = jsonDecode(response);

        if (map["success"] == true) {
          showToast(isError: false, message: "UnFollowed Successfully!");

          callGetOtherProfileApi();

          emit(state.copyWith());
        }

        break;


      case createRoomApiReq:
        debugPrint("createRoomApiReq success: $response");
        var data = jsonDecode(response);
        var roomId = data["data"]["room_uuid"].toString();
        debugPrint("roomId:::::$roomId");
        router.push(AppRouter.conversationScreen,extra: {
          "full_name": state.user!.user!.name,
          "profile_image": state.user?.user?.avatar!.picture!.first.fullPath,
          "user_id": state.user!.user!.sId,
          "room_id":roomId});
        break;
    }
  }


}
