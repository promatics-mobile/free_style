import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String selectedTier = "All";
  String selectedSort = "Price";
  int selectedCategoryIndex = 0;
  final List<String> categories = ["Balls", "Outfit"];

  @override
  Widget build(BuildContext context) {
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
                  text: "1250",
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
            SizedBox(
              height: size(context).width * numD09,
              width: size(context).width,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, idx) {
                  final isSelected = selectedCategoryIndex == idx;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = idx;
                      });
                    },
                    child: Container(
                      decoration: commonBgColorDecoration(
                        size(context).width * numD05,
                        isSelected
                            ? CommonColors.secondaryColor
                            : CommonColors.themeDarkColor,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: size(context).width * numD04,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: size(context).width * numD02,
                      ),
                      alignment: Alignment.center,
                      child: CommonText(
                        text: categories[idx],
                        color: isSelected ? Colors.black : Colors.white,
                        fontSize: size(context).width * numD035,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: size(context).width * numD04),
            Row(
              children: [
                Expanded(
                  child: commonOutlinedButton(
                    onTap: () => _showTierBottomSheet(context),
                    radius: numD01,
                    borderColor: Colors.white.withOpacity(0.3),
                    buttonHeight: size(context).width * numD1,
                    size: size(context),
                    buttonText: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: "Tier: $selectedTier",
                          fontSize: size(context).width * numD03,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: size(context).width * numD02),
                Expanded(
                  child: commonOutlinedButton(
                    onTap: () => _showSortBottomSheet(context),
                    radius: numD01,
                    buttonHeight: size(context).width * numD1,
                    borderColor: Colors.white.withOpacity(0.3),
                    size: size(context),
                    buttonText: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: "Sort: $selectedSort",
                          fontSize: size(context).width * numD03,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size(context).width * numD04),
            Expanded(
              child: GridView.builder(
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: size(context).width * numD02,
                  mainAxisSpacing: size(context).width * numD02,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, idx) {
                  return InkWell(
                    onTap: () {
                      router.push(AppRouter.itemDetailScreen);
                    },
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(size(context).width * numD03),
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
                                    imagePath: idx.isEven
                                        ? Assets.iconsIcDummyBall1
                                        : Assets.iconsIsDummyBall2,
                                    width: size(context).width,
                                    isNetwork: false,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size(context).width * numD04,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: CommonText(
                                    text: "Classic Sphere",
                                    fontSize: size(context).width * numD04,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size(context).width * numD04,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      idx == 0
                                          ? Icon(
                                        Icons
                                            .check_circle_outline_outlined,
                                        size:
                                        size(context).width * numD045,
                                        color:
                                        CommonColors.secondaryColor,
                                      )
                                          : CommonImage(
                                        imagePath: Assets.iconsIcCoin11,
                                        height:
                                        size(context).width * numD045,
                                        width:
                                        size(context).width * numD045,
                                        color:
                                        CommonColors.secondaryColor,
                                        isNetwork: false,
                                      ),
                                      SizedBox(
                                          width: size(context).width * numD01),
                                      CommonText(
                                        text: idx == 0 ? "Owned" : "800",
                                        fontWeight: FontWeight.bold,
                                        color: CommonColors.secondaryColor,
                                        fontSize: size(context).width * numD035,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: size(context).width * numD02),
                                if (idx == 0)
                                  Container(
                                    height: size(context).width * numD1,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: size(context).width * numD04,
                                    ),
                                    alignment: Alignment.center,
                                    child: CommonGradientButton(
                                      onTap: () {},
                                      text: "Equipped",
                                    ),
                                  ),
                                if (idx != 0)
                                  Container(
                                    height: size(context).width * numD1,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: size(context).width * numD04,
                                    ),
                                    alignment: Alignment.center,
                                    child: CommonButton(
                                        onTap: () {
                                          router
                                              .push(AppRouter.itemDetailScreen);
                                        },
                                        text: "Buy"),
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
                                  idx == 3 ? Colors.grey : Colors.deepOrange,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: size(context).width * numD02,
                                  vertical: size(context).width * numD005,
                                ),
                                child: CommonText(
                                  text: idx == 3 ? "SILVER+" : "BRONZE+",
                                  fontSize: size(context).width * numD03,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            if (idx == 1)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: CommonColors.secondaryColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                        size(context).width * numD01,
                                      ),
                                      bottomLeft: Radius.circular(
                                        size(context).width * numD01,
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size(context).width * numD02,
                                    vertical: size(context).width * numD005,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    size: size(context).width * numD04,
                                    color: Colors.black,
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
          ],
        ),
      ),
    );
  }

  void _showTierBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
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
                  ["All", "Bronze", "Silver", "Gold", "Platinum"],
                  selectedTier,
                      (val) {
                    setModalState(() => selectedTier = val);
                    setState(() {});
                  },
                ),
                SizedBox(height: size(context).width * numD06),
                CommonGradientButton(
                  text: "Apply",
                  onTap: () => Navigator.pop(context),
                ),
                SizedBox(height: size(context).width * numD04),
              ],
            ),
          );
        });
      },
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
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
                  ["Newest", "Price: Low to High", "Price: High to Low", "Popularity"],
                  selectedSort,
                      (val) {
                    setModalState(() => selectedSort = val);
                    setState(() {});
                  },
                ),
                SizedBox(height: size(context).width * numD06),
                CommonGradientButton(
                  text: "Apply",
                  onTap: () => Navigator.pop(context),
                ),
                SizedBox(height: size(context).width * numD04),
              ],
            ),
          );
        });
      },
    );
  }

  Widget _buildOptionList(List<String> options, String currentSelection,
      Function(String) onSelect) {
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
                if (isSelected)
                  Icon(Icons.check_circle, color: CommonColors.themeColor),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}








