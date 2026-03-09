import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/generated/assets.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';
import 'package:free_style/utils/common_widgets/common_tab_bar/common_tab_bar.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/views/skill_tree/skill_tree_cubit.dart';
import 'package:universal_stepper/universal_stepper.dart';

import '../../utils/common_widgets/common_image/common_image.dart';

class SkillTreeScreen extends StatelessWidget {
  const SkillTreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkillTreeCubit, SkillTreeState>(
      builder: (context, state) {
        var cubit = context.read<SkillTreeCubit>();
        return Scaffold(
          appBar: CommonAppBar(title: "Skill Tree", actions: []),
          body: CommonTabBar(
            tabs: ["Lower", "Upper", "Ground", "Sit Down"],
            views: [
              lowerWidget(context, cubit),
              upperWidget(context, cubit),
              groundWidget(context, cubit),
              sitDownWidget(context, cubit),
            ],
            isScrollable: true,
            onTap: (index) {
              debugPrint("onTap Index: $index");
              cubit.onChangeSkillTab(index);
            },
            onChanged: (index) {
              debugPrint("onChanged Index: $index");
              cubit.onChangeSkillTab(index);
            },
          ),
        );
      },
    );
  }

  Widget lowerWidget(BuildContext context, SkillTreeCubit cubit) {
    return Padding(
      padding: EdgeInsetsGeometry.all(size(context).width * numD04),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          UniversalStepper(
            inverted: false,
            stepperDirection: Axis.vertical,
            elementBuilder: (context, index) {
              var item = cubit.lowerStepData[index];
              return Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: size(context).width * numD04),
                  alignment: Alignment.topLeft,
                  child: CommonText(
                    text: item.title,
                    fontSize: size(context).width * numD04,
                  ),
                ),
              );
            },
            badgeBuilder: (context, index) {
              var item = cubit.lowerStepData[index];
              return Container(
                width: size(context).width * numD09,
                padding: EdgeInsets.all(size(context).width * numD02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(size(context).width * numD07),
                  ),
                ),
                child: FittedBox(
                  child: CommonImage(
                    imagePath: item.icon ?? "",
                    isNetwork: false,
                    color: Colors.black,
                  ),
                ),
              );
            },
            pathBuilder: (context, index) {
              return Container(
                color: index == cubit.lowerStepData.length - 1
                    ? Colors.transparent
                    : (index < cubit.currentStep
                          ? CommonColors.secondaryColor
                          : Colors.white),
                width: size(context).width * numD01,
                height: size(context).width * numD1,
              );
            },
            subPathBuilder: (context, index) {
              return Container(
                color: index == cubit.lowerStepData.length - 1
                    ? Colors.transparent
                    : (index < cubit.currentStep
                          ? CommonColors.secondaryColor
                          : Colors.white),
                width: size(context).width * numD01,
                height: size(context).width * numD1,
              );
            },
            elementCount: cubit.lowerStepData.length,
            badgePosition: StepperBadgePosition.start,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    CommonText(
                      text: "Around the World",
                      fontSize: size(context).width * numD05,
                      fontWeight: FontWeight.bold,
                    ),
                    CommonText(
                      text: "Lower branch b7 Tier 2",
                      fontSize: size(context).width * numD035,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size(context).width * numD02,
                  vertical: size(context).width * numD01,
                ),

                decoration: commonBgColorDecoration(
                  size(context).width * numD04,
                  CommonColors.secondaryColor,
                ),
                child: CommonText(
                  text: "Intermediate",
                  fontSize: size(context).width * numD035,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: size(context).width * numD04),

          CommonText(
            text:
                "A classic freestyle move where the ball travels in a full circle around your before you regain control.",
            fontSize: size(context).width * numD035,
            color: Colors.grey,
          ),
          SizedBox(height: size(context).width * numD04),
          Row(
            children: [
              Icon(
                Icons.check_circle_outline_outlined,
                color: CommonColors.secondaryColor,
              ),

              Expanded(
                child: CommonText(
                  text: "Crossover control (Completed)",
                  fontSize: size(context).width * numD04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: size(context).width * numD01),
          Row(
            children: [
              Icon(
                Icons.check_circle_outline_outlined,
                color: CommonColors.secondaryColor,
              ),
              Expanded(
                child: CommonText(
                  text: "Player Level 5+",
                  fontSize: size(context).width * numD04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: size(context).width * numD01),
          Row(
            children: [
              Icon(
                Icons.check_circle_outline_outlined,
                color: CommonColors.secondaryColor,
              ),
              Expanded(
                child: CommonText(
                  text: "150 SP available to unlock",
                  fontSize: size(context).width * numD04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: size(context).width * numD1),

          if (cubit.currentTabIndex == 0)
            CommonButton(onTap: () {}, text: "Start Tutorial"),
        ],
      ),
    );
  }

  Widget upperWidget(BuildContext context, SkillTreeCubit cubit) {
    return Padding(
      padding: EdgeInsetsGeometry.all(size(context).width * numD04),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          UniversalStepper(
            inverted: false,
            stepperDirection: Axis.vertical,
            elementBuilder: (context, index) {
              var item = cubit.upperStepData[index];
              return Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: size(context).width * numD04),
                  alignment: Alignment.topLeft,
                  child: CommonText(
                    text: item.title,
                    fontSize: size(context).width * numD04,
                  ),
                ),
              );
            },
            badgeBuilder: (context, index) {
              var item = cubit.upperStepData[index];
              return Container(
                width: size(context).width * numD09,
                padding: EdgeInsets.all(size(context).width * numD02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(size(context).width * numD07),
                  ),
                ),
                child: FittedBox(
                  child: CommonImage(
                    imagePath: item.icon ?? "",
                    isNetwork: false,
                    color: Colors.black,
                  ),
                ),
              );
            },
            pathBuilder: (context, index) {
              return Container(
                color: index == cubit.upperStepData.length - 1
                    ? Colors.transparent
                    : (index < cubit.currentStep
                          ? CommonColors.secondaryColor
                          : Colors.white),
                width: size(context).width * numD01,
                height: size(context).width * numD1,
              );
            },
            subPathBuilder: (context, index) {
              return Container(
                color: index == cubit.upperStepData.length - 1
                    ? Colors.transparent
                    : (index < cubit.currentStep
                          ? CommonColors.secondaryColor
                          : Colors.white),
                width: size(context).width * numD01,
                height: size(context).width * numD1,
              );
            },
            elementCount: cubit.upperStepData.length,
            badgePosition: StepperBadgePosition.start,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    CommonText(
                      text: "360 Spin",
                      fontSize: size(context).width * numD05,
                      fontWeight: FontWeight.bold,
                    ),
                    CommonText(
                      text: "Rotation Master 1",
                      fontSize: size(context).width * numD035,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size(context).width * numD02,
                  vertical: size(context).width * numD01,
                ),

                decoration: commonBgColorDecoration(
                  size(context).width * numD04,
                  CommonColors.secondaryColor,
                ),
                child: CommonText(
                  text: "Unlocked",
                  fontSize: size(context).width * numD035,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: size(context).width * numD04),


          SizedBox(height: size(context).width * numD04),
          Row(
            crossAxisAlignment: .start,
            children: [
              CommonImage(imagePath: Assets.iconsIcMission, isNetwork: false,
                height: size(context).width * numD05,
                width: size(context).width * numD05,
                color: CommonColors.secondaryColor,
              ),

              SizedBox(width: size(context).width * numD02,),


              Expanded(
                child: CommonText(
                  text: "Mission: Perform 3 clean 360 spins. consecutively without dropping the bal",
                  fontSize: size(context).width * numD04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: size(context).width * numD02),
          Row(
            crossAxisAlignment: .start,
            children: [
              CommonImage(imagePath: Assets.iconsIcVideoRecord, isNetwork: false,
                height: size(context).width * numD05,
                width: size(context).width * numD05,
                color: CommonColors.secondaryColor,
              ),
              SizedBox(width: size(context).width * numD02,),
              Expanded(
                child: CommonText(
                  text: "Proof: Record a video clearly showing your face and the ball throughout the trick.",
                  fontSize: size(context).width * numD04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: size(context).width * numD1),
        ],
      ),
    );
  }

  Widget groundWidget(BuildContext context, SkillTreeCubit cubit) {
    return SingleChildScrollView(
      padding: EdgeInsetsGeometry.all(size(context).width * numD04),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          UniversalStepper(
            inverted: false,
            stepperDirection: Axis.vertical,
            elementBuilder: (context, index) {
              var item = cubit.groundStepData[index];
              return Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: size(context).width * numD04),
                  alignment: Alignment.topLeft,
                  child: CommonText(
                    text: item.title,
                    fontSize: size(context).width * numD04,
                  ),
                ),
              );
            },
            badgeBuilder: (context, index) {
              var item = cubit.groundStepData[index];
              return Container(
                width: size(context).width * numD09,
                padding: EdgeInsets.all(size(context).width * numD02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(size(context).width * numD07),
                  ),
                ),
                child: FittedBox(
                  child: CommonImage(
                    imagePath: item.icon ?? "",
                    isNetwork: false,
                    color: Colors.black,
                  ),
                ),
              );
            },
            pathBuilder: (context, index) {
              return Container(
                color: index == cubit.groundStepData.length - 1
                    ? Colors.transparent
                    : (index < cubit.currentStep
                          ? CommonColors.secondaryColor
                          : Colors.white),
                width: size(context).width * numD01,
                height: size(context).width * numD1,
              );
            },
            subPathBuilder: (context, index) {
              return Container(
                color: index == cubit.groundStepData.length - 1
                    ? Colors.transparent
                    : (index < cubit.currentStep
                          ? CommonColors.secondaryColor
                          : Colors.white),
                width: size(context).width * numD01,
                height: size(context).width * numD1,
              );
            },
            elementCount: cubit.groundStepData.length,
            badgePosition: StepperBadgePosition.start,
          ),


          Visibility(
              visible: !cubit.showGroundUnlock,
              replacement: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: commonOutlineDecoration(size(context).width * numD02,
                    1, Colors.white),
                padding: EdgeInsets.all(size(context).width * numD02),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              CommonText(text:"Basic Dribble",
                                fontSize: size(context).width * numD04,
                                fontWeight: FontWeight.bold,
                              ),
                              CommonText(text:"Ground   Tier 2",
                                color: Colors.grey,
                                fontSize: size(context).width * numD03,),
                            ],
                          ),
                        ),
                        SizedBox(width: size(context).width * numD02,),
                        Container(
                          decoration: commonBgColorDecoration(size(context).width * numD03, CommonColors.secondaryColor),
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: size(context).width * numD01,
                            horizontal: size(context).width * numD02,
                          ),
                          child: CommonText(text:"5 Coins",
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: size(context).width * numD03,),
                        ),


                      ],
                    ),
                    SizedBox(height:  size(context).width * numD02),
                    CommonText(text:"Master the fundamental ground control. Required for advanced combos.",
                      color: Colors.white,
                      fontSize: size(context).width * numD035,),
                    SizedBox(height:  size(context).width * numD02),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Expanded(child: CommonGradientButton(text: "Mark watched", onTap: (){})),
                        SizedBox(width:  size(context).width * numD05),
                        Expanded(child: CommonButton(text: "Go to mission", onTap: (){})),

                      ],)

                  ],
                ),
              ),
            ],
          ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        CommonText(
                          text: "Leg Circle",
                          fontSize: size(context).width * numD05,
                          fontWeight: FontWeight.bold,
                        ),
                        CommonText(
                          text: "Ground Control 2",
                          fontSize: size(context).width * numD035,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      cubit.onTapGroundUnlock();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size(context).width * numD02,
                        vertical: size(context).width * numD01,
                      ),

                      decoration: commonBgColorDecoration(
                        size(context).width * numD04,
                        CommonColors.secondaryColor,
                      ),
                      child: CommonText(
                        text: cubit.showGroundUnlock ? "Locked": "Unlocked",
                        fontSize: size(context).width * numD035,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size(context).width * numD04),
              Row(
                crossAxisAlignment: .start,
                children: [
                  CommonImage(imagePath: Assets.iconsIcMission, isNetwork: false,
                    height: size(context).width * numD05,
                    width: size(context).width * numD05,
                    color: CommonColors.secondaryColor,
                  ),

                  SizedBox(width: size(context).width * numD02,),


                  Expanded(
                    child: CommonText(
                      text: "Mission: Perform 3 clean 360 spins. consecutively without dropping the bal",
                      fontSize: size(context).width * numD04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size(context).width * numD02),
              Row(
                crossAxisAlignment: .start,
                children: [
                  CommonImage(imagePath: Assets.iconsIcVideoRecord, isNetwork: false,
                    height: size(context).width * numD05,
                    width: size(context).width * numD05,
                    color: CommonColors.secondaryColor,
                  ),
                  SizedBox(width: size(context).width * numD02,),
                  Expanded(
                    child: CommonText(
                      text: "Proof: Record a video clearly showing your face and the ball throughout the trick.",
                      fontSize: size(context).width * numD04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ),






          SizedBox(height: size(context).width * numD1),

        ],
      ),
    );
  }

  Widget sitDownWidget(BuildContext context, SkillTreeCubit cubit) {
    return Padding(
      padding: EdgeInsetsGeometry.all(size(context).width * numD04),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          UniversalStepper(
            inverted: false,
            stepperDirection: Axis.vertical,
            elementBuilder: (context, index) {
              var item = cubit.sitDownStepData[index];
              return Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: size(context).width * numD04),
                  alignment: Alignment.topLeft,
                  child: CommonText(
                    text: item.title,
                    fontSize: size(context).width * numD04,
                  ),
                ),
              );
            },
            badgeBuilder: (context, index) {
              var item = cubit.sitDownStepData[index];
              return Container(
                width: size(context).width * numD09,
                padding: EdgeInsets.all(size(context).width * numD02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(size(context).width * numD07),
                  ),
                ),
                child: FittedBox(
                  child: CommonImage(
                    imagePath: item.icon ?? "",
                    isNetwork: false,
                    color: Colors.black,
                  ),
                ),
              );
            },
            pathBuilder: (context, index) {
              return Container(
                color: index == cubit.sitDownStepData.length - 1
                    ? Colors.transparent
                    : (index < cubit.currentStep
                          ? CommonColors.secondaryColor
                          : Colors.white),
                width: size(context).width * numD01,
                height: size(context).width * numD1,
              );
            },
            subPathBuilder: (context, index) {
              return Container(
                color: index == cubit.sitDownStepData.length - 1
                    ? Colors.transparent
                    : (index < cubit.currentStep
                          ? CommonColors.secondaryColor
                          : Colors.white),
                width: size(context).width * numD01,
                height: size(context).width * numD1,
              );
            },
            elementCount: cubit.sitDownStepData.length,
            badgePosition: StepperBadgePosition.start,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    CommonText(
                      text: "Shin Stall",
                      fontSize: size(context).width * numD05,
                      fontWeight: FontWeight.bold,
                    ),
                    CommonText(
                      text: "Sit Down Category",
                      fontSize: size(context).width * numD035,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),

              InkWell(
                onTap: (){

                  showUnlockTrickBottomSheet(context,cubit);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size(context).width * numD02,
                    vertical: size(context).width * numD01,
                  ),

                  decoration: commonBgColorDecoration(
                    size(context).width * numD04,
                    Colors.red,
                  ),
                  child: CommonText(
                    text: "Action Needed",
                    fontSize: size(context).width * numD035,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),


          SizedBox(height: size(context).width * numD1),

        ],
      ),
    );
  }


  Future<void> showUnlockTrickBottomSheet(BuildContext context, SkillTreeCubit cubit, ){
    return showModalBottomSheet(
      isScrollControlled: true,
        context: context, builder: (context){

      return SingleChildScrollView(
        padding: EdgeInsets.all(size(context).width * numD04),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: size(context).width * numD03),
            CommonText(
              text: "Unlock this Trick ?",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD05,
            ),

            CommonText(
              text: "SP will be spent permanently. You can access tutorial and missions right away.",
              color: Colors.grey,
              textAlign: TextAlign.center,
              fontSize: size(context).width * numD035,
            ),
            SizedBox(height: size(context).width * numD05),

            Container(
              decoration: commonBgColorDecoration(
                  size(context).width * numD02,
                  CommonColors.themeColor.withValues(alpha: 0.1)),
              padding: EdgeInsets.all( size(context).width * numD02),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: .spaceBetween,
                      children:[
                        CommonText(
                          text: "Current SP",
                          color: Colors.grey,
                          fontSize: size(context).width * numD04,
                        ),CommonText(
                          text: "320",
                          color: CommonColors.buttonColor,
                          fontWeight: FontWeight.bold,
                          fontSize: size(context).width * numD04,
                        ),
                      ]
                  ),

                  SizedBox(height: size(context).width * numD02),

                  Row(
                      mainAxisAlignment: .spaceBetween,
                      children:[
                        CommonText(
                          text: "Unlock Cost",
                          color: Colors.grey,
                          fontSize: size(context).width * numD04,
                        ),CommonText(
                          text: "250",
                          color: CommonColors.buttonColor,
                          fontWeight: FontWeight.bold,
                          fontSize: size(context).width * numD04,
                        ),
                      ]
                  ),

                  Divider(),
                  Row(
                      mainAxisAlignment: .spaceBetween,
                      children:[
                        CommonText(
                          text: "SP after unlock",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: size(context).width * numD04,
                        ),CommonText(
                          text: "250",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: size(context).width * numD04,
                        ),
                      ]
                  ),
                ],
              ),
            ),

            SizedBox(height: size(context).width * numD04),

            Container(
              decoration: commonBgColorDecoration(
                  size(context).width * numD02,
                  CommonColors.themeColor.withValues(alpha: 0.1)),
              padding: EdgeInsets.all( size(context).width * numD02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CommonText(
                    text: "Prerequisites",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: size(context).width * numD04,
                  ),
                  SizedBox(height: size(context).width * numD04),
                  Row(
                      children:[
                        Icon(Icons.check_circle_outline_outlined,
                        size: size(context).width * numD05,
                        color: Colors.green),
                        SizedBox(width: size(context).width * numD01),
                        Expanded(
                          child: CommonText(
                            text: "Level requirement met",
                            color: Colors.black,
                            fontSize: size(context).width * numD04,
                          ),
                        ),
                      ]
                  ),
                  SizedBox(height: size(context).width * numD02),
                  Row(
                      children:[
                        Icon(Icons.check_circle_outline_outlined,
                            size: size(context).width * numD05,
                            color: Colors.green),
                        SizedBox(width: size(context).width * numD01),
                        Expanded(
                          child: CommonText(
                            text: "Required base trick unlocked",
                            color: Colors.black,
                            fontSize: size(context).width * numD04,
                          ),
                        ),
                      ]
                  ),
                  SizedBox(height: size(context).width * numD02),
                  Row(
                      children:[
                        Icon(Icons.error_outline,
                            size: size(context).width * numD05,
                            color: Colors.black),
                        SizedBox(width: size(context).width * numD01),
                        Expanded(
                          child: CommonText(
                            text: "Enough SP Available",
                            color: Colors.black,
                            fontSize: size(context).width * numD04,
                          ),
                        ),
                      ]
                  ),
                  SizedBox(height: size(context).width * numD02),
                ],
              ),
            ),

            SizedBox(height: size(context).width * numD04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: commonOutlinedButton(onTap: (){},
                      borderColor: CommonColors.buttonColor,
                      buttonHeight: size(context).width * numD13,
                      radius: numD03,
                      size: size(context), buttonText: CommonText(
                    text: "Cancel",
                    color: Colors.black,
                  )),
                ),
                SizedBox(width: size(context).width * numD04),
                Expanded(
                  child: commonShortButton(onTap: (){
                    
                  },
                      radius: size(context).width * numD03,
                      buttonHeight: size(context).width * numD13,
                      size: size(context), buttonText: "Unlock Trick"),
                )

              ],
            ),


            SizedBox(height: size(context).width * numD04),
            CommonText(
              text: "SP will be spent permanently. You can access tutorial and missions right away.",
              color: Colors.grey,
              fontSize: size(context).width * numD035,
            ),
            SizedBox(height: size(context).width * numD04),
            Container(
              decoration: commonOutlineDecoration(size(context).width * numD02, 1, Colors.grey.shade200),
              padding: EdgeInsets.all(size(context).width * numD02),
              child: Row(
                children: [
                  Icon(Icons.warning_amber,color: Colors.red,size: size(context).width * numD04),
                  SizedBox(width: size(context).width * numD02),
                  Expanded(
                    child: CommonText(
                      text: "Unlock failed. Your SP was not used. Try again in a moment.",
                      color: Colors.red,
                      fontSize: size(context).width * numD035,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size(context).width * numD1),
          ],
        ),
      );



    });

  }

}
