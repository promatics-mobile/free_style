import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/main.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/views/dashboard/dashboard_cubit.dart';
import 'package:free_style/views/home/home_cubit.dart';
import 'package:meta/meta.dart';

import '../../network_class/api_service.dart';
import '../../network_class/web_urls.dart';
import '../../utils/common_methods.dart';
import '../shop/shop_model.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> implements NetworkResponse {
  InventoryCubit() : super(InventoryInitial());

  List<ItemModel> freePremiumList = [
    ItemModel(title: "Free", isSelected: true),
    ItemModel(title: "Premium", isSelected: false),
  ];

  List<ItemModel> ballAvatarList = [
    ItemModel(title: "Avatar", isSelected: true),
    ItemModel(title: "Balls", isSelected: false),
  ];

  List<ShopItem> inventoryList = [];
  int offset = 0;
  int limit = 10;
  bool isLastPage = false;
  bool isLoadMore = false;
  bool isLoading = false;

  String selectedTier = "All";
  String tempTier = "All";
  String selectedSort = "Newest";
  String tempSort = "Newest";

  void onSelectFreePremium(int index) {
    int pos = freePremiumList.indexWhere((element) => element.isSelected);
    if (pos >= 0) {
      freePremiumList[pos].isSelected = false;
    }
    freePremiumList[index].isSelected = true;
    emit(InventoryInitial());
    fetchInventoryItems(isRefresh: true);
  }

  void onSelectBallsAvatar(int index) {
    int pos = ballAvatarList.indexWhere((element) => element.isSelected);
    if (pos >= 0) {
      ballAvatarList[pos].isSelected = false;
    }
    ballAvatarList[index].isSelected = true;
    emit(InventoryInitial());
    fetchInventoryItems(isRefresh: true);
  }

  void updateTempTier(String tier) {
    tempTier = tier;
    emit(InventoryInitial());
  }

  void updateTempSort(String sort) {
    tempSort = sort;
    emit(InventoryInitial());
  }

  void fetchInventoryItems({
    String sort = "",
    String price = "",
    String rarity = "",
    bool isRefresh = false,
  }) {
    if (isRefresh) {
      offset = 0;
      isLastPage = false;
      inventoryList.clear();
      isLoading = true;
    } else {
      if (isLastPage || isLoadMore || isLoading) return;
      isLoadMore = true;
    }

    emit(InventoryInitial());

    String url = "$fetchInventoryUrl?offset=$offset&limit=$limit";

    String selectedFreePremium = freePremiumList.where((e) => e.isSelected).first.title.toLowerCase();
    String selectedBallAvatar = ballAvatarList.where((e) => e.isSelected).first.title.toLowerCase();

    if (selectedFreePremium.isNotEmpty) {
      url += "&tab=$selectedFreePremium";
    }
    if (selectedBallAvatar.isNotEmpty) {
      url += "&type=$selectedBallAvatar";
    }

    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl: url,
      requestCode: fetchInventoryReq,
    );
  }

  void callEquipItemApi(String id) {
   String key = ballAvatarList.where((e)=> e.isSelected).first.title.toLowerCase();
   if(key == "balls"){
     key = "ball";
   }else{
     key = "avatar";
   }

    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'PATCH',
      endUrl: equipItemUrl,
      requestCode: equipItemReq,
      showLoader: true,
      query: {"${key}Id": id},
    );
  }



  @override
  void onApiError({required int requestCode, required String response}) {
    isLoading = false;
    isLoadMore = false;
    emit(InventoryInitial());
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    isLoading = false;
    isLoadMore = false;
    switch (requestCode) {
      case fetchInventoryReq:
        log(response);
        var map = jsonDecode(response);
        InventoryModel model = InventoryModel.fromJson(map);
        if (model.success == true) {
          List<ShopItem> newItems = model.shop ?? [];
          if (newItems.length < limit) {
            isLastPage = true;
          }
          inventoryList.addAll(newItems);
          offset += newItems.length;
        }
        emit(InventoryInitial());
        break;

      case equipItemReq:
        showToast(isError: false, message: "Item Equipped Successfully");
        navigatorKey.currentContext!.read<DashboardCubit>().callGetProfileApi();
        break;
    }
  }
}
