import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/main.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/app_bars/custom_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_image/common_image.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_bottom_nav_bar/common_bottom_nav_bar.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import 'dashboard_cubit.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;

  const DashboardScreen({super.key, required this.child});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<DashboardCubit>().callGetProfileApi();
      context.read<DashboardCubit>().getDeviceId();
    });
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
                      if (cubitData.userModel != null)
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
                                  imagePath:
                                      sharedPreferences.getString(PreferenceKeys.avatarImageKey) ??
                                      "",
                                  isNetwork: true,
                                ),
                              ),
                              SizedBox(width: size(context).width * numD02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text:
                                        sharedPreferences.getString(PreferenceKeys.fullNameKey) ??
                                        "DummyUser",
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
                                            " Lvl ${cubitData.userModel != null ? cubitData.userModel!.level : ""} ${CommonSymbol.dotSymbol} Red Tier",
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
                                          margin: EdgeInsets.all(size(context).width * numD005),
                                          child: CommonImage(
                                            imagePath: Assets.iconsIcGoldCoin,
                                            height: size(context).width * numD03,
                                            width: size(context).width * numD03,
                                            isNetwork: false,
                                          ),
                                        ),
                                        CommonText(
                                          text: "${cubitData.userModel!.wallet?.coins} C",
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
                        router.push(AppRouter.shopScreen);
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
                        router.push(AppRouter.globalLeadBoardScreen);
                      },
                      icon: CommonImage(
                        imagePath: Assets.iconsIcLeadboard,
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
                      icon: Icon(Icons.notifications_none, color: Colors.white),
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
                        icon: Icon(Icons.settings_outlined, color: Colors.white),
                      ),

                    if (state.selectedIndex == 1)
                      IconButton(
                        onPressed: () {
                          router.push(AppRouter.challengeHistoryScreen);
                        },
                        icon: Icon(Icons.history, color: Colors.white),
                      ),

                    if (state.selectedIndex == 2)
                      IconButton(
                        onPressed: () {
                          router.push(AppRouter.searchPlayerScreen);
                        },
                        icon: Icon(Icons.person_add_alt, color: Colors.white),
                      ),
                    IconButton(
                      onPressed: () {
                        router.push(AppRouter.notificationsScreen);
                      },
                      icon: Icon(Icons.notifications_none, color: Colors.white),
                    ),
                  ],
                ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(margin: EdgeInsets.only(bottom: 65), child: widget.child),
              GameBottomNavigation(
                onTap: (index) {
                  cubitData.onTapBottomBar(index);
                },
                currentIndex: state.selectedIndex ?? 0,
              ),
            ],
          ),
        );
      },
    );
  }
}
