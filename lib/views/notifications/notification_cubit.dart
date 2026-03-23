import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/utils/common_methods.dart';

import '../../network_class/web_urls.dart';

part 'notification_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> implements NetworkResponse {
  int offset = 0;
  List<NotificationModel> notificationsList = [];

  NotificationsCubit() : super(NotificationsState(selectedTabIndex: 0)){
    callNotificationApi(true, offset);
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    offset = 0;
    callNotificationApi(false, 0);
  }

  void onLoadData() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    offset += 15;
    callNotificationApi(false, offset);
  }

  void callNotificationApi(bool showLoader, int offset) {
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      endUrl: notificationListUrl,
      requestCode: notificationListReq,
      method: 'GET',
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    try {
      switch (requestCode) {
        case notificationListReq:
          debugPrint("notificationListReq:::Error::");
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
        case notificationListReq:
          var data = jsonDecode(response);
          if (data['notifications'] != null) {
            var sList = data['notifications'] as List;
            var list = sList.map((e) => NotificationModel.fromJson(e)).toList();
            debugPrint("nList:: ${list.length}");

            if (offset == 0) {
              notificationsList = [];
              notificationsList.addAll(list);
              emit(state.copyWith());
            } else {
              notificationsList.addAll(list);
              emit(state.copyWith());
            }
          }

          break;
      }
    } catch (e, stacktrace) {
      debugPrint("ApiException::$e");
      debugPrint('Stacktrace:: ${stacktrace.toString()}');
    }
  }
}


