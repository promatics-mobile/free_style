import 'package:bloc/bloc.dart';
import 'package:free_style/views/match_making/match_making_cubit.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:meta/meta.dart';

import '../../network_class/api_response.dart';

part 'battle_history_state.dart';


class BattleHistoryCubit extends Cubit<BattleHistoryState>
    implements NetworkResponse {

  BattleHistoryCubit() : super(BattleHistoryInitial()) {
    fetchBattleHistory(isRefresh: true, isShowLoader: true);
  }

  int offset = 0;
  int limit = 10;

  bool isLoadMore = false;
  bool isLoading = false;
  bool isLastPage = false;

  BattleHistoryModel? activeBattle;
  List<BattleHistoryModel> historyList = [];

  /// 🔥 API CALL
  void fetchBattleHistory({
    bool isRefresh = false,
    bool isShowLoader = false,
  }) {
    if (isRefresh) {
      offset = 0;
      isLastPage = false;
      historyList.clear();
      activeBattle = null;
      isLoading = true;
    } else {
      if (isLastPage || isLoadMore || isLoading) return;
      isLoadMore = true;
    }

    DioNetworkCall().callApiRequest(
      endUrl: battleHistoryUrl,
      method: "GET",
      query: {
        "offset": offset,
        "limit": limit,
      },
      showLoader: isShowLoader,
      requestCode: battleHistoryReq,
      networkResponse: this,
    );
  }

  /// ❌ ERROR
  @override
  void onApiError({required int requestCode, required String response}) {
    isLoading = false;
    isLoadMore = false;
    emit(BattleHistoryInitial());
  }

  /// ✅ RESPONSE
  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case battleHistoryReq:
        final map = jsonDecode(response);

        if (map["battles"] != null) {
          final list = map["battles"] as List;

          /// 🔥 PARSE LIST
          final tempList = list
              .map((e) => BattleHistoryModel.fromJson(e))
              .toList();

          /// 🔥 SEPARATE ACTIVE BATTLE
          for (var item in tempList) {
            if (item.status == "active") {
              activeBattle = item;
            } else {
              historyList.add(item);
            }
          }

          /// 🔥 PAGINATION
          offset += tempList.length;

          if (tempList.length < limit) {
            isLastPage = true;
          }

          isLoading = false;
          isLoadMore = false;

          emit(BattleHistoryInitial());
        }
        break;
    }
  }

}
