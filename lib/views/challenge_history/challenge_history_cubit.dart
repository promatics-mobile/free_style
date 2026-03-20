import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:meta/meta.dart';

import '../home/home_cubit.dart';

part 'challenge_history_state.dart';

class ChallengeHistoryCubit extends Cubit<ChallengeHistoryState> implements NetworkResponse{
  int offset = 0;
  int limit = 10;
  bool isLoadMore = false;
  bool isLoading = false;
  bool isLastPage = false;
  CurrentChallengeModel? currentChallengeModel;
  List<ChallengeHistoryModel> challengeHistoryList = [];

  ChallengeHistoryCubit() : super(ChallengeHistoryInitial()) {
    callDailyChallengeHistoryApi(isRefresh: true, isShowLoader: true);
  }


  String getDay(DateTime date) {
    return date.day.toString();
  }

  String getMonthShort(DateTime date) {
    const months = [
      "JAN","FEB","MAR","APR","MAY","JUN",
      "JUL","AUG","SEP","OCT","NOV","DEC"
    ];
    return months[date.month - 1];
  }

  void callDailyChallengeHistoryApi({bool isRefresh = false, bool isShowLoader = false}) {
    if (isRefresh) {
      offset = 0;
      isLastPage = false;
      challengeHistoryList.clear();
      isLoading = true;
    } else {
      if (isLastPage || isLoadMore || isLoading) return;
      isLoadMore = true;
    }

    DioNetworkCall().callApiRequest(endUrl: dailyChallengeHistoryListUrl,
        method: "GET",
        query: {
          "offset": offset,
          "limit": limit,
        },
        showLoader: isRefresh,
        requestCode: dailyChallengeHistoryListReq,
        networkResponse: this);
  }

  @override
  void onApiError({required int requestCode, required String response}) {
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode){
      case dailyChallengeHistoryListReq:
        var map = jsonDecode(response);
        if (map["data"] !=null) {
          var list = map["data"] as List;

          if(map["current_challenge"] !=null){
            var cChallenge = map["current_challenge"] ;
            if(cChallenge['submission'] !=null){
              currentChallengeModel = CurrentChallengeModel.fromJson(cChallenge);
            }
          }



          var cList = list.map((e)=> ChallengeHistoryModel.fromJson(e)).toList();

          challengeHistoryList.addAll(cList);
          offset += cList.length;

          emit(ChallengeHistoryInitial());
        }
        break;
    }
  }


}
