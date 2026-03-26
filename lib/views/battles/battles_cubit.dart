import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:meta/meta.dart';

import '../skill_tree/skill_tree_cubit.dart';

part 'battles_state.dart';

class BattlesCubit extends Cubit<BattlesState> implements NetworkResponse {
  List<BattleModel> battleList = [];
  bool showShimmer = false;

  BattlesCubit() : super(BattlesInitial()){
    callBattleListApi();
  }

  void callBattleListApi() {
    showShimmer = true;
    emit(BattlesInitial());
    DioNetworkCall().callApiRequest(
        endUrl: battlesListUrl,
        method: "GET",
        requestCode: battlesListReq,
        networkResponse: this,
        //showLoader: true
    );
  }


  @override
  void onApiError({required int requestCode, required String response}) {}

  @override
  void onResponse({required int requestCode, required String response}) {
    showShimmer = false;
    switch (requestCode) {
      case battlesListReq:
        var data = jsonDecode(response);
        if(data['battles'] !=null){
          var list = data['battles'] as List;
          battleList = list.map((e) => BattleModel.fromJson(e)).toList();
        }
        emit(BattlesInitial());

        }
    }
  }
