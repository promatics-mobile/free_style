import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/generated/assets.dart';
import 'package:free_style/routes/route.dart';
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

import '../../utils/common_methods.dart';
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
          body: Column(
            children: [
              state.tierList.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      height: size(context).width * numD08,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
                        itemCount: state.tierList.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: size(context).width * numD03),
                        itemBuilder: (context, index) {
                          final tier = state.tierList[index];
                          final isSelected = state.selectedTierIndex == index;

                          return GestureDetector(
                            onTap: () {
                              cubit.onChangeTierTab(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size(context).width * numD06,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? CommonColors.secondaryColor
                                    : Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(size(context).width * numD05),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonText(
                                    text: tier.name?.toUpperCase() ?? "",
                                    color: isSelected ? Colors.black : Colors.grey.shade400,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

              state.branchList.isEmpty
                  ? const SizedBox()
                  : Expanded(
                      child: CommonTabBar(
                        tabs: state.branchList.map((e) => e.name?.toUpperCase() ?? "").toList(),

                        views: state.branchList.map((e) {
                          final branchName = (e.name ?? "").toLowerCase();
                          return skillDetailWidget(context, cubit);

                        }).toList(),

                        isScrollable: true,

                        onTap: (index) {
                          cubit.onChangeSkillTab(index);
                        },

                        onChanged: (index) {
                          cubit.onChangeSkillTab(index);
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget skillDetailWidget(BuildContext context, SkillTreeCubit cubit) {
    final skills = cubit.state.skillList;

    if (skills.isEmpty) {
      return Center(
        child: CommonText(
          text: "No Skills Found",
          fontSize: size(context).width * numD04,
          color: Colors.grey,
        ),
      );
    }

    final skillDetails = skills.where((e)=> e.isUnLocked == true).lastOrNull;
    debugPrint("skill::$skillDetails");


    return Padding(
      padding: EdgeInsets.all(size(context).width * numD04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          UniversalStepper(
            inverted: false,
            stepperDirection: Axis.vertical,
            elementCount: cubit.state.skillList.length,
            elementBuilder: (context, index) {
              final skill = cubit.state.skillList[index];
              final isUnLocked = skill.isUnLocked == true;

              return InkWell(
                onTap: (){
                  if(!isUnLocked){
                    showUnlockTrickBottomSheet(context, cubit,skill);
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(left: size(context).width * numD04,
                      top: size(context).width * numD02),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonText(
                        text: skill.name?.toUpperCase() ?? "",
                        fontSize: size(context).width * numD04,
                        color: skill.isUnLocked == false ? Colors.grey : Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            },

            badgeBuilder: (context, index) {
              final skill = cubit.state.skillList[index];
              final isUnLocked = skill.isUnLocked == true;

              return InkWell(
                onTap: (){
                  if(!isUnLocked){
                    showUnlockTrickBottomSheet(context, cubit,skill);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(size(context).width * numD02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(size(context).width * numD1),
                  ),
                  child: Icon(
                    isUnLocked ? Icons.check_circle : Icons.lock ,
                    color: isUnLocked ?  CommonColors.secondaryColor :  Colors.grey,
                  ),
                ),
              );
            },

            pathBuilder: (context, index) {
              final skill = cubit.state.skillList[index];
              final isLocked = skill.isUnLocked == false;

              return Container(
                color: index == cubit.state.skillList.length - 1
                    ? Colors.transparent
                    : (isLocked ? Colors.grey.shade300 : CommonColors.secondaryColor),
                width: size(context).width * numD01,
                height: size(context).width * numD1,
              );
            },

            subPathBuilder: (context, index) {
              final skill = cubit.state.skillList[index];
              final isLocked = skill.isActive == false;

              return Container(
                color: index == cubit.state.skillList.length - 1
                    ? Colors.transparent
                    : (isLocked ? Colors.grey.shade300 : CommonColors.secondaryColor),
                width: size(context).width * numD01,
                height: size(context).width * numD1,
              );
            },

            badgePosition: StepperBadgePosition.start,
          ),

          if(skillDetails !=null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: skillDetails.name ?? "",
                          fontSize: size(context).width * numD05,
                          fontWeight: FontWeight.bold,
                        ),

                        CommonText(
                          text: "Level ${skillDetails.minLvlReq ?? 0}+ • ${skillDetails.difficultyLevel ?? ""}",
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
                      text: (skillDetails.difficultyLevel ?? "").toUpperCase(),
                      fontSize: size(context).width * numD035,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: size(context).width * numD04),

              CommonText(
                text: "Complete this skill to earn rewards.",
                fontSize: size(context).width * numD035,
                color: Colors.grey,
              ),

              SizedBox(height: size(context).width * numD04),

              Row(
                children: [
                  Icon(Icons.check_circle_outline,
                      size: size(context).width * numD05,
                      color: CommonColors.secondaryColor),
                  SizedBox(width: size(context).width * numD02),
                  Expanded(
                    child: CommonText(
                      text: "Min Level ${skillDetails.minLvlReq ?? 0}",
                      fontSize: size(context).width * numD04,
                    ),
                  ),
                ],
              ),

              SizedBox(height: size(context).width * numD01),
              Row(
                children: [
                  Icon(Icons.monetization_on_outlined,
                      size: size(context).width * numD05,
                      color: CommonColors.secondaryColor),
                  SizedBox(width: size(context).width * numD02),
                  Expanded(
                    child: CommonText(
                      text:
                      "Reward: ${skillDetails.completionRewards?.coin ?? 0} Coins • ${skillDetails.completionRewards?.xp ?? 0} XP",
                      fontSize: size(context).width * numD04,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size(context).width * numD1),
              CommonButton(
                onTap: () {
                  router.push(AppRouter.tutorialScreen, extra: {"id": skillDetails.id});
                },
                text: "Start Tutorial",
              ),
            ],
          )

        ],
      ),
    );
  }


  Future<void> showUnlockTrickBottomSheet(BuildContext context, SkillTreeCubit cubit, SkillModel item) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
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


              SizedBox(height: size(context).width * numD04),

              Container(
                decoration: commonBgColorDecoration(
                  size(context).width * numD02,
                  CommonColors.themeColor.withValues(alpha: 0.1),
                ),
                padding: EdgeInsets.all(size(context).width * numD02),
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
                      children: [
                        Icon(
                          Icons.check_circle_outline_outlined,
                          size: size(context).width * numD05,
                          color: Colors.green,
                        ),
                        SizedBox(width: size(context).width * numD01),
                        Expanded(
                          child: CommonText(
                            text: "Min Level ${item.minLvlReq} required",
                            color: Colors.black,
                            fontSize: size(context).width * numD04,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size(context).width * numD02),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline_outlined,
                          size: size(context).width * numD05,
                          color: Colors.green,
                        ),
                        SizedBox(width: size(context).width * numD01),
                        Expanded(
                          child: CommonText(
                            text: "Required base trick unlocked",
                            color: Colors.black,
                            fontSize: size(context).width * numD04,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size(context).width * numD02),

                  ],
                ),
              ),

              SizedBox(height: size(context).width * numD1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: commonOutlinedButton(
                      onTap: () {
                        router.pop();
                      },
                      borderColor: CommonColors.buttonColor,
                      buttonHeight: size(context).width * numD13,
                      radius: numD03,
                      size: size(context),
                      buttonText: CommonText(text: "Cancel", color: Colors.black),
                    ),
                  ),
                  SizedBox(width: size(context).width * numD04),
                  Expanded(
                    child: commonShortButton(
                      onTap: () {
                        router.pop();
                        cubit.callUnlockSkillApi(item.id.toString());
                      },
                      radius: size(context).width * numD03,
                      buttonHeight: size(context).width * numD13,
                      size: size(context),
                      buttonText: "Unlock Trick",
                    ),
                  ),
                ],
              ),


              SizedBox(height: size(context).width * numD1),
            ],
          ),
        );
      },
    );
  }
}
