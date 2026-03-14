import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:free_style/views/profile_setup/cosmetics_model.dart';
import '../../main.dart';
import '../../network_class/api_response.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../dashboard/dashboard_cubit.dart';

part 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState> implements NetworkResponse {
  TextEditingController usernameController = TextEditingController();
  List<CosmeticItem> avatars = [];
  List<CosmeticItem> balls = [];
  String? selectedAvatarId;
  String? selectedBallId;
  String selectedAvatarPath = "";
  String selectedBallPath="";
  bool isUsernameAvailable = false;

  ProfileSetupCubit() : super(ProfileSetupInitial()){
    usernameController.text = sharedPreferences.getString(PreferenceKeys.userNameKey)??"";
    selectedAvatarId = sharedPreferences.getString(PreferenceKeys.avatarIdKey)??"";
    selectedBallId = sharedPreferences.getString(PreferenceKeys.ballIdKey)??"";
    selectedAvatarPath = sharedPreferences.getString(PreferenceKeys.avatarImageKey)??"";
    selectedBallPath = sharedPreferences.getString(PreferenceKeys.ballImageKey)??"";

    callGetCosmeticsApi();
  }


  void onSelectAvatar(String id,String path) {
    selectedAvatarId = id;
    selectedAvatarPath = path;
    emit(ProfileSetupInitial());
  }

  void onSelectBall(String id,String path) {
    selectedBallId = id;
    selectedBallPath = path;
    emit(ProfileSetupInitial());
  }

  void callGetCosmeticsApi() {
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl: profileCosmeticsUrl,
      requestCode: profileCosmeticsReq,
    );
  }

  void checkUsernameAvailability(String username) {
    if (username.isEmpty) return;
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'POST',
      endUrl: "$availableUsernameUrl?userName=$username",
      requestCode: availableUsernameReq,
    );
  }

  void callProfileSetupApi() {
    final Map<String, dynamic> param = {
      "avatarId": selectedAvatarId,
      "ballId": selectedBallId,
    };

    if(usernameController.text != sharedPreferences.getString(PreferenceKeys.userNameKey)){
      param['user_name'] = usernameController.text;
    }

    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'POST',
      endUrl: profileSetupUrl,
      requestCode: profileSetupReq,
      json: param,
      showLoader: true
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    switch (requestCode) {
      case availableUsernameReq:
        isUsernameAvailable = false;
        emit(ProfileSetupInitial());
        break;
    }
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    var map = jsonDecode(response);
    switch (requestCode) {
      case profileCosmeticsReq:
        if (map['success'] == true) {

          if (map["data"] !=null) {
            var avatarList = map['data']["avatars"] as List;
            var ballList = map['data']["balls"] as List;
            avatars = avatarList.map((e) => CosmeticItem.fromJson(e)).toList();
            balls = ballList.map((e) => CosmeticItem.fromJson(e)).toList();
          }
          emit(ProfileSetupInitial());
        }
        break;

      case availableUsernameReq:
        if (map['success'] == true) {
          isUsernameAvailable = true;
        } else {
          isUsernameAvailable = false;
        }
        emit(ProfileSetupInitial());
        break;

      case profileSetupReq:
        if (map['success'] == true) {
          sharedPreferences.setString(PreferenceKeys.avatarImageKey,selectedAvatarPath);
          sharedPreferences.setString(PreferenceKeys.avatarIdKey,selectedAvatarId??"");
          sharedPreferences.setString(PreferenceKeys.ballImageKey,selectedBallPath);
          sharedPreferences.setString(PreferenceKeys.ballIdKey,selectedBallId??"");
          sharedPreferences.setString(PreferenceKeys.userNameKey,usernameController.text);

          router.go(AppRouter.homeScreen);

          Future.delayed(Duration(seconds: 1),(){
            navigatorKey.currentContext!.read<DashboardCubit>().onTapBottomBar(0);
          });
        }
        break;
    }
  }
}
