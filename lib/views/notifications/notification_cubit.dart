import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/utils/common_methods.dart';

import '../../network_class/web_urls.dart';

part 'notification_state.dart';

class NotificationsCubit extends Cubit<NotificationsState>
    implements NetworkResponse {
  int offset = 0;
  final int limit = 20;

  bool isLastPage = false;
  bool isLoading = false;
  bool isLoadMore = false;

  List<NotificationModel> notificationsList = [];

  NotificationsCubit()
      : super(NotificationsState(selectedTabIndex: 0)) {
    fetchNotifications(isRefresh: true, showLoader: true);
  }

  /// 🔄 REFRESH
  Future<void> onRefresh() async {
    fetchNotifications(isRefresh: true);
  }

  /// ⬇️ LOAD MORE
  Future<void> onLoadMore() async {
    if (isLastPage || isLoadMore || isLoading) return;
    isLoadMore = true;
    fetchNotifications();
  }

  /// 🚀 COMMON API METHOD
  void fetchNotifications({
    bool isRefresh = false,
    bool showLoader = false,
  }) {
    if (isRefresh) {
      offset = 0;
      isLastPage = false;
      notificationsList.clear();
      isLoading = true;
    }

    DioNetworkCall().callApiRequest(
      networkResponse: this,
      endUrl: notificationListUrl,
      requestCode: notificationListReq,
      showLoader: showLoader,
      query: {
        "limit": limit,
        "offset": offset,
      },
      method: 'GET',
    );
  }


  @override
  void onApiError({required int requestCode, required String response}) {
    isLoading = false;
    isLoadMore = false;

    if (requestCode == notificationListReq) {
      debugPrint("notificationListReq:::Error:: $response");
    }

    emit(state.copyWith());
  }


  @override
  void onResponse({required int requestCode, required String response}) {
    switch(requestCode){
      case notificationListReq :
        final data = jsonDecode(response);

        final List list = data['notifications'] ?? [];
        final newList =
        list.map((e) => NotificationModel.fromJson(e)).toList();

        /// 🔚 CHECK LAST PAGE
        if (newList.length < limit) {
          isLastPage = true;
        }

        /// 🔄 UPDATE LIST
        if (offset == 0) {
          notificationsList = newList;
        } else {
          notificationsList.addAll(newList);
        }

        /// ⬆️ UPDATE OFFSET
        offset += newList.length;

        /// RESET FLAGS
        isLoading = false;
        isLoadMore = false;

        emit(state.copyWith());
        break;

    }

  }
}


