import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

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

  void onChangeTab(int index) {
    selectedTabIndex = index;
    emit(ProfileInitial());
  }

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
