import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/main.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:free_style/routes/route.dart';
import 'package:free_style/utils/common_methods.dart';
import 'package:free_style/views/dashboard/dashboard_cubit.dart';
import 'package:free_style/views/shop/shop_model.dart';
import 'package:meta/meta.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> implements NetworkResponse {
  ShopCubit() : super(ShopInitial());

  List<ShopItem> shopList = [];
  int offset = 0;
  int limit = 10;
  bool isLastPage = false;
  bool isFromDetails = false;
  bool isLoadMore = false;
  bool isLoading = false;

  String selectedTier = "All";
  String tempTier = "All";
  String selectedSort = "Newest";
  String tempSort = "Newest";

  void updateTempTier(String tier) {
    tempTier = tier;
    emit(ShopInitial());
  }

  void updateTempSort(String sort) {
    tempSort = sort;
    emit(ShopInitial());
  }

  void fetchShopItems({
    String sort = "",
    String price = "",
    String rarity = "",
    bool isRefresh = false,
  }) {
    if (isRefresh) {
      offset = 0;
      isLastPage = false;
      shopList.clear();
      isLoading = true;
    } else {
      if (isLastPage || isLoadMore || isLoading) return;
      isLoadMore = true;
    }

    emit(ShopInitial());

    String url = "$fetchShopUrl?offset=$offset&limit=$limit";

    String finalSort = sort.isEmpty ? (selectedSort == "Newest" ? "desc" : "") : sort;
    String finalPrice = price.isEmpty
        ? (selectedSort == "Price: Low to High"
              ? "asc"
              : (selectedSort == "Price: High to Low" ? "desc" : ""))
        : price;
    String finalRarity = rarity.isEmpty ? selectedTier : rarity;

    if (finalSort.isNotEmpty) url += "&sort=$finalSort";
    if (finalPrice.isNotEmpty) url += "&price=$finalPrice";
    if (finalRarity.isNotEmpty && finalRarity != "All") {
      url += "&rarity=${finalRarity.toLowerCase()}";
    }

    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl: url,
      requestCode: fetchShopReq,
    );
  }


  void callBuyProductApi(String id,bool isFromDetail){
    isFromDetails = isFromDetail;
    emit(ShopInitial());
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'POST',
      endUrl: buyProductUrl+id,
      requestCode: buyProductReq,
      showLoader: true,
      query: {
        "purchaseType":"coins"
      },
    );
  }

  void callEquipItemApi(String id, String type){
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'PATCH',
      endUrl: equipItemUrl,
      requestCode: equipItemReq,
      showLoader: true,
      query: {
        type:id
      },
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    isLoading = false;
    isLoadMore = false;
    emit(ShopInitial());
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    isLoading = false;
    isLoadMore = false;
    switch (requestCode) {
      case fetchShopReq:
        var map = jsonDecode(response);
        ShopModel model = ShopModel.fromJson(map);
        if (model.success == true) {
          List<ShopItem> newItems = model.shop ?? [];
          if (newItems.length < limit) {
            isLastPage = true;
          }
          shopList.addAll(newItems);
          offset += newItems.length;
        }
        emit(ShopInitial());
        break;


      case buyProductReq:
        if(isFromDetails){
          router.pop();
          isFromDetails = false;
        }
        showToast(isError: false, message: "Item Purchased Successfully");
        navigatorKey.currentContext!.read<DashboardCubit>().callGetProfileApi();
        fetchShopItems(isRefresh: true);
        break;

        case equipItemReq:
        showToast(isError: false, message: "Item Equipped Successfully");
        break;
    }
  }
}
