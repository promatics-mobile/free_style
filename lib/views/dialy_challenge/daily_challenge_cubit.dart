import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:meta/meta.dart';

import '../home/home_cubit.dart';
import '../skill_tree/skill_tree_cubit.dart';

part 'daily_challenge_state.dart';

class DailyChallengeCubit extends Cubit<DailyChallengeState> implements NetworkResponse{
  String id = "";

  DailyChallengeCubit({required this.id}) : super(DailyChallengeInitial()) {
    callGetDailyChallengeDetailsApi();
  }
  List<StepperData> stepData = [
    const StepperData(
      icon: "",
      title: "Around the World",
      subtitle: "Basics • Lower",
    ),
    const StepperData(
      icon: "",
      title: "Crossover",
      subtitle: "Basics • Lower",
    ),
    const StepperData(
      icon: "",
      title: "Toe Bounce",
      subtitle: "Intermediate • Ground",
    ),

  ];
  CurrentChallengeModel? currentChallengeModel;

  Stream<int> timerStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield DateTime.now().millisecondsSinceEpoch;
    }
  }

  void callGetDailyChallengeDetailsApi() {
    DioNetworkCall().callApiRequest(
        endUrl: dailyChallengeDetailsUrl+id,
        method: "GET",
        requestCode: dailyChallengeDetailsReq,
        networkResponse: this);
  }

  @override
  void onApiError({required int requestCode, required String response}) {
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch(requestCode){
      case dailyChallengeDetailsReq:
        log(response);
        var data = jsonDecode(response);
        if (data['data'] != null) {
          currentChallengeModel = CurrentChallengeModel.fromJson(data['data']);
        }

        emit(DailyChallengeInitial());
        break;

    }
  }


}
