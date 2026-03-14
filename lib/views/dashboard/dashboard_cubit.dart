import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/main.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/utils/common_constants.dart';

import '../../network_class/web_urls.dart';
import '../../routes/route.dart';
import '../profile/user_model.dart';
import '../profile_setup/cosmetics_model.dart';

class DashboardCubit extends Cubit<DashboardState> implements NetworkResponse {
  UserModel? userModel;

  DashboardCubit(int value)
    : super(DashboardState(selectedIndex: 0, selectedTabIndex: 0, selectedTitle: "Home"));

  void onTapBottomBar(int index) {
    String name = "";

    switch (index) {
      case 0:
        name = "Home";
        router.go(AppRouter.homeScreen);
        if ((sharedPreferences.getString(PreferenceKeys.tokenKey) ?? "").isNotEmpty) {
          callGetProfileApi();
        }
        break;
      case 1:
        name = "Battles";
        router.go(AppRouter.battleScreen);
        break;
      case 2:
        name = "Social";
        router.go(AppRouter.socialScreen);
        break;

      case 3:
        name = "My profile";
        router.go(AppRouter.profileScreen);
        break;
    }
    debugPrint("index::$index");
    state.selectedIndex = index;
    state.selectedTitle = name;

    emit(state.copyWith(selectedIndex: state.selectedIndex, selectedTitle: state.selectedTitle));
  }

  void onChangeHelpSupportTab(int index) {
    emit(state.copyWith(selectedTabIndex: index));
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
          try {
            var map = jsonDecode(response);
            userModel = UserModel.fromJson(map['user']);

            sharedPreferences.setString(PreferenceKeys.emailKey, map['user']["email"] ?? "");
            sharedPreferences.setString(PreferenceKeys.userNameKey, map['user']["user_name"] ?? "");

            if (map['user']['equipped']['avatar'] != null) {
              var avatar = CosmeticItem.fromJson(map['user']['equipped']["avatar"]);
              sharedPreferences.setString(PreferenceKeys.avatarIdKey, avatar.sId ?? "");
              sharedPreferences.setString(
                PreferenceKeys.avatarImageKey,
                avatar.picture!.first.fullPath ?? "",
              );
            }
            if (map['user']['equipped']['ball'] != null) {
              var avatar = CosmeticItem.fromJson(map['user']['equipped']["ball"]);
              sharedPreferences.setString(PreferenceKeys.ballIdKey, avatar.sId ?? "");
              sharedPreferences.setString(
                PreferenceKeys.ballImageKey,
                avatar.picture!.first.fullPath ?? "",
              );
            }
            if (map['user']['mobile'] != null) {
              sharedPreferences.setString(
                PreferenceKeys.countryCodeKey,
                map['user']['mobile']["country_code"] ?? "",
              );
              sharedPreferences.setString(
                PreferenceKeys.mobileKey,
                map['user']['mobile']["number"] ?? "",
              );
            }

            emit(state.copyWith());
            debugPrint("userName::${userModel!.userName}");
            if (userModel!.userName == null) {
              final isSameRoute = router.state.path == AppRouter.profileSetupScreen;
              if (!isSameRoute) {
                router.push(AppRouter.profileSetupScreen);
              }
            }

            break;
          } catch (e, stack) {
            debugPrint("error::$e $stack");
          }
      }
    } catch (e, stack) {
      debugPrint("error::$e $stack");
    }
  }
}

class DashboardState {
  int? selectedIndex;
  int? selectedTabIndex;
  String? selectedTitle;

  DashboardState({this.selectedIndex, this.selectedTitle, this.selectedTabIndex});

  DashboardState copyWith({int? selectedIndex, int? selectedTabIndex, String? selectedTitle}) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      selectedTitle: selectedTitle ?? this.selectedTitle,
    );
  }
}
