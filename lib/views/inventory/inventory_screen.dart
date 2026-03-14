import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/views/inventory/inventory_cubit.dart';

import '../../generated/assets.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_refresh_indicator/common_refresh_indicator.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InventoryCubit>().fetchInventoryItems(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Inventory"),
      body: BlocBuilder<InventoryCubit, InventoryState>(
        builder: (context, state) {
          var cubit = context.read<InventoryCubit>();
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                CommonText(
                  text: "Category",
                  fontSize: size(context).width * numD04,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: size(context).width * numD01),
                SizedBox(
                  height: size(context).width * numD09,
                  width: size(context).width,
                  child: ListView.builder(
                    itemCount: cubit.freePremiumList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, idx) {
                      var item = cubit.freePremiumList[idx];
                      return InkWell(
                        onTap: () {
                          cubit.onSelectFreePremium(idx);
                        },
                        child: Container(
                          decoration: commonBgColorDecoration(
                            size(context).width * numD05,
                            item.isSelected
                                ? CommonColors.secondaryColor
                                : CommonColors.themeDarkColor,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
                          margin: EdgeInsets.symmetric(horizontal: size(context).width * numD02),
                          alignment: Alignment.center,
                          child: CommonText(
                            text: item.title,
                            color: item.isSelected ? Colors.black : Colors.white,
                            fontSize: size(context).width * numD035,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: size(context).width * numD02),
                CommonText(
                  text: "Type",
                  fontSize: size(context).width * numD04,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: size(context).width * numD01),
                SizedBox(
                  height: size(context).width * numD09,
                  width: size(context).width,
                  child: ListView.builder(
                    itemCount: cubit.ballAvatarList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, idx) {
                      var item = cubit.ballAvatarList[idx];
                      return InkWell(
                        onTap: () {
                          cubit.onSelectBallsAvatar(idx);
                        },
                        child: Container(
                          decoration: commonBgColorDecoration(
                            size(context).width * numD05,
                            item.isSelected
                                ? CommonColors.secondaryColor
                                : CommonColors.themeDarkColor,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
                          margin: EdgeInsets.symmetric(horizontal: size(context).width * numD02),
                          alignment: Alignment.center,
                          child: CommonText(
                            text: item.title,
                            color: item.isSelected ? Colors.black : Colors.white,
                            fontSize: size(context).width * numD035,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: size(context).width * numD04),
                Expanded(
                  child: cubit.inventoryList.isEmpty
                      ? const Center(child: CommonText(text: "No items found"))
                      : CommonRefreshIndicator(
                          onRefresh: () async {
                            cubit.fetchInventoryItems(isRefresh: true);
                          },
                          onLoadMore: () async {
                            cubit.fetchInventoryItems(isRefresh: false);
                          },
                          child: GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: size(context).width * numD04),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.inventoryList.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: size(context).width * numD02,
                              mainAxisSpacing: size(context).width * numD02,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, idx) {
                              final item = cubit.inventoryList[idx];
                              return ClipRRect(
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


                                          if (!(item.isFree??false))
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size(context).width * numD04,
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CommonImage(
                                                          imagePath: Assets.iconsIcCoin11,
                                                          height: size(context).width * numD045,
                                                          width: size(context).width * numD045,
                                                          color: CommonColors.secondaryColor,
                                                          isNetwork: false,
                                                        ),
                                                  SizedBox(width: size(context).width * numD01),
                                                  CommonText(
                                                    text: "${item.price?.value ?? 0}",
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonColors.secondaryColor,
                                                    fontSize: size(context).width * numD035,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          SizedBox(height: size(context).width * numD02),

                                          Container(
                                            height: size(context).width * numD1,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: size(context).width * numD04,
                                            ),
                                            alignment: Alignment.center,
                                            child: CommonGradientButton(
                                              onTap: () {
                                                cubit.callEquipItemApi(item.sId ?? "",);
                                              },
                                              text: "Equip",
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
                              );
                            },
                          ),
                        ),
                ),

              ],
            ),
          );
        },
      ),
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
}
