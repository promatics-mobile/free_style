import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/app_bars/custom_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_image/common_image.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_button/common_short_button.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import 'dashboard_cubit.dart';

class DashboardScreen extends StatefulWidget {
  final int selectedIndex;

  const DashboardScreen({super.key, required this.selectedIndex});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        var cubitData = context.read<DashboardCubit>();
        return Scaffold(
          appBar: state.selectedIndex == 0
              ? CustomAppBar(
                  centerTitle: false,
                  titleWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          router.push(AppRouter.profileSetupScreen);
                        },
                        child: Row(
                          children: [
                            ClipOval(
                              child: CommonImage(
                                width: size(context).width * numD13,
                                height: size(context).width * numD13,
                                imagePath: Assets.assetsIcDummyUser1,
                                isNetwork: false,
                              ),
                            ),
                            SizedBox(width: size(context).width * numD02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: "FreeStyle Pro",
                                  fontSize: size(context).width * numD04,
                                  fontWeight: FontWeight.bold,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: size(context).width * numD012,
                                      backgroundColor: Colors.red,
                                    ),
                                    CommonText(
                                      text:
                                          " Lvl 12 ${CommonSymbol.dotSymbol} Red Tier",
                                      fontSize: size(context).width * numD028,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                SizedBox(height: size(context).width * numD005),
                                Container(
                                  decoration: commonBgColorDecoration(
                                    size(context).width * numD04,
                                    CommonColors.secondaryLightColor,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size(context).width * numD02,
                                  ),
                                  height: size(context).width * numD05,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(
                                          size(context).width * numD005,
                                        ),
                                        child: CommonImage(
                                          imagePath: Assets.iconsIcGoldCoin,
                                          height: size(context).width * numD03,
                                          width: size(context).width * numD03,
                                          isNetwork: false,
                                        ),
                                      ),
                                      CommonText(
                                        text: "450000 C",
                                        fontSize: size(context).width * numD03,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: size(context).width * numD02),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                       // router.push(AppRouter.shopScreen);
                        router.push(AppRouter.leagueRankingScreen);
                      },
                      icon: CommonImage(
                        imagePath: Assets.iconsIcShop,
                        height: size(context).width * numD06,
                        width: size(context).width * numD06,
                        color: Colors.white,
                        isNetwork: false,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        router.push(AppRouter.notificationsScreen);
                      },
                      icon: Icon(Icons.notifications, color: Colors.white),
                    ),
                  ],
                  showBack: false,
                )
              : CommonAppBar(
                  title: state.selectedTitle ?? "",
                  showBack: false,
                  actions: [
                    if (state.selectedIndex == 3)
                      IconButton(
                        onPressed: () {
                          router.push(AppRouter.settingsScreen);
                        },
                        icon: Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                        ),
                      ),

                    if (state.selectedIndex == 1)
                      IconButton(
                        onPressed: () {
                          router.push(AppRouter.challengeHistoryScreen);
                        },
                        icon: Icon(
                          Icons.history,
                          color: Colors.white,
                        ),
                      ),

                    if (state.selectedIndex == 2)
                      IconButton(
                        onPressed: () {
                          router.push(AppRouter.searchPlayerScreen);
                        },
                        icon: Icon(
                          Icons.person_add_alt_rounded,
                          color: Colors.white,
                        ),
                      ),
                    IconButton(
                      onPressed: () {
                        router.push(AppRouter.notificationsScreen);
                      },
                      icon: Icon(Icons.notifications, color: Colors.white),
                    ),
                  ],
                ),
          body: Container(
            child: cubitData.dashboardScreens[state.selectedIndex!],
          ),
          bottomNavigationBar: MotionTabBar(
            controller: MotionTabBarController(
              initialIndex: 0,
              length: 4,
              vsync: this,
            ),
            initialSelectedTab: "Home",
            useSafeArea: true,
            labelAlwaysVisible: false,
            labels: const ["Home", "Battles", "Social", "Profile"],
            iconWidgets: [
              Image.asset(
                Assets.iconsIcHome,
                height: size(context).width * numD06,
                width: size(context).width * numD06,
              ),
              Image.asset(
                Assets.iconsIcBattle,
                height: size(context).width * numD06,
                width: size(context).width * numD06,
              ),
              Image.asset(
                Assets.iconsIcMessage,
                height: size(context).width * numD06,
                width: size(context).width * numD06,
              ),
              Image.asset(
                Assets.iconsIcProfile,
                height: size(context).width * numD06,
                width: size(context).width * numD06,
              ),
            ],
            tabSize: size(context).width * numD12,
            tabBarHeight: size(context).width * numD15,
            textStyle: TextStyle(
              fontSize: size(context).width * numD035,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            tabIconSize: size(context).width * numD04,
            tabIconSelectedSize: size(context).width * numD06,
            tabSelectedColor: CommonColors.secondaryColor,
            tabIconSelectedColor: Colors.black,
            tabBarColor: Colors.white,
            onTabItemSelected: (int value) {
              Future.delayed(Duration(milliseconds: 500), () {
                cubitData.onTapBottomBar(value);
              });
            },
          ),
        );
      },
    );
  }

  ListView faqWidget(BuildContext context, DashboardCubit cubit) {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                CommonText(
                  text: "How do I update my prescription?",
                  fontWeight: FontWeight.bold,
                  color: CommonColors.secondaryColor,
                  fontSize: size(context).width * numD04,
                ),
                true
                    ? Icon(Icons.keyboard_arrow_down_rounded)
                    : Icon(Icons.keyboard_arrow_up_sharp),
              ],
            ),
            CommonText(
              text:
                  "To update your prescription, navigate to the Medications tab and select 'Request Change'. Your clinician will review the request and get back to you within 24 hours.",
              color: Colors.grey,
              fontSize: size(context).width * numD03,
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return Divider(color: CommonColors.lightGreyColor);
      },
    );
  }

  Future<dynamic> showLogoutAlertDialog(
    Size size,
    BuildContext context,
    DashboardCubit cubitData,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: size.width * numD40,
                horizontal: size.width * numD20,
              ),
              padding: EdgeInsets.all(size.width * numD03),
              decoration: commonWhiteDecoration(size, numD03),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.iconsIcLogout,
                    width: size.width * numD06,
                    height: size.width * numD06,
                  ),
                  SizedBox(height: size.width * numD025),
                  CommonText(
                    textAlign: TextAlign.center,
                    text: "Are you sure you want to logout?",
                    fontSize: size.width * numD03,
                    fontWeight: FontWeight.w600,
                    color: CommonColors.themeColor,
                  ),
                  SizedBox(height: size.width * numD05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: commonShortButton(
                          onTap: () async {},
                          buttonText: "YES",
                          fontSize: size.width * numD02,
                          buttonHeight: size.width * numD06,
                          size: size,
                        ),
                      ),
                      SizedBox(width: size.width * numD02),
                      Expanded(
                        child: commonShortOutlinedButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          buttonText: "NO",
                          buttonColor: CommonColors.themeColor,
                          fontSize: size.width * numD02,
                          buttonHeight: size.width * numD06,
                          size: size,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.width * numD02),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
