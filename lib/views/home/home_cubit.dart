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
    //MenuItemModel(title: "Battle Arena", icon: Assets.iconsIcBattle),
    /*
    MenuItemModel(title: "Training", icon: Assets.iconsIcOutlineFootball),
    MenuItemModel(title: "Skill States", icon: Assets.iconsIcSkillState),
    MenuItemModel(title: "Tutorials", icon: Assets.iconsIcVideoRecord),
    MenuItemModel(title: "Missions", icon: Assets.iconsIcOutlineFootball),*/
  ];
  CurrentChallengeModel? currentChallengeModel;



  Stream<int> timerStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield DateTime.now().millisecondsSinceEpoch;
    }
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

        if (data['data']['current_challenge'] != null) {
          currentChallengeModel = CurrentChallengeModel.fromJson(data['data']['current_challenge']);
        }

        emit(HomeInitial());
        break;
    }
  }
}
