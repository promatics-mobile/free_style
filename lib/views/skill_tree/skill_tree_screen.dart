import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
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
              lowerWidget(context, cubit),
              lowerWidget(context, cubit),
              lowerWidget(context, cubit),
            ],
            isScrollable: true,
            onTap: (index){
              debugPrint("onTap Index: $index");
            },
            onChanged: (index){
              debugPrint("onChanged Index: $index");
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
              var item = cubit.stepperData[index];
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
              var item = cubit.stepperData[index];
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
                color: index == cubit.stepperData.length - 1
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
                color: index == cubit.stepperData.length - 1
                    ? Colors.transparent
                    : (index < cubit.currentStep
                          ? CommonColors.secondaryColor
                          : Colors.white),
                width: size(context).width * numD01,
                height: size(context).width * numD1,
              );
            },
            elementCount: cubit.stepperData.length,
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

          CommonButton(onTap: (){}, text: "Start Tutorial")

        ],
      ),
    );
  }
}
