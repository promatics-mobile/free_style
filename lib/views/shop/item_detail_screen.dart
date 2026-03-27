import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/routes/route.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/views/shop/shop_cubit.dart';
import 'package:free_style/views/shop/shop_model.dart';

import '../../generated/assets.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_methods.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_button/common_gradient_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import '../dashboard/dashboard_cubit.dart';

class ItemDetailScreen extends StatelessWidget {
  ShopCubit cubit;
  ShopItem item;

  ItemDetailScreen({super.key, required this.cubit,required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: CommonAppBar(title: "Item Details"),
        body: BlocBuilder<ShopCubit, ShopState>(
          builder: (context, state) {
            var cubit = context.read<ShopCubit>();
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        size(context).width * numD03),

                    child: Container(
                      color: CommonColors.themeDarkColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                      size(context).width * numD03,
                                    ),
                                    topLeft: Radius.circular(
                                      size(context).width * numD03,
                                    ),
                                  ),
                                ),
                                child: CommonImage(
                                  imagePath: item.pictures!.first.fullpath!,
                                  width: size(context).width,
                                  height: size(context).width,
                                  isNetwork: true,
                                ),
                              ),
                              if(item.owned??false)
                              Positioned(
                                top: size(context).width * numD02,
                                right: size(context).width * numD02,
                                child: Container(
                                  decoration: commonBgColorDecoration(
                                    size(context).width * numD01, CommonColors.buttonColor,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size(context).width * numD02,
                                    vertical: size(context).width * numD01,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.check_circle_outline_outlined,
                                        size: size(context).width * numD04,
                                        color: Colors.white,),
                                      SizedBox(width: size(context).width * numD01),
                                      CommonText(
                                        text:"OWNED" ,
                                        fontSize: size(context).width * numD03,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: size(context).width * numD04),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: item.type.toString().toUpperCase(),
                                  color: CommonColors.secondaryLightColor,
                                  fontSize: size(context).width * numD04,
                                ),
                                SizedBox(height: size(context).width * numD02),
                                CommonText(
                                  text: item.name,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size(context).width * numD06,
                                ),
                                SizedBox(height: size(context).width * numD02),

                                CommonText(
                                  text: item.description,
                                  color: Colors.white,
                                  fontSize: size(context).width * numD035,
                                ),

                                SizedBox(height: size(context).width * numD04),

                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size(context).width * numD04),
                  Container(
                    decoration: commonBgColorDecoration(
                        size(context).width * numD03, CommonColors.themeDarkColor),
                    padding: EdgeInsets.all(size(context).width * numD04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              CommonText(
                                text: "Rarity",
                                color: Colors.white,
                                fontSize: size(context).width * numD04,
                              ), CommonText(
                                text: item.rarity.toString().toCapitalize(),
                                color: CommonColors.secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: size(context).width * numD04,
                              ),
                            ]

                        ),
                        SizedBox(height: size(context).width * numD02),
                        Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              CommonText(
                                text: "Collection",
                                color: Colors.white,
                                fontSize: size(context).width * numD04,
                              ), CommonText(
                                text:
                                item.collection!.isEmpty ?  "-" :
                                item.collection.toString().toCapitalize(),
                                color: CommonColors.secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: size(context).width * numD04,
                              ),
                            ]

                        ),
                        SizedBox(height: size(context).width * numD02),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            CommonText(
                              text: "Coins",
                              color: Colors.white,
                              fontSize: size(context).width * numD04,
                            ),
                            Spacer(),
                            CommonImage(
                              imagePath: Assets.iconsIcCoin11,
                              height: size(context).width * numD045,
                              width: size(context).width * numD045,
                              color: CommonColors.secondaryColor,
                              isNetwork: false,
                            ),
                            SizedBox(width: size(context).width * numD01),
                            CommonText(
                              text:"${item.price?.value ?? 0}",
                              fontWeight: FontWeight.bold,
                              color: CommonColors.secondaryColor,
                              fontSize: size(context).width * numD035,
                            ),
                          ],
                        ),
                        SizedBox(height: size(context).width * numD02),

                      /*  Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              CommonText(
                                text: "Acquired",
                                color: Colors.white,
                                fontSize: size(context).width * numD04,
                              ), CommonText(
                                text: "Oct 12, 2025",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: size(context).width * numD04,
                              ),
                            ]
                        ),*/
                      ],
                    ),
                  ),
                  SizedBox(height: size(context).width * numD04),


                  if(!(item.owned??false))
                  CommonButton(onTap: () {
                    showPurchaseDialog(
                      cubit: cubit,
                      context: context,
                      heading: "Confirm Purchase",
                      subTitle: "You are about to purchase ",
                      item: item,
                    );
                  }, text: "Buy"),

                  SizedBox(height: size(context).width * numD1),

                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> showPurchaseDialog({
    required BuildContext context,
    required String heading,
    String? subTitle,
    required ShopItem item,
    required ShopCubit cubit,
  })
  async {
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
                            cubit.callBuyProductApi(item.sId!, true);
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
