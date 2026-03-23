import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../../network_class/api_service.dart';
import '../../network_class/web_urls.dart';
import '../../routes/route.dart';
import '../dashboard/dashboard_cubit.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> implements NetworkResponse{
  SettingsCubit() : super(SettingsInitial());


  void callRemoveDeviceApi(String deviceId) {

    DioNetworkCall().callApiRequest(
        networkResponse: this,
        endUrl: removeFcmUrl,
        showLoader: false,
        json: {
          'device_id': deviceId,
        },
        requestCode: removeFcmReq,
        method: 'DELETE');
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    try {
      switch (requestCode) {
        case removeFcmReq:
          debugPrint("removeFcmReqError:: $response");
          var res = jsonDecode(response);
          sharedPreferences.clear().then((value) {
            router.go(AppRouter.walkThroughScreen);
            navigatorKey.currentContext!.read<DashboardCubit>().onTapBottomBar(0);
          });

          break;
      }
    } catch (e, stacktrace) {
      debugPrint("ApiException::$e");
      debugPrint('Stacktrace:: ${stacktrace.toString()}');
    }
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    try {
      switch (requestCode) {
        case removeFcmReq:
          debugPrint("removeFcmReqSuccess:: $response");
          sharedPreferences.clear().then((value) {
            router.go(AppRouter.walkThroughScreen);
            navigatorKey.currentContext!.read<DashboardCubit>().onTapBottomBar(0);
          });

          break;
      }
    } catch (e, stacktrace) {
      debugPrint("ApiException::$e");
      debugPrint('Stacktrace:: ${stacktrace.toString()}');
    }
  }
}
