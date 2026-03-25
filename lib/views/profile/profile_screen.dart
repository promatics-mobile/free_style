import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_methods.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';
import 'package:free_style/utils/common_widgets/linear_progress_indicator/custom_linear_progress.dart';
import 'package:free_style/views/profile/profile_cubit.dart';
import 'package:free_style/views/profile/profile_shimmer.dart';

import '../../generated/assets.dart';
import '../../main.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_tab_bar/common_sliver_tab_bar.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          var cubit = context.read<ProfileCubit>();

          if (cubit.userModel == null) {
            return const ProfileShimmer();
          }

          return CommonSliverTabBar(
            tabs: const ["Battles", "Achievements", "Promotions", "History"],
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: Container(
                          color: CommonColors.secondaryColor,
                          padding: EdgeInsets.all(size(context).width * numD005),
                          child: ClipOval(
                            child: Container(
                              color: CommonColors.themeColor,
                              padding: EdgeInsets.all(size(context).width * numD005),
                              child: ClipOval(
                                child: CommonImage(
                                  imagePath:
                                      sharedPreferences.getString(PreferenceKeys.avatarImageKey) ??
                                      "",
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
                            text: cubit.userModel!.leagueModel!.name.toString().toCapitalize(),
                            fontWeight: FontWeight.bold,
                            fontSize: size(context).width * numD03,
                            color: Colors.black,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),

                  CommonText(
                    text: cubit.userModel!.name ?? "",
                    fontWeight: FontWeight.bold,
                    fontSize: size(context).width * numD05,
                  ),
                  CommonText(
                    text: cubit.userModel!.userName ?? "",
                    fontWeight: FontWeight.w400,
                    fontSize: size(context).width * numD03,
                  ),
                  SizedBox(height: size(context).width * numD01),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: size(context).width * numD012,
                        backgroundColor:  CommonColors.secondaryColor,
                      ),
                      CommonText(
                        text:
                            " Lvl ${cubit.userModel!.level} ${CommonSymbol.dotSymbol} ${cubit.userModel!.tierModel!.name.toString().toCapitalize()} Tier",
                        fontSize: size(context).width * numD03,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: size(context).width * numD02),
                  commonShortButton(
                    onTap: () {
                      router.push(AppRouter.inventoryScreen);
                    },
                    buttonColor: CommonColors.secondaryColor,
                    buttonHeight: size(context).width * numD07,
                    size: size(context),
                    textColor: Colors.black,
                    buttonText: "Inventory",
                  ),
                  SizedBox(height: size(context).width * numD03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatColumn(cubit.userModel!.tricks.toString(), "TRICKS"),
                      _buildStatColumn(cubit.userModel!.challenges.toString(), "CHALLENGES"),
                      _buildStatColumn(cubit.userModel!.battles.toString(), "BATTLES"),
                    ],
                  ),
                  SizedBox(height: size(context).width * numD04),
                  Container(
                    decoration: commonBgColorDecoration(
                      size(context).width * numD04,
                      CommonColors.secondaryColor,
                    ),
                    padding: EdgeInsets.all(size(context).width * numD04),
                    width: size(context).width,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: "Level Progress",
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: size(context).width * numD035,
                            ),
                            CommonText(
                              text: "1,250/2,000 XP",
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: size(context).width * numD035,
                            ),
                          ],
                        ),
                        SizedBox(height: size(context).width * numD02),

                        commonNormalLinearProgress(
                          context: context,
                          value: 0.6,
                          bgColor: Colors.white.withValues(alpha: 0.3),
                          valueColor: CommonColors.buttonColor,
                        ),
                        SizedBox(height: size(context).width * numD02),
                        Container(
                          decoration: commonBgColorDecoration(
                            size(context).width * numD03,
                            Colors.black,
                          ),
                          padding: EdgeInsets.all(size(context).width * numD02),
                          child: Row(
                            children: [
                              Container(
                                decoration: commonCircularFill(color: Colors.white),
                                padding: EdgeInsets.all(size(context).width * numD01),
                                child: Icon(
                                  Icons.electric_bolt,
                                  color: CommonColors.secondaryColor,
                                ),
                              ),
                              SizedBox(width: size(context).width * numD02),
                              CommonText(text: "${cubit.userModel!.xp.toString()} XP Available"),
                              Spacer(),
                              Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size(context).width * numD05),
                ],
              ),
            ),
            onTap: (value) {
              cubit.onChangeTab(value);
            },
            onChanged: (value) {
              cubit.onChangeTab(value);
            },
            views: [
              _buildListView(context, cubit.battlesList, 0),
              _buildListView(context, cubit.achievementsList, 1),
              _buildListView(context, cubit.promotionsList, 2),
              _buildListView(context, cubit.historyList, 3),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        CommonText(
          text: value,
          fontWeight: FontWeight.bold,
          fontSize: size(context).width * numD04,
        ),
        CommonText(
          text: label,
          fontWeight: FontWeight.w400,
          fontSize: size(context).width * numD035,
        ),
      ],
    );
  }

  Widget _buildListView(BuildContext context, List<ProfileItemModel> items, int tabIndex) {
    if (items.isEmpty) {
      return Center(
        child: CommonText(
          text: "No records found",
          color: Colors.grey,
          fontSize: size(context).width * numD04,
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      padding: EdgeInsets.only(top: size(context).width * numD02),
      itemBuilder: (context, idx) {
        final item = items[idx];
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
                  imagePath: tabIndex == 0
                      ? Assets.iconsIcBattle
                      : tabIndex == 1
                      ? Assets.iconsIcTrophy
                      : tabIndex == 2
                      ? Assets.iconsIcBadge
                      : Assets.iconsIcHistory,
                  width: size(context).width * numD05,
                  height: size(context).width * numD05,
                  color: Colors.black,
                  isNetwork: false,
                ),
              ),
              SizedBox(width: size(context).width * numD04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: item.title,
                      color: Colors.black,
                      fontSize: size(context).width * numD035,
                      fontWeight: FontWeight.bold,
                    ),
                    CommonText(
                      text: item.date,
                      color: Colors.grey,
                      fontSize: size(context).width * numD03,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
