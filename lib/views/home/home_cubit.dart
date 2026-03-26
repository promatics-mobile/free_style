import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:free_style/generated/assets.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/views/skill_tree/skill_tree_cubit.dart';
import 'package:meta/meta.dart';

import '../../network_class/web_urls.dart';
import '../challenge_history/challenge_history_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> implements NetworkResponse {
  HomeCubit() : super(HomeInitial());
  List<MenuItemModel> menuItemsList = [
    MenuItemModel(title: "Skill Tree", icon: Assets.iconsIcSkillTree),
    MenuItemModel(title: "Tutorials", icon: Assets.iconsIcVideoRecord),
    //MenuItemModel(title: "Battle Arena", icon: Assets.iconsIcBattle),
    /*
    MenuItemModel(title: "Training", icon: Assets.iconsIcOutlineFootball),
    MenuItemModel(title: "Skill States", icon: Assets.iconsIcSkillState),

    MenuItemModel(title: "Missions", icon: Assets.iconsIcOutlineFootball),*/
  ];
  CurrentChallengeModel? currentChallengeModel;

  String currentLeagueName = "";
  String currentRp = "";
  String minRp = "";
  String maxRp = "";



  Stream<int> timerStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield DateTime.now().millisecondsSinceEpoch;
    }
  }

  double calculateXpProgress({
    required int xpGained,
    required int xpRequired}) {
    if (xpRequired == 0) return 0.0;
    final progress = xpGained / xpRequired;

    /// Clamp between 0.0 → 1.0
    return progress.clamp(0.0, 1.0);
  }

  String getXpPercentage({
    required int xpGained,
    required int xpRequired,
  }) {
    if (xpRequired == 0) return "0%";

    final percent = (xpGained / xpRequired) * 100;
    return "${percent.clamp(0, 100).toStringAsFixed(0)}%";
  }

  void callGetDailyChallengeApi() {
    DioNetworkCall().callApiRequest(
      query: {"current_time": DateTime.now().toUtc().toIso8601String()},
      endUrl: getDailyChallengeUrl,
      method: "GET",
      requestCode: getDailyChallengeReq,
      networkResponse: this,
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {}

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case getDailyChallengeReq:
        var data = jsonDecode(response);

        log(response);

        if (data['current_challenge'] != null) {
          currentChallengeModel = CurrentChallengeModel.fromJson(data['current_challenge']);
        }

        if(data['league_progress'] !=null){
          if(data['league_progress']['current_league'] !=null){
            currentLeagueName = data['league_progress']['current_league']['name']??"";
            minRp = data['league_progress']['current_league']['min_rp'].toString();
            maxRp = data['league_progress']['current_league']['max_rp'].toString();
            currentRp = data['league_progress']['current_rp'].toString();
          }

        }

        emit(HomeInitial());
        break;
    }
  }
}
