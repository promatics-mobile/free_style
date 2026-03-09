import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';
import 'package:free_style/utils/common_widgets/linear_progress_indicator/custom_linear_progress.dart';
import 'package:free_style/utils/common_widgets/text_form_field/common_text_form_field.dart';
import 'package:free_style/views/profile/profile_cubit.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_tab_bar/common_sliver_tab_bar.dart';
import '../../utils/common_widgets/common_tab_bar/common_tab_bar.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    var cubit = context.read<ProfileCubit>();
    return CommonSliverTabBar(
      tabs: const [
        "Battles",
        "Achievements",
        "Promotions",
        "History",
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipOval(
                  child: Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(size(context).width * numD005),
                    child: ClipOval(
                      child: Container(
                        color: CommonColors.themeColor,
                        padding: EdgeInsets.all(size(context).width * numD005),
                        child: ClipOval(
                          child: CommonImage(imagePath: Assets.assetsIcDummyUser1,
                            height: size(context).width * numD25,
                            width: size(context).width * numD25,
                            isNetwork: false,),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: commonBgColorDecoration(size(context).width * numD04, CommonColors.secondaryColor),
                    padding: EdgeInsets.symmetric(
                      horizontal: size(context).width * numD02,
                      vertical: size(context).width * numD005,
                    ),
                    child: CommonText(text:"Gold League",
                      fontWeight: FontWeight.bold,
                      fontSize: size(context).width * numD03,
                      color: Colors.black,),),
                )
              ],
            ),

            CommonText(text: "Jess Bailey",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD05,),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: size(context).width * numD012,
                  backgroundColor: Colors.red,
                ),
                CommonText(
                  text:
                  " Lvl 12 ${CommonSymbol.dotSymbol} Red Tier",
                  fontSize: size(context).width * numD03,
                  color: Colors.grey,
                ),
              ],
            ),

            SizedBox(height: size(context).width * numD01),
            commonShortButton(onTap: (){

              router.push(AppRouter.inventoryScreen);

            },
                buttonColor: CommonColors.secondaryColor,
                buttonHeight: size(context).width * numD07,
                size: size(context),
                textColor: Colors.black,
                buttonText: "Inventory"),

            SizedBox(height: size(context).width * numD05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CommonText(text: "17",
                      fontWeight: FontWeight.bold,
                      fontSize: size(context).width * numD04,),
                    CommonText(text: "TRICKS",
                      fontWeight: FontWeight.w400,
                      fontSize: size(context).width * numD035,),
                  ],
                ),
                Column(
                  children: [
                    CommonText(text: "158",
                      fontWeight: FontWeight.bold,
                      fontSize: size(context).width * numD04,),
                    CommonText(text: "CHALLENGES",
                      fontWeight: FontWeight.w400,
                      fontSize: size(context).width * numD035,),
                  ],
                ),
                Column(

                  children: [
                    CommonText(text: "85",
                      fontWeight: FontWeight.bold,
                      fontSize: size(context).width * numD04,),
                    CommonText(text: "BATTLES",
                      fontWeight: FontWeight.w400,
                      fontSize: size(context).width * numD035,),
                  ],
                ),
              ],
            ),
            SizedBox(height: size(context).width * numD05),
            Container(
                decoration: commonBgColorDecoration(size(context).width * numD04, CommonColors.secondaryColor),
                padding: EdgeInsets.all(size(context).width * numD04),
                width:  size(context).width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        CommonText(text: "Level Progress",
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: size(context).width * numD035,),
                        CommonText(text: "1,250/2,000 XP",
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: size(context).width * numD035,),
                      ],
                    ),
                    SizedBox(height: size(context).width * numD02),
                    commonNormalLinearProgress(context: context, value: 0.4, bgColor:
                    Colors.white, valueColor: CommonColors.buttonColor),
                    SizedBox(height: size(context).width * numD04),
                    Container(
                      decoration: commonBgColorDecoration(size(context).width * numD03, Colors.black),
                      padding: EdgeInsets.all(size(context).width * numD02,),
                      child: Row(
                        children: [
                          Container(
                              decoration: commonCircularFill(color: Colors.white),
                              padding: EdgeInsets.all(size(context).width * numD01),
                              child: Icon(Icons.electric_bolt,color: CommonColors.secondaryColor,)),
                          SizedBox(width:  size(context).width * numD02,),
                          CommonText(text: "340 XP Available",),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_right_outlined,
                            color: Colors.white,)

                        ],
                      ),
                    )


                  ],
                )
            ),
            SizedBox(height: size(context).width * numD05),
          ],
        ),
      ),
      onTap: (value){
        cubit.onChangeTab(value);
      },
      onChanged: (value){
        cubit.onChangeTab(value);
      },
      views: [
        battleWidget(context,cubit),
        battleWidget(context,cubit),
        battleWidget(context,cubit),
        battleWidget(context,cubit),
      ],
    );
  },
);
  }

  Widget battleWidget(BuildContext context, ProfileCubit cubit) {
  return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      padding: EdgeInsets.only(top: size(context).width * numD02),
      itemBuilder: (context,idx){
    return Container(
      decoration: commonBgColorDecoration(size(context).width * numD04, Colors.white),
      padding: EdgeInsets.all(size(context).width * numD04),
      margin: EdgeInsets.symmetric(vertical: size(context).width * numD01),

      child: Row(
        children: [
          CircleAvatar(
              backgroundColor: CommonColors.secondaryLightColor,
              radius: size(context).width *numD05,
              child: CommonImage(imagePath:
              cubit.selectedTabIndex == 0 ?
              Assets.iconsIcBattle :
              cubit.selectedTabIndex == 1 ?
              Assets.iconsIcTrophy :
              cubit.selectedTabIndex == 2 ?
              Assets.iconsIcBadge : Assets.iconsIcHistory,
                width: size(context).width * numD05,
                height: size(context).width * numD05,
                color: Colors.black,
                isNetwork: false,)),
          SizedBox(width: size(context).width * numD02,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(text:"Lorem ipsum lorem title",
                color: Colors.black,
                fontSize: size(context).width * numD035,),
              CommonText(text:"Unlocked on Oct 12 2025",
                color: Colors.grey,
                fontSize: size(context).width * numD03,),
            ],
          ),
        ],
      ),

    );

  });

  }


}
