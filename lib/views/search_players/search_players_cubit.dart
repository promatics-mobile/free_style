import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/views/global_lead_board/global_lead_board_cubit.dart';
import 'package:free_style/views/home/home_cubit.dart';

import '../../main.dart';
import '../../network_class/api_service.dart';
import '../../network_class/web_urls.dart';
import '../../utils/common_constants.dart';
import '../other_profile/other_profile_cubit.dart';
import '../profile_setup/cosmetics_model.dart';

part 'search_players_state.dart';

class SearchPlayersCubit extends Cubit<SearchPlayersState> implements NetworkResponse {
  TextEditingController searchPlayerController = TextEditingController();
  int offset = 0;
  int limit = 10;

  bool isLoadMore = false;
  bool isLoading = false;
  bool isLastPage = false;

  SearchPlayersCubit() : super(SearchPlayersState(userList: [])) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callPlayerListApi(isRefresh: true, isShowLoader: true);
    });
  }

  String getButtonText(PlayerModel user) {
    final relation = user.relationStatus;

    if (relation?.isFriend == true) return "Friends";
    if (relation?.isRequestSent == true) return "Requested";
    if (relation?.isRequestReceived == true) return "Accept";

    return "Follow";
  }

  void handleButtonTap(PlayerModel user) {
    final relation = user.relationStatus;

    if (relation?.isFriend == true) {
     callUnfollowApi(relation?.relationId ?? "");

    }else {
      callFollowApi(user.sId ?? "");
    }
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
      method: 'POST',
      endUrl: "$unFollowUrl?relation_id=$id",
      requestCode: unFollowReq,
      json: {},
    );
  }

  void callPlayerListApi({bool isRefresh = false, bool isShowLoader = false}) {
    debugPrint("Here:::$isLastPage $isLoadMore $isLoading");
    if (isRefresh) {
      offset = 0;
      isLastPage = false;
      state.userList.clear();
      isLoading = true;
    } else {
      if (isLastPage || isLoadMore || isLoading) return;
      isLoadMore = true;
    }

    emit(state.copyWith());
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl:
          "$getPlayersListingUrl?search=${searchPlayerController.text}&offset=$offset&limit$limit",
      requestCode: getPlayersListingReq,
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
      case getPlayersListingReq:
        var map = jsonDecode(response);
        log(response);

        if (map["success"] == true) {
          final currentUserId =
              sharedPreferences.getString(PreferenceKeys.userIdKey) ?? "";

          final List<PlayerModel> newPlayers = (map["players"] as List? ?? [])
              .map((e) => PlayerModel.fromJson(e))
              .where((user) => user.sId != currentUserId)
              .toList();

          state.userList.addAll(newPlayers);
          offset += newPlayers.length;

          emit(state.copyWith(userList: state.userList));
        }

        break;
    }
  }
}
