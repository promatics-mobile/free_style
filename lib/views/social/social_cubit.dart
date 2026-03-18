import 'dart:convert';

import 'package:bloc/bloc.dart';

import '../../main.dart';
import '../../network_class/api_response.dart';
import '../../network_class/api_service.dart';
import '../../network_class/web_urls.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_methods.dart';
import '../search_players/search_players_cubit.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> implements NetworkResponse {
  int offset = 0;
  int limit = 10;

  bool isLoadMore = false;
  bool isLoading = false;
  bool isLastPage = false;

  SocialCubit() : super(SocialState(myFriends: [], pendingRequests: [])) {
    callFriendListApi(isShowLoader: true);
  }

  List<SocialModel> incomingChallenges = [
    SocialModel(name: "@Kim_skater", level: "Blue Tier 1", message: "Wants to battle!"),
  ];

  List<SocialModel> pendingRequests = [
    SocialModel(name: "@NeonNinja", level: "SILVER 1", message: ""),
    SocialModel(name: "@Cryptoking", level: "GOLD 2", message: ""),
  ];

  List<SocialModel> myFriends = [
    SocialModel(name: "@QueenBee", level: "GOLD 1", message: ""),
    SocialModel(name: "@ViperStrike", level: "BRONZE 3", message: ""),
    SocialModel(name: "@ShadowStriker", level: "PLATINUM 1", message: ""),
    SocialModel(name: "@TrickMaster", level: "GOLD 1", message: ""),
    SocialModel(name: "@SkatyCat", level: "SILVER 2", message: ""),
  ];

  void acceptChallenge(int index) {
    incomingChallenges.removeAt(index);
    emit(state.copyWith());
  }

  void cancelChallenge(int index) {
    incomingChallenges.removeAt(index);
    emit(state.copyWith());
  }

  void acceptRequest(int index) {
    var user = pendingRequests.removeAt(index);
    myFriends.add(user);
    emit(state.copyWith());
  }

  void rejectRequest(int index) {
    pendingRequests.removeAt(index);
    emit(state.copyWith());
  }

  void removeFriend(int index) {
    myFriends.removeAt(index);
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
    if (isRefresh) {
      offset = 0;
      isLastPage = false;
      state.myFriends.clear();
      isLoading = true;
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
      showLoader: isShowLoader,
      json: {},
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
    switch (requestCode) {
      case getFriendListReq:
        var map = jsonDecode(response);

        if (map["success"] == true) {
          final data = map["data"] ?? {};

          final currentUserId = sharedPreferences.getString(PreferenceKeys.userIdKey) ?? "";

          final List<PlayerModel> friends = (data["friends"] as List? ?? [])
              .map((e) => PlayerModel.fromJson(e["friend"]))
              .where((user) => user.sId != currentUserId)
              .toList();

          final List<PendingRequestModel> pendingRequests =
              (data["pending_requests"] as List? ?? [])
                  .map((e) => PendingRequestModel.fromJson(e))
                  .toList();

          /// ✅ Sent Requests (optional if you want later)
          final List<PlayerModel> sentRequests = (data["sent_requests"] as List? ?? [])
              .map((e) => PlayerModel.fromJson(e["recipient"]))
              .toList();

          emit(state.copyWith(myFriends: friends, pendingRequests: pendingRequests));
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
    }
  }
}

class SocialModel {
  final String name;
  final String level;
  final String message;

  SocialModel({required this.name, required this.level, required this.message});
}
