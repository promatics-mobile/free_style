import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/views/profile/user_model.dart';
import 'package:meta/meta.dart';
import '../../network_class/api_service.dart';
import '../../network_class/web_urls.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> implements NetworkResponse{
  UserModel? userModel;
  int selectedTabIndex = 0;
  List<ProfileItemModel> battlesList = [
    ProfileItemModel(
      title: "Victory against @ShadowStriker",
      date: "Oct 15, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Defeat by @NeonNinja",
      date: "Oct 12, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Victory against @Cryptoking",
      date: "Oct 10, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Victory against @ShadowStriker",
      date: "Oct 15, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Defeat by @NeonNinja",
      date: "Oct 12, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Victory against @Cryptoking",
      date: "Oct 10, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Victory against @ShadowStriker",
      date: "Oct 15, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Defeat by @NeonNinja",
      date: "Oct 12, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Victory against @Cryptoking",
      date: "Oct 10, 2025",
      type: "battle",
    ), ProfileItemModel(
      title: "Victory against @ShadowStriker",
      date: "Oct 15, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Defeat by @NeonNinja",
      date: "Oct 12, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Victory against @Cryptoking",
      date: "Oct 10, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Victory against @ShadowStriker",
      date: "Oct 15, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Defeat by @NeonNinja",
      date: "Oct 12, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Victory against @Cryptoking",
      date: "Oct 10, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Victory against @ShadowStriker",
      date: "Oct 15, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Defeat by @NeonNinja",
      date: "Oct 12, 2025",
      type: "battle",
    ),
    ProfileItemModel(
      title: "Victory against @Cryptoking",
      date: "Oct 10, 2025",
      type: "battle",
    ),
  ];
  List<ProfileItemModel> achievementsList = [
    ProfileItemModel(
      title: "Trick Master: 50 Tricks",
      date: "Sep 20, 2025",
      type: "achievement",
    ),
    ProfileItemModel(
      title: "First Battle Won",
      date: "Aug 15, 2025",
      type: "achievement",
    ),
    ProfileItemModel(
      title: "Technical Trio Specialist",
      date: "Jul 10, 2025",
      type: "achievement",
    ),
    ProfileItemModel(
      title: "Trick Master: 50 Tricks",
      date: "Sep 20, 2025",
      type: "achievement",
    ),
    ProfileItemModel(
      title: "First Battle Won",
      date: "Aug 15, 2025",
      type: "achievement",
    ),
    ProfileItemModel(
      title: "Technical Trio Specialist",
      date: "Jul 10, 2025",
      type: "achievement",
    ),
    ProfileItemModel(
      title: "Trick Master: 50 Tricks",
      date: "Sep 20, 2025",
      type: "achievement",
    ),
    ProfileItemModel(
      title: "First Battle Won",
      date: "Aug 15, 2025",
      type: "achievement",
    ),
    ProfileItemModel(
      title: "Technical Trio Specialist",
      date: "Jul 10, 2025",
      type: "achievement",
    ),
  ];
  List<ProfileItemModel> promotionsList = [
    ProfileItemModel(
      title: "Promoted to Gold League II",
      date: "Oct 01, 2025",
      type: "promotion",
    ),
    ProfileItemModel(
      title: "Promoted to Gold League I",
      date: "Aug 20, 2025",
      type: "promotion",
    ),
    ProfileItemModel(
      title: "Promoted to Silver League II",
      date: "Jun 15, 2025",
      type: "promotion",
    ),
    ProfileItemModel(
      title: "Promoted to Gold League II",
      date: "Oct 01, 2025",
      type: "promotion",
    ),
    ProfileItemModel(
      title: "Promoted to Gold League I",
      date: "Aug 20, 2025",
      type: "promotion",
    ),
    ProfileItemModel(
      title: "Promoted to Silver League II",
      date: "Jun 15, 2025",
      type: "promotion",
    ),
    ProfileItemModel(
      title: "Promoted to Gold League II",
      date: "Oct 01, 2025",
      type: "promotion",
    ),
    ProfileItemModel(
      title: "Promoted to Gold League I",
      date: "Aug 20, 2025",
      type: "promotion",
    ),
    ProfileItemModel(
      title: "Promoted to Silver League II",
      date: "Jun 15, 2025",
      type: "promotion",
    ),
  ];
  List<ProfileItemModel> historyList = [
    ProfileItemModel(
      title: "Participated in Global Tournament",
      date: "Sep 25, 2025",
      type: "history",
    ),
    ProfileItemModel(
      title: "Completed Daily Mission: 5 Wins",
      date: "Sep 22, 2025",
      type: "history",
    ),
    ProfileItemModel(
      title: "Unlocked 'Classic Sphere' Ball",
      date: "Sep 15, 2025",
      type: "history",
    ),
    ProfileItemModel(
      title: "Participated in Global Tournament",
      date: "Sep 25, 2025",
      type: "history",
    ),
    ProfileItemModel(
      title: "Completed Daily Mission: 5 Wins",
      date: "Sep 22, 2025",
      type: "history",
    ),
    ProfileItemModel(
      title: "Unlocked 'Classic Sphere' Ball",
      date: "Sep 15, 2025",
      type: "history",
    ),
    ProfileItemModel(
      title: "Participated in Global Tournament",
      date: "Sep 25, 2025",
      type: "history",
    ),
    ProfileItemModel(
      title: "Completed Daily Mission: 5 Wins",
      date: "Sep 22, 2025",
      type: "history",
    ),
    ProfileItemModel(
      title: "Unlocked 'Classic Sphere' Ball",
      date: "Sep 15, 2025",
      type: "history",
    ),
  ];
  List<ProfileItemModel> getActiveList() {
    switch (selectedTabIndex) {
      case 0:
        return battlesList;
      case 1:
        return achievementsList;
      case 2:
        return promotionsList;
      case 3:
        return historyList;
      default:
        return [];
    }
  }

  ProfileCubit() : super(ProfileInitial()){
    callGetProfileApi();
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

  void onChangeTab(int index) {
    selectedTabIndex = index;
    emit(ProfileInitial());
  }


  void callGetProfileApi() {
    DioNetworkCall().callApiRequest(
      endUrl: getProfileUrl,
      method: "GET",
      requestCode: getProfileReq,
      networkResponse: this,
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    switch (requestCode) {
      case getProfileReq:
        break;
    }
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    try {
      switch (requestCode) {
        case getProfileReq:
          try{
            log(response);
            var data = jsonDecode(response);
            userModel = UserModel.fromJson(data['user']);
            debugPrint("here::");
            emit(ProfileInitial());
            break;
          }catch (e, stack) {
            debugPrint("error::$e $stack");
          }

      }
    } catch (e, stack) {
      debugPrint("error::$e $stack");
    }
  }

}

class ProfileItemModel {
  final String title;
  final String date;
  final String type;

  ProfileItemModel({
    required this.title,
    required this.date,
    required this.type,
  });
}
