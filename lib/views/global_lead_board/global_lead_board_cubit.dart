import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:meta/meta.dart';

import '../../network_class/web_urls.dart';
import '../../utils/common_methods.dart';

part 'global_lead_board_state.dart';

class GlobalLeadBoardCubit extends Cubit<GlobalLeadBoardState> implements NetworkResponse {
  List<GlobalLeaderboardModel> globalLeaderBoardList = [];
  List<LeagueModel> leagueList = [];
  String sLeagueId = "";
  int offset = 0;
  int limit = 10;
  bool isLastPage = false;
  bool isLoadMore = false;
  bool isLoading = false;

  TextEditingController searchController = TextEditingController();
  final debouncer = Debouncer(milliseconds: 500);

  GlobalLeadBoardCubit() : super(GlobalLeadBoardInitial()) {
    callLeagueListingApi();
    callGlobalLeaderBoardApi(true);
  }

  void onSelectLeague(int index) {
    int pos = leagueList.indexWhere((e) => e.isSelected);
    if (pos >= 0) {
      leagueList[pos].isSelected = false;
    }
    leagueList[index].isSelected = true;
    sLeagueId = leagueList[index].id;
    emit(GlobalLeadBoardInitial());
  }

  void onResetFilter() {
    for (var e in leagueList) {
      e.isSelected = false;
    }
    sLeagueId = "";
    emit(GlobalLeadBoardInitial());
    callGlobalLeaderBoardApi(true);
  }

  void callLeagueListingApi() {
    DioNetworkCall().callApiRequest(
      endUrl: leagueListUrl,
      method: "GET",
      requestCode: leagueListReq,
      networkResponse: this,
    );
  }

  void callGlobalLeaderBoardApi(bool isRefresh) {
    if (isRefresh) {
      offset = 0;
      isLastPage = false;
      globalLeaderBoardList.clear();
      isLoading = true;
    } else {
      if (isLastPage || isLoadMore || isLoading) return;
      isLoadMore = true;
    }
    emit(GlobalLeadBoardInitial());


    DioNetworkCall().callApiRequest(
      endUrl: globalLeaderBoardListUrl,
      query: {
        "search": searchController.text,
        "league": sLeagueId,
        "limit" : limit,
        "offset": offset
      },
      method: "GET",
      requestCode: globalLeaderBoardListReq,
      networkResponse: this,
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {}

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case globalLeaderBoardListReq:
        var data = jsonDecode(response);
        isLoading = false;
        isLoadMore = false;

        if (data['success'] == true) {
          var list = data['leaderboard'] as List;
          var gList = list.map((e) => GlobalLeaderboardModel.fromJson(e)).toList();

          if (gList.length < limit) {
            isLastPage = true;
          }

          if(searchController.text.isNotEmpty){
            globalLeaderBoardList.clear();
          }

          globalLeaderBoardList.addAll(gList);
          offset += gList.length;
        }

        emit(GlobalLeadBoardInitial());

        break;

      case leagueListReq:
        var data = jsonDecode(response);

        if (data['success'] == true) {
          var list = data['leagues'] as List;
          leagueList = list.map((e) => LeagueModel.fromJson(e)).toList();
        }

        emit(GlobalLeadBoardInitial());

        break;
    }
  }
}
