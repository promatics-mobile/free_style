import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:meta/meta.dart';

import '../../network_class/web_urls.dart';
import '../tutorial/tutorial_cubit.dart';

part 'match_making_state.dart';

class MatchMakingCubit extends Cubit<MatchMakingState> implements NetworkResponse {
  String referenceId = "";
  OngoingBattleModel? ongoingBattleModel;

  MatchMakingCubit({required this.referenceId}) : super(MatchMakingInitial()){
    if(referenceId.isNotEmpty){
      callOngoingBattleApi();
    }
  }

  void callOngoingBattleApi() {
    DioNetworkCall().callApiRequest(
      endUrl: ongoingBattleUrl + referenceId,
      method: "GET",
      requestCode: ongoingBattleReq,
      showLoader: true,
      networkResponse: this,
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {}

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case ongoingBattleReq:
        var map = jsonDecode(response);

        if (map["success"] == true) {
          ongoingBattleModel = OngoingBattleModel.fromJson(map["data"]);

          emit(MatchMakingInitial());
        }

        break;
    }
  }
}
