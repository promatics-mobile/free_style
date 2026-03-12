import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/main.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/views/social/social_screen.dart';

import '../../network_class/web_urls.dart';
import '../../routes/route.dart';
import '../battles/battles_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../profile/user_model.dart';

class DashboardCubit extends Cubit<DashboardState> implements NetworkResponse {
  UserModel? userModel;
  final List<Widget> dashboardScreens = [
    HomeScreen(),
    BattlesScreen(),
    SocialScreen(),
    ProfileScreen(),
  ];




  DashboardCubit(int value)
    : super(DashboardState(selectedIndex: 0, selectedTabIndex: 0, selectedTitle: "Home")) {
    sharedPreferences.setBool(PreferenceKeys.isRememberedKey, true);
    Future.delayed(Duration(milliseconds: 500), () {
      onTapBottomBar(value);
    });
    callGetProfileApi();
  }



  void onTapBottomBar(int index) {
    String name = "";
    switch (index) {
      case 0:
        name = "Home";
        router.go(AppRouter.homeScreen);
        callGetProfileApi();
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
          try{
            var data = jsonDecode(response);
            userModel = UserModel.fromJson(data['user']);
            debugPrint("here::");
            emit(state.copyWith());
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
