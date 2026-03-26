import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:free_style/utils/common_methods.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../../network_class/api_service.dart';
import '../../utils/common_constants.dart';
import '../battles/battles_cubit.dart';
import '../search_players/search_players_cubit.dart';

part 'battle_details_state.dart';

class BattleDetailsCubit extends Cubit<BattleDetailsState> implements NetworkResponse{
  String id = "";
  BattleModel? battleModel;
  PlayerModel? selectedFriend;
  List<PlayerModel> myFriendsList = [];
  BattleDetailsCubit({required this.id}) : super(BattleDetailsInitial()){
    callBattleDetailsApi();
    callFriendListApi();
  }

  Stream<int> timerStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield DateTime.now().millisecondsSinceEpoch;
    }
  }

  void onSelectFriend(PlayerModel friend) {
    selectedFriend = friend;
    emit(BattleDetailsInitial());
  }


  void callBattleDetailsApi() {
    DioNetworkCall().callApiRequest(
        endUrl: battleDetailsUrl+id,
        method: "GET",
        requestCode: battleDetailsReq,
        networkResponse: this,
        showLoader: true
    );
  }

  void callFriendListApi() {
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl: getFriendListUrl,
      requestCode: getFriendListReq,
      json: {},
    );
  }

  void callStartBattleApi(String battleId, String friendId) {
    Map<String,dynamic> jsonData = {"battle_id": battleId,};

    if(friendId.isNotEmpty){
      jsonData["friend_id"] = friendId;
    }

    DioNetworkCall().callApiRequest(
        endUrl: createBattleUrl,
        method: "POST",
        requestCode: createBattleReq,
        json: jsonData,
        networkResponse: this,
        showLoader: true
    );
  }




  @override
  void onApiError({required int requestCode, required String response}) {}

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case battleDetailsReq:
        var data = jsonDecode(response);
        if(data['battle'] !=null){
          battleModel = BattleModel.fromJson(data['battle'] );
        }
        emit(BattleDetailsInitial());

        break;

        case createBattleReq:
        var data = jsonDecode(response);
        showToast(isError: false, message: "Battle invited successfully");

        emit(BattleDetailsInitial());
        break;

      case getFriendListReq:
        var map = jsonDecode(response);

        if (map["success"] == true) {
          final data = map["data"] ?? {};
          final currentUserId = sharedPreferences.getString(PreferenceKeys.userIdKey) ?? "";
          myFriendsList = (data["friends"] as List? ?? [])
              .map((e) => PlayerModel.fromJson(e["friend"], rId: e["_id"]))
              .where((user) => user.sId != currentUserId)
              .toList();
          emit(BattleDetailsInitial());
        }
        break;

    }
  }
}
