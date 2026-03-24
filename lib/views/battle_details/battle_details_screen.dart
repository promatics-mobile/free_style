import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/views/social/social_cubit.dart';
import 'package:universal_stepper/universal_stepper.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_methods.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_button/common_gradient_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import '../search_players/search_players_cubit.dart';
import '../skill_tree/skill_tree_cubit.dart';
import 'battle_details_cubit.dart';

class BattleDetailsScreen extends StatelessWidget {
  const BattleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = size(context).width;

    return Scaffold(
      appBar: CommonAppBar(title: "Battle Details"),
      body: BlocBuilder<BattleDetailsCubit, BattleDetailsState>(
        builder: (context, state) {
          var cubit = context.read<BattleDetailsCubit>();

          if(cubit.battleModel == null){
            return Container();
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: w * numD04),

                /// 🏆 Battle Icon
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: w * numD1,
                  child: CommonImage(imagePath: Assets.iconsIcBattle,
                    width: size(context).width * numD1,
                    height: size(context).width * numD1,
                    fit: BoxFit.cover,
                    isNetwork: false,
                  ),
                ),

                SizedBox(height: w * numD04),

                /// 🏷 Battle Name
                CommonText(
                  text: cubit.battleModel!.battleName,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  fontSize: w * numD06,
                ),

                SizedBox(height: w * numD02),

                /// 📄 Description
                CommonText(
                  text: cubit.battleModel!.description ?? "",
                  textAlign: TextAlign.center,
                  fontSize: w * numD035,
                ),

                SizedBox(height: w * numD04),

                /// 🎯 Tier + Rewards Card
                Container(
                  decoration: commonBgColorDecoration(w * numD03, CommonColors.secondaryColor),
                  padding: EdgeInsets.all(w * numD04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Tier
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(text: "Tier", color: Colors.black, fontSize: w * numD04),
                          CommonText(
                            text: cubit.battleModel!.tier.name ?? "",
                            color: Colors.black,
                            fontSize: w * numD04,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),

                      SizedBox(height: w * numD02),

                      /// Rewards
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(text: "XP", color: Colors.black),
                          CommonText(text: "${cubit.battleModel!.reward.xp ?? 0}", color: Colors.black),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(text: "Coins", color: Colors.black),
                          CommonText(text: "${cubit.battleModel!.reward.coins ?? 0}", color: Colors.black),
                        ],
                      ),

                      SizedBox(height: w * numD02),

                      /// ⏳ Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(text: "End At", color: Colors.black),
                          CommonText(text: dateTimeFormatter(dateTime: cubit.battleModel!.endDate.toString()), color: Colors.black),
                         /* StreamBuilder<int>(
                            stream: cubit.timerStream(),
                            builder: (context, snapshot) {
                              final challenge = cubit.battleModel;
                              if (challenge == null) return SizedBox();
                              return CommonText(
                                text: formatRemaining(challenge.remainingTime),
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: size(context).width * numD04,
                              );
                            },
                          ),*/
                        ],
                      )

                    ],
                  ),
                ),

                SizedBox(height: w * numD05),

                /// 🧠 Skill Tree Title
                CommonText(
                  text: "Skills to Perform",
                  fontSize: w * numD045,
                  fontWeight: FontWeight.bold,
                ),

                SizedBox(height: w * numD03),

                /// 🌳 Skill Stepper
                _buildSkillStepper(context,cubit: cubit ,skills: cubit.battleModel!.skills),

                SizedBox(height: w * numD25),

                /// 🎮 CTA Buttons
                CommonButton(
                  text: "Start Battle",
                  onTap: () {
                    showInviteFriendBottomSheet(context, cubit, cubit.myFriendsList, (friend){

                      cubit.callStartBattleApi(cubit.battleModel!.id, friend.sId.toString());
                    });




                  },
                ),

                SizedBox(height: w * numD05),
              ],
            ),
          );
        },
      ),
    );
  }


  /// 🌳 Skill Stepper UI
  Widget _buildSkillStepper(BuildContext context, {required BattleDetailsCubit cubit,required List<SkillModel> skills}) {
    final w = size(context).width;


    return  Container(
      padding: EdgeInsets.all(size(context).width * numD04),
      decoration: commonOutlineDecoration(size(context).width * numD04, 1, CommonColors.secondaryColor),
      child: UniversalStepper(
        inverted: false,
        stepperDirection: Axis.vertical,
        elementCount: skills.length,
        elementBuilder: (context, index) {
          final skill = skills[index];
          final isUnLocked = skill.isUnLocked == true;

          return InkWell(
            onTap: (){
              router.push(
                AppRouter.tutorialScreen,
                extra: {
                  "id": skill.id,
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                top: size(context).width * numD01,
                bottom: size(context).width * numD04,
                left: size(context).width * numD04,
              ),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      CommonText(
                        text: skill.name,
                        fontWeight: FontWeight.bold,
                        fontSize: size(context).width * numD04,
                      ),
                      Icon(Icons.arrow_forward,color: Colors.white,)
                    ],
                  ),
                  SizedBox(height: size(context).width * numD01),
                  if(skill.tutorials !=null)
                  Column(
                    children: List.generate(skill.tutorials!.length, (idx) {
                      Map tutorial = skill.tutorials![idx] as Map;
                      return Container(
                        decoration: commonOutlineDecoration(
                          size(context).width * numD02,
                          1,
                          Colors.grey.shade800,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: size(context).width * numD03,
                          vertical: size(context).width * numD01,
                        ),
                        alignment: Alignment.topLeft,
                        width: size(context).width / 1.4,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text: tutorial['display_title'].toString(),
                                    fontSize: size(context).width * numD04,
                                  ),
                                  CommonText(
                                    text: skill.difficultyLevel
                                        .toString()
                                        .toCapitalize(),
                                    color: Colors.grey,
                                    fontSize: size(context).width * numD035,
                                  ),
                                ],
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                router.push(
                                  AppRouter.tutorialVideoDetailScreen,
                                  extra: {
                                    "id": tutorial['_id'],
                                    "skill_id": skill.id,
                                  },
                                );
                              },
                              icon: Container(
                                decoration: commonCircularFill(
                                  color: Colors.grey.shade800,
                                ),
                                padding: EdgeInsets.all(size(context).width * numD03),
                                child: CommonImage(
                                  imagePath: Assets.iconsIcPlay,
                                  isNetwork: false,
                                  width: size(context).width * numD05,
                                  height: size(context).width * numD05,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },

        badgeBuilder: (context, index) {
          final skill = skills[index];
          final isUnLocked = skill.isUnLocked == true;

          return Container(
            width: size(context).width * numD09,
            height: size(context).width * numD09,
            padding: EdgeInsets.all(size(context).width * numD02),
            decoration: BoxDecoration(
              color: CommonColors.themeDarkColor,
              border: Border.all(color: CommonColors.buttonColor),
              borderRadius: BorderRadius.all(
                Radius.circular(size(context).width * numD07),
              ),
            ),
            child: FittedBox(
              child: CommonText(
                text: "${index + 1}",
                color: CommonColors.buttonColor,
              ),
            ),
          );
        },

        pathBuilder: (context, index) {
          final skill = skills[index];
          final isLocked = skill.isUnLocked == false;

          return Container(
            color: index == skills.length - 1
                ? Colors.transparent
                : CommonColors.buttonColor.withValues(alpha: 0.2),
            width: size(context).width * numD005,
            height: index == skills.length - 1 ? 0 :size(context).width * numD1,
          );
        },

        subPathBuilder: (context, index) {
          final skill = skills[index];
          final isLocked = skill.isUnLocked == false;

          return Container(
            color: index == skills.length - 1
                ? Colors.transparent
                : CommonColors.buttonColor.withValues(alpha: 0.2),
            width: size(context).width * numD005,
            height: size(context).width * numD1,
          );
        },

        badgePosition: StepperBadgePosition.start,
      ),
    );

  }


  void showInviteFriendBottomSheet(
      BuildContext context,
      BattleDetailsCubit cubit,
      List<PlayerModel> friends,
      Function(PlayerModel selectedFriend) onInvite,
      ) {
    var w = size(context).width;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(value: cubit,
        child: BlocBuilder<BattleDetailsCubit, BattleDetailsState>(builder: (context,state){
          var cubit = context.read<BattleDetailsCubit>();

          return Container(
            height: size(context).height * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(w * numD05),
              ),
            ),
            child: Column(
              children: [

                /// 🔘 Handle Bar
                SizedBox(height: w * numD02),
                Container(
                  width: w * numD1,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                SizedBox(height: w * numD03),

                /// 🧑 Title
                CommonText(
                  text: "Select Friend",
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: w * numD045,
                ),

                SizedBox(height: w * numD03),

                /// 👥 Friends List
                Expanded(
                  child: ListView.builder(
                    itemCount: friends.length,
                    padding: EdgeInsets.symmetric(horizontal: w * numD04),
                    itemBuilder: (context, idx) {
                      final friend = friends[idx];
                      final isSelected = cubit.selectedFriend?.sId == friend.sId;

                      return InkWell(
                        onTap: () {
                          cubit.onSelectFriend(friend);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? CommonColors.secondaryColor.withOpacity(0.2)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(w * numD04),
                            border: Border.all(
                              color: isSelected
                                  ? CommonColors.secondaryColor
                                  : Colors.grey.shade300,
                            ),
                          ),
                          padding: EdgeInsets.all(w * numD04),
                          margin: EdgeInsets.symmetric(vertical: w * numD01),
                          child: Row(
                            children: [

                              /// 👤 Avatar
                              ClipOval(
                                child: CommonImage(
                                  imagePath: friend.avatar?.picture?.isNotEmpty == true
                                      ? friend.avatar!.picture!.first.fullPath ?? ""
                                      : "",
                                  isNetwork: true,
                                  width: w * numD1,
                                  height: w * numD1,
                                ),
                              ),

                              SizedBox(width: w * numD02),

                              /// 🧾 Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: friend.name ?? "",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: w * numD04,
                                    ),
                                    CommonText(
                                      text: friend.userName ?? "",
                                      color: Colors.grey,
                                      fontSize: w * numD03,
                                    ),
                                    SizedBox(height: w * numD01),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: w * numD02,
                                        vertical: w * numD005,
                                      ),
                                      decoration: commonBgColorDecoration(
                                        w * numD03,
                                        CommonColors.secondaryColor,
                                      ),
                                      child: CommonText(
                                        text: "Level ${friend.level}",
                                        color: Colors.black,
                                        fontSize: w * numD03,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// ✅ Selected Icon
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: CommonColors.secondaryColor,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// 🚀 Bottom Button
                Padding(
                  padding: EdgeInsets.all(w * numD04),
                  child: CommonButton(
                    text: "Send Battle Invite",
                    onTap:  () {
                      if(cubit.selectedFriend == null){
                        showToast(isError: true, message: "Please select a friend");
                        return;
                      }
                      onInvite(cubit.selectedFriend!);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );

        }),
        );
      },
    );
  }



}
