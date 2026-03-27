import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_style/views/profile_setup/cosmetics_model.dart';

import '../../main.dart';
import '../../network_class/api_response.dart';
import '../../network_class/api_service.dart';
import '../../network_class/web_urls.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_methods.dart';
import '../search_players/search_players_cubit.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> implements NetworkResponse {
  int offset = 0;
  int limit = 10;
  String referenceId = "";
  PlayerModel? selectedFriend;

  bool showShimmer = false;
  bool isLoadMore = false;
  bool isLoading = false;
  bool isLastPage = false;

  SocialCubit() : super(SocialState(myFriends: [], pendingRequests: [], battleRequests: [])) {
    callFriendListApi(isShowLoader: true);
  }

  void acceptChallenge(int index) {
    state.battleRequests.removeAt(index);
    emit(state.copyWith());
  }

  void cancelChallenge(int index) {
    state.battleRequests.removeAt(index);
    emit(state.copyWith());
  }

  void callCancelRequestApi(String id) {
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl: "$cancelReceivedReqUrl?request_id=$id",
      requestCode: cancelReceivedReqReq,
      json: {},
    );
  }

  void callAcceptReqApi(String id) {
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl: "$acceptRequestUrl?request_id=$id",
      requestCode: acceptRequestReq,
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

  void callFriendListApi({bool isRefresh = false, bool isShowLoader = false}) {
    showShimmer = isShowLoader;
    if (isRefresh) {
      offset = 0;
      isLastPage = false;
      state.myFriends.clear();
      isLoading = isShowLoader;
    } else {
      if (isLastPage || isLoadMore || isLoading) return;
      isLoadMore = true;
    }

    emit(state.copyWith());
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl: getFriendListUrl,
      requestCode: getFriendListReq,
      json: {},
    );
  }

  void callAcceptBattleReqApi(String id, String refId) {
    referenceId = refId;
    emit(state.copyWith());

    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'PATCH',
      showLoader: true,
      endUrl: "$acceptBattleRequestUrl$id",
      requestCode: acceptBattleRequestReq,
      json: {},
    );
  }

  void callCancelBattleReqApi(String id) {
    DioNetworkCall().callApiRequest(
      endUrl: cancelBattleInviteUrl + id,
      method: "DELETE",
      requestCode: cancelBattleInviteReq,
      networkResponse: this,
      showLoader: true,
    );
  }

  void callRoomIdApi(PlayerModel friend) async {
    selectedFriend = friend;
    emit(state.copyWith());

    Map<String, dynamic> map = {
      "sender_id": sharedPreferences.getString(PreferenceKeys.userIdKey),
      "receiver_id": friend.sId,
    };

    DioNetworkCall().callApiRequest(
      endUrl: createRoomApiUrl,
      networkResponse: this,
      requestCode: createRoomApiReq,
      method: "POST",
      showLoader: true,
      json: map,
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    isLoading = false;
    isLoadMore = false;
    emit(state.copyWith());
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    isLoading = false;
    isLoadMore = false;
    showShimmer = false;
    switch (requestCode) {
      case getFriendListReq:
        //log(response);
        var map = jsonDecode(response);

        if (map["success"] == true) {
          final data = map["data"] ?? {};

          final currentUserId = sharedPreferences.getString(PreferenceKeys.userIdKey) ?? "";

          final List<PlayerModel> friends = (data["friends"] as List? ?? [])
              .map((e) => PlayerModel.fromJson(e["friend"], rId: e["_id"]))
              .where((user) => user.sId != currentUserId)
              .toList();

          final List<PendingRequestModel> pendingRequests =
              (data["pending_requests"] as List? ?? [])
                  .map((e) => PendingRequestModel.fromJson(e))
                  .toList();

          final List<BattleRequestModel> battleRequestList =
              (data["incoming_challenges"] as List? ?? [])
                  .map((e) => BattleRequestModel.fromJson(e))
                  .toList();

          emit(
            state.copyWith(
              myFriends: friends,
              battleRequests: battleRequestList,
              pendingRequests: pendingRequests,
            ),
          );
        }

        break;

      case acceptRequestReq:
        var map = jsonDecode(response);

        if (map["success"] == true) {
          showToast(isError: false, message: "Friend request accepted");

          callFriendListApi();

          emit(state.copyWith());
        }

        break;

      case cancelReceivedReqReq:
        var map = jsonDecode(response);

        if (map["success"] == true) {
          showToast(isError: true, message: "Friend request rejected");

          callFriendListApi();

          emit(state.copyWith());
        }

        break;

      case unFollowReq:
        var map = jsonDecode(response);

        if (map["success"] == true) {
          showToast(isError: true, message: "Removed from friends");

          callFriendListApi();

          emit(state.copyWith());
        }

        break;

      case acceptBattleRequestReq:
        var map = jsonDecode(response);

        if (map["success"] == true) {
          emit(state.copyWith());
          router.push(AppRouter.matchMakingScreen, extra: {"reference_id": referenceId});

          showToast(isError: false, message: "Battle request accepted successfully.");
        }

        break;

      case cancelBattleInviteReq:
        var map = jsonDecode(response);

        if (map["success"] == true) {
          showToast(isError: true, message: "Battle request cancelled successfully.");
          emit(state.copyWith());
        }

        callFriendListApi(isShowLoader: true);

        break;

      case createRoomApiReq:
        debugPrint("createRoomApiReq success: $response");
        var data = jsonDecode(response);
        var roomId = data["data"]["room_uuid"].toString();
        debugPrint("roomId:::::$roomId");

        if (selectedFriend != null) {
          router.push(
            AppRouter.conversationScreen,
            extra: {
              "full_name": selectedFriend!.name,
              "profile_image": selectedFriend!.avatar!.picture!.first.fullPath,
              "user_id": selectedFriend!.sId,
              "room_id": roomId,
            },
          );
        }

        break;
    }
  }
}
