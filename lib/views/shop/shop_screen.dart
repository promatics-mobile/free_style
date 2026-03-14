import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';
import 'package:free_style/views/dashboard/dashboard_cubit.dart';
import 'package:free_style/views/shop/shop_cubit.dart';
import 'package:free_style/views/shop/shop_model.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_methods.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_refresh_indicator/common_refresh_indicator.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ShopCubit>().fetchShopItems(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        var cubit = context.read<ShopCubit>();
        return Scaffold(
          appBar: CommonAppBar(
            title: "Shop",
            actions: [
              Container(
                decoration: commonBgColorDecoration(
                  size(context).width * numD04,
                  CommonColors.secondaryLightColor,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size(context).width * numD04,
                  vertical: size(context).width * numD01,
                ),
                margin: EdgeInsets.symmetric(vertical: size(context).width * numD02),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonImage(
                      imagePath: Assets.iconsIcCoin11,
                      height: size(context).width * numD045,
                      width: size(context).width * numD045,
                      color: Colors.black,
                      isNetwork: false,
                    ),
                    SizedBox(width: size(context).width * numD01),
                    CommonText(
                      text: "${context.watch<DashboardCubit>().userModel!.wallet?.coins}",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: size(context).width * numD035,
                    ),
                  ],
                ),
              ),
              SizedBox(width: size(context).width * numD04),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size(context).width * numD04),
                Row(
                  children: [
                    Expanded(
                      child: commonOutlinedButton(
                        onTap: () => _showTierBottomSheet(context, cubit),
                        radius: numD01,
                        borderColor: Colors.white.withOpacity(0.3),
                        buttonHeight: size(context).width * numD1,
                        size: size(context),
                        buttonText: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: "Tier: ${cubit.selectedTier}",
                              fontSize: size(context).width * numD03,
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: size(context).width * numD02),
                    Expanded(
                      child: commonOutlinedButton(
                        onTap: () => _showSortBottomSheet(context, cubit),
                        radius: numD01,
                        buttonHeight: size(context).width * numD1,
                        borderColor: Colors.white.withOpacity(0.3),
                        size: size(context),
                        buttonText: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: "Sort: ${cubit.selectedSort}",
                              fontSize: size(context).width * numD03,
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size(context).width * numD04),
                Expanded(
                  child: cubit.shopList.isEmpty
                      ? const Center(child: CommonText(text: "No items found"))
                      : CommonRefreshIndicator(
                          onRefresh: () async {
                            cubit.fetchShopItems(isRefresh: true);
                          },
                          onLoadMore: () async {
                            cubit.fetchShopItems(isRefresh: false);
                          },
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.shopList.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: size(context).width * numD02,
                              mainAxisSpacing: size(context).width * numD02,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, idx) {
                              final item = cubit.shopList[idx];
                              return InkWell(
                                onTap: () {
                                  router.push(
                                    AppRouter.itemDetailScreen,
                                    extra: {"cubit": cubit, "item": item},
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(size(context).width * numD03),
                                  child: Container(
                                    decoration: commonBgColorDecoration(
                                      size(context).width * numD03,
                                      CommonColors.themeDarkColor.withValues(alpha: 0.5),
                                    ),
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: CommonImage(
                                                imagePath:
                                                    (item.pictures != null &&
                                                        item.pictures!.isNotEmpty)
                                                    ? item.pictures![0].fullpath ?? ""
                                                    : Assets.iconsIcDummyBall1,
                                                width: size(context).width,
                                                isNetwork:
                                                    item.pictures != null &&
                                                    item.pictures!.isNotEmpty,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size(context).width * numD04,
                                              ),
                                              alignment: Alignment.centerLeft,
                                              child: CommonText(
                                                text: item.name ?? "",
                                                fontSize: size(context).width * numD04,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size(context).width * numD04,
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  item.owned == true
                                                      ? Icon(
                                                          Icons.check_circle_outline_outlined,
                                                          size: size(context).width * numD045,
                                                          color: CommonColors.secondaryColor,
                                                        )
                                                      : CommonImage(
                                                          imagePath: Assets.iconsIcCoin11,
                                                          height: size(context).width * numD045,
                                                          width: size(context).width * numD045,
                                                          color: CommonColors.secondaryColor,
                                                          isNetwork: false,
                                                        ),
                                                  SizedBox(width: size(context).width * numD01),
                                                  CommonText(
                                                    text: item.owned == true
                                                        ? "Owned"
                                                        : "${item.price?.value ?? 0}",
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonColors.secondaryColor,
                                                    fontSize: size(context).width * numD035,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: size(context).width * numD02),
                                            /*if (item.owned == true)
                                              Container(
                                                height: size(context).width * numD1,
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: size(context).width * numD04,
                                                ),
                                                alignment: Alignment.center,
                                                child: CommonGradientButton(
                                                  onTap: () {
                                                    cubit.callEquipItemApi(item.sId.toString(), item.type.toString());
                                                  },
                                                  text: "Equip",
                                                ),
                                              ),*/
                                            if (item.owned != true)
                                              Container(
                                                height: size(context).width * numD1,
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: size(context).width * numD04,
                                                ),
                                                alignment: Alignment.center,
                                                child: CommonButton(
                                                  onTap: () {
                                                    showPurchaseDialog(
                                                      cubit: cubit,
                                                      context: context,
                                                      heading: "Confirm Purchase",
                                                      subTitle: "You are about to purchase ",
                                                      item: item,
                                                    );
                                                  },
                                                  text: "Buy",
                                                ),
                                              ),
                                            SizedBox(height: size(context).width * numD02),
                                          ],
                                        ),
                                        Positioned(
                                          top: size(context).width * numD02,
                                          left: size(context).width * numD02,
                                          child: Container(
                                            decoration: commonBgColorDecoration(
                                              size(context).width * numD01,
                                              _getRarityColor(item.rarity),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: size(context).width * numD02,
                                              vertical: size(context).width * numD005,
                                            ),
                                            child: CommonText(
                                              text: (item.rarity ?? "").toUpperCase(),
                                              fontSize: size(context).width * numD03,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getRarityColor(String? rarity) {
    switch (rarity?.toLowerCase()) {
      case "normal":
        return Colors.grey;
      case "rare":
        return Colors.blue;
      case "epic":
        return Colors.purple;
      case "legendary":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _showTierBottomSheet(BuildContext context, ShopCubit cubit) {
    cubit.tempTier = cubit.selectedTier;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<ShopCubit, ShopState>(
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.all(size(context).width * numD06),
                decoration: commonWhiteDecorationTopOnly(size(context), numD08),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: "Select Tier",
                          color: Colors.black,
                          fontSize: size(context).width * numD055,
                          fontWeight: FontWeight.bold,
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: size(context).width * numD04),
                    _buildOptionList(
                      ["All", "Normal", "Rare", "Epic", "Legendary"],
                      cubit.tempTier,
                      (val) {
                        cubit.updateTempTier(val);
                      },
                    ),
                    SizedBox(height: size(context).width * numD06),
                    Row(
                      children: [
                        Expanded(
                          child: commonOutlinedButton(
                            onTap: () {
                              cubit.selectedTier = "All";
                              Navigator.pop(context);
                              cubit.fetchShopItems(isRefresh: true, rarity: "All");
                            },
                            size: size(context),
                            buttonText: const CommonText(text: "Clear", color: Colors.black),
                          ),
                        ),
                        SizedBox(width: size(context).width * numD04),
                        Expanded(
                          child: CommonGradientButton(
                            text: "Apply",
                            onTap: () {
                              cubit.selectedTier = cubit.tempTier;
                              Navigator.pop(context);
                              cubit.fetchShopItems(isRefresh: true, rarity: cubit.selectedTier);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size(context).width * numD04),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showSortBottomSheet(BuildContext context, ShopCubit cubit) {
    cubit.tempSort = cubit.selectedSort;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<ShopCubit, ShopState>(
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.all(size(context).width * numD06),
                decoration: commonWhiteDecorationTopOnly(size(context), numD08),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: "Sort By",
                          color: Colors.black,
                          fontSize: size(context).width * numD055,
                          fontWeight: FontWeight.bold,
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: size(context).width * numD04),
                    _buildOptionList(
                      ["Newest", "Price: Low to High", "Price: High to Low"],
                      cubit.tempSort,
                      (val) {
                        cubit.updateTempSort(val);
                      },
                    ),
                    SizedBox(height: size(context).width * numD06),
                    Row(
                      children: [
                        Expanded(
                          child: commonOutlinedButton(
                            onTap: () {
                              cubit.selectedSort = "Newest";
                              Navigator.pop(context);
                              cubit.fetchShopItems(isRefresh: true, sort: "desc");
                            },
                            size: size(context),
                            buttonText: const CommonText(text: "Clear", color: Colors.black),
                          ),
                        ),
                        SizedBox(width: size(context).width * numD04),
                        Expanded(
                          child: CommonGradientButton(
                            text: "Apply",
                            onTap: () {
                              cubit.selectedSort = cubit.tempSort;
                              Navigator.pop(context);
                              String priceSort = "";
                              String dateSort = "";
                              if (cubit.selectedSort == "Price: Low to High") priceSort = "asc";
                              if (cubit.selectedSort == "Price: High to Low") priceSort = "desc";
                              if (cubit.selectedSort == "Newest") dateSort = "desc";

                              cubit.fetchShopItems(
                                isRefresh: true,
                                sort: dateSort,
                                price: priceSort,
                                rarity: cubit.selectedTier,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size(context).width * numD04),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildOptionList(
    List<String> options,
    String currentSelection,
    Function(String) onSelect,
  ) {
    return Column(
      children: options.map((option) {
        final isSelected = option == currentSelection;
        return InkWell(
          onTap: () => onSelect(option),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: size(context).width * numD03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: option,
                  color: isSelected ? CommonColors.themeColor : Colors.black87,
                  fontSize: size(context).width * numD04,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                if (isSelected) Icon(Icons.check_circle, color: CommonColors.themeColor),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> showPurchaseDialog({
    required BuildContext context,
    required String heading,
    String? subTitle,
    required ShopItem item,
    required ShopCubit cubit,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: size(context).width * numD40,
                horizontal: size(context).width * numD05,
              ),
              padding: EdgeInsets.all(size(context).width * numD03),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size(context).width * numD06),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size(context).width * numD02),
                  CommonText(
                    text: heading,
                    fontSize: size(context).width * numD05,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  SizedBox(height: size(context).width * numD01),
                  CommonText(
                    textSpan: TextSpan(
                      text: subTitle,
                      style: TextStyle(color: Colors.grey, fontSize: size(context).width * numD035),
                      children: [
                        TextSpan(
                          text: item.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size(context).width * numD035,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size(context).width * numD04),
                  Container(
                    decoration: commonBgColorDecoration(
                      size(context).width * numD02,
                      CommonColors.themeColor.withValues(alpha: 0.1),
                    ),
                    padding: EdgeInsets.all(size(context).width * numD02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            CommonText(
                              text: "Current Balance",
                              color: Colors.grey,
                              fontSize: size(context).width * numD04,
                            ),
                            CommonText(
                              text: "${context.watch<DashboardCubit>().userModel!.wallet?.coins}",
                              color: CommonColors.buttonColor,
                              fontWeight: FontWeight.bold,
                              fontSize: size(context).width * numD04,
                            ),
                          ],
                        ),

                        SizedBox(height: size(context).width * numD02),

                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            CommonText(
                              text: "Item Cost",
                              color: Colors.grey,
                              fontSize: size(context).width * numD04,
                            ),
                            CommonText(
                              text: "-${item.price?.value}",
                              color: CommonColors.buttonColor,
                              fontWeight: FontWeight.bold,
                              fontSize: size(context).width * numD04,
                            ),
                          ],
                        ),

                        Divider(),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            CommonText(
                              text: "Remaining Balance",
                              color: CommonColors.buttonColor,
                              fontWeight: FontWeight.bold,
                              fontSize: size(context).width * numD04,
                            ),
                            CommonText(
                              text:
                                  "${getRemainingCoins(context.watch<DashboardCubit>().userModel?.wallet?.coins, item.price?.value)}",
                              color: CommonColors.buttonColor,
                              fontWeight: FontWeight.bold,
                              fontSize: size(context).width * numD04,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size(context).width * numD04),
                  Row(
                    children: [
                      Expanded(
                        child: CommonGradientButton(
                          text: "Cancel",
                          onTap: () {
                            router.pop();
                          },
                        ),
                      ),
                      SizedBox(width: size(context).width * numD04),
                      Expanded(
                        child: CommonButton(
                          text: "Confirm",
                          onTap: () {
                            router.pop();
                            cubit.callBuyProductApi(item.sId!, false);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size(context).width * numD02),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