/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';
import 'package:free_style/views/shop/shop_cubit.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int selectedCategoryIndex = 0;
  final List<String> categories = ["Balls", "Outfit"];

  @override
  void initState() {
    super.initState();
    context.read<ShopCubit>().fetchShopItems();
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
                      text: "1250",
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
                SizedBox(
                  height: size(context).width * numD09,
                  width: size(context).width,
                  child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, idx) {
                      final isSelected = selectedCategoryIndex == idx;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedCategoryIndex = idx;
                          });
                        },
                        child: Container(
                          decoration: commonBgColorDecoration(
                            size(context).width * numD05,
                            isSelected
                                ? CommonColors.secondaryColor
                                : CommonColors.themeDarkColor,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: size(context).width * numD04,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: size(context).width * numD02,
                          ),
                          alignment: Alignment.center,
                          child: CommonText(
                            text: categories[idx],
                            color: isSelected ? Colors.black : Colors.white,
                            fontSize: size(context).width * numD035,
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white,
                            ),
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
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white,
                            ),
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
                      : GridView.builder(
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
                                router.push(AppRouter.itemDetailScreen);
                              },
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(size(context).width * numD03),
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
                                              imagePath: (item.pictures != null &&
                                                      item.pictures!.isNotEmpty)
                                                  ? item.pictures![0].fullpath ?? ""
                                                  : Assets.iconsIcDummyBall1,
                                              width: size(context).width,
                                              isNetwork: item.pictures != null &&
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                item.owned == true
                                                    ? Icon(
                                                        Icons
                                                            .check_circle_outline_outlined,
                                                        size: size(context).width *
                                                            numD045,
                                                        color: CommonColors
                                                            .secondaryColor,
                                                      )
                                                    : CommonImage(
                                                        imagePath: Assets.iconsIcCoin11,
                                                        height: size(context).width *
                                                            numD045,
                                                        width: size(context).width *
                                                            numD045,
                                                        color: CommonColors
                                                            .secondaryColor,
                                                        isNetwork: false,
                                                      ),
                                                SizedBox(
                                                    width: size(context).width *
                                                        numD01),
                                                CommonText(
                                                  text: item.owned == true
                                                      ? "Owned"
                                                      : "${item.price?.value ?? 0}",
                                                  fontWeight: FontWeight.bold,
                                                  color: CommonColors.secondaryColor,
                                                  fontSize: size(context).width *
                                                      numD035,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                              height: size(context).width * numD02),
                                          if (item.owned == true)
                                            Container(
                                              height: size(context).width * numD1,
                                              margin: EdgeInsets.symmetric(
                                                horizontal: size(context).width *
                                                    numD04,
                                              ),
                                              alignment: Alignment.center,
                                              child: CommonGradientButton(
                                                onTap: () {},
                                                text: "Equipped",
                                              ),
                                            ),
                                          if (item.owned != true)
                                            Container(
                                              height: size(context).width * numD1,
                                              margin: EdgeInsets.symmetric(
                                                horizontal: size(context).width *
                                                    numD04,
                                              ),
                                              alignment: Alignment.center,
                                              child: CommonButton(
                                                  onTap: () {
                                                    router.push(
                                                        AppRouter.itemDetailScreen);
                                                  },
                                                  text: "Buy"),
                                            ),
                                          SizedBox(
                                              height: size(context).width * numD02),
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
                                            horizontal:
                                                size(context).width * numD02,
                                            vertical:
                                                size(context).width * numD005,
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
                          child: CommonGradientButton(
                            onTap: () {
                              cubit.selectedTier = "All";
                              Navigator.pop(context);
                              cubit.fetchShopItems(rarity: "All");
                            },
                            text:  "Clear",),

                        ),
                        SizedBox(width: size(context).width * numD04),
                        Expanded(
                          child: CommonButton(
                            text: "Apply",
                            onTap: () {
                              cubit.selectedTier = cubit.tempTier;
                              Navigator.pop(context);
                              cubit.fetchShopItems(rarity: cubit.selectedTier);
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
                          child: CommonGradientButton(
                            onTap: () {
                              cubit.selectedSort = "Newest";
                              Navigator.pop(context);
                              cubit.fetchShopItems(sort: "desc");
                            },
                            text: "Clear"),
                        ),
                        SizedBox(width: size(context).width * numD04),
                        Expanded(
                          child: CommonButton(
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
                                  sort: dateSort,
                                  price: priceSort,
                                  rarity: cubit.selectedTier);
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

  Widget _buildOptionList(List<String> options, String currentSelection,
      Function(String) onSelect) {
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
                if (isSelected)
                  Icon(Icons.check_circle, color: CommonColors.themeColor),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
*/
