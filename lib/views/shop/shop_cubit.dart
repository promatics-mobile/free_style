import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import 'package:free_style/network_class/api_service.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:free_style/views/shop/shop_model.dart';
import 'package:meta/meta.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> implements NetworkResponse {
  ShopCubit() : super(ShopInitial());

  List<ShopItem> shopList = [];

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
    String sort = "", // desc, asc for date
    String price = "", // desc, asc
    String rarity = "", // normal, rare, epic, legendary
  }) {
    String url = "$fetchShopUrl?offset=0&limit=50";
    if (sort.isNotEmpty) url += "&sort=$sort";
    if (price.isNotEmpty) url += "&price=$price";
    if (rarity.isNotEmpty && rarity != "All") url += "&rarity=${rarity.toLowerCase()}";

    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: 'GET',
      endUrl: url,
      showLoader: true,
      requestCode: fetchShopReq,
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {}

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case fetchShopReq:
        var map = jsonDecode(response);
        ShopModel model = ShopModel.fromJson(map);
        if (model.success == true) {
          shopList = model.shop ?? [];
        }
        emit(ShopInitial());
        break;
    }
  }
}
