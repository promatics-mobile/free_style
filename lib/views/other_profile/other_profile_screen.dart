import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/routes/route.dart';
import 'package:free_style/utils/common_methods.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/linear_progress_indicator/custom_linear_progress.dart';

import '../../generated/assets.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_button/common_gradient_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_tab_bar/common_sliver_tab_bar.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import 'other_profile_cubit.dart';

class OtherProfileScreen extends StatefulWidget {
  const OtherProfileScreen({super.key});

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherProfileCubit, OtherProfileState>(
      builder: (context, state) {
        var cubit = context.read<OtherProfileCubit>();

        final statsList = [
          {
            "title": "Total Battles",
            "value": state.user?.user?.battles ?? 0,
            "icon": Assets.iconsIcBattle,
          },
          {
            "title": "Challenges",
            "value": state.user?.user?.challenges ?? 0,
            "icon": Assets.iconsIcMission,
          },
          {"title": "Tricks", "value": state.user?.user?.tricks ?? 0, "icon": Assets.iconsIcFlame},

        ];
        return Scaffold(
          appBar: CommonAppBar(
            title: "Player Profile",
            showBack: true,
            actions: [
              if(cubit.getButtonText() == "Unfollow")
              IconButton(
                onPressed: () {
                  cubit.callRoomIdApi();
                },
                icon: CommonImage(
                  imagePath: Assets.iconsIcMessage,
                  color: CommonColors.secondaryColor,
                  height: size(context).width * numD07,
                  width: size(context).width * numD07,
                  isNetwork: false,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
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
                                child: CommonImage(
                                  imagePath: state.user?.user?.avatar?.picture?.isNotEmpty == true
                                      ? state.user?.user?.avatar!.picture!.first.fullPath ?? ""
                                      : "",
                                  height: size(context).width * numD25,
                                  width: size(context).width * numD25,
                                  isNetwork: true,
                                ),
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
                          decoration: commonBgColorDecoration(
                            size(context).width * numD04,
                            CommonColors.secondaryColor,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: size(context).width * numD02,
                            vertical: size(context).width * numD005,
                          ),
                          child: CommonText(
                            text: "#${state.user?.user?.playerRanking.toString()} Global",
                            fontWeight: FontWeight.bold,
                            fontSize: size(context).width * numD03,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: CommonText(
                    text: state.user?.user?.userName ?? "",
                    fontWeight: FontWeight.bold,
                    fontSize: size(context).width * numD06,
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: size(context).width * numD015,
                        backgroundColor: CommonColors.secondaryColor,
                      ),

                      CommonText(
                        text: " Level ${state.user?.user?.level}",
                        fontSize: size(context).width * numD035,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size(context).width * numD05),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                   /* Expanded(
                      child: CommonButton(
                        text: "Challenge",
                        onTap: () {
                          showToast(isError: false, message: "Challenge sent successfully!");
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: size(context).width * numD04),*/
                    SizedBox(
                      width: size(context).width /2,
                      child: CommonGradientButton(
                        text: cubit.getButtonText(),
                        onTap: cubit.handleButtonTap,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size(context).width * numD05),
                // Container(
                //   decoration: commonBgColorDecoration(
                //     size(context).width * numD04,
                //     CommonColors.secondaryColor,
                //   ),
                //   padding: EdgeInsets.all(size(context).width * numD04),
                //   width: size(context).width,
                //   child: Column(
                //     children: [
                //       Container(
                //         padding: EdgeInsets.all(size(context).width * numD02),
                //         child: Row(
                //           children: [
                //             Container(
                //               decoration: commonCircularFill(color: Colors.white),
                //               padding: EdgeInsets.all(size(context).width * numD03),
                //               child: CommonImage(
                //                 imagePath: Assets.iconsIcTrophy,
                //                 height: size(context).width * numD05,
                //                 width: size(context).width * numD05,
                //                 isNetwork: false,
                //                 color: Colors.black,
                //               ),
                //             ),
                //             SizedBox(width: size(context).width * numD02),
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 CommonText(text: "Gold Div I", color: Colors.black),
                //                 CommonText(
                //                   text: "Gold Div I",
                //                   color: Colors.grey,
                //                   fontSize: size(context).width * numD03,
                //                 ),
                //               ],
                //             ),
                //             Spacer(),
                //             Icon(Icons.keyboard_arrow_right_outlined, color: Colors.black),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: size(context).width * numD04),
                CommonText(text: "Battle Stats", fontWeight: FontWeight.bold),
                SizedBox(height: size(context).width * numD04),
                GridView.builder(
                  itemCount: statsList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: size(context).width * numD02,
                    mainAxisSpacing: size(context).width * numD02,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, idx) {
                    final item = statsList[idx];

                    return Container(
                      decoration: commonBgColorDecoration(
                        size(context).width * numD03,
                        Colors.white,
                      ),
                      padding: EdgeInsets.all(size(context).width * numD02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: "${item["value"]}",
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: size(context).width * numD05,
                              ),
                              CommonText(
                                text: item["title"].toString(),
                                color: Colors.black,
                                fontSize: size(context).width * numD035,
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: CommonColors.secondaryLightColor,
                            radius: size(context).width * numD05,
                            child: CommonImage(
                              imagePath: item["icon"].toString(),
                              width: size(context).width * numD05,
                              height: size(context).width * numD05,
                              isNetwork: false,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

  }

  Widget battleWidget(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      padding: EdgeInsets.only(top: size(context).width * numD02),
      itemBuilder: (context, idx) {
        return Container(
          decoration: commonBgColorDecoration(size(context).width * numD04, Colors.white),
          padding: EdgeInsets.all(size(context).width * numD04),
          margin: EdgeInsets.symmetric(vertical: size(context).width * numD01),

          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: CommonColors.secondaryLightColor,
                radius: size(context).width * numD05,
                child: CommonImage(
                  imagePath: Assets.iconsIcBattle,
                  width: size(context).width * numD05,
                  height: size(context).width * numD05,
                  isNetwork: false,
                ),
              ),
              SizedBox(width: size(context).width * numD02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: "Battle Arena",
                    color: Colors.black,
                    fontSize: size(context).width * numD035,
                  ),
                  CommonText(
                    text: "Unlocked on Oct 12 2025",
                    color: Colors.grey,
                    fontSize: size(context).width * numD03,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
