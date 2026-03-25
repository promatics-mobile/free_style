import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_methods.dart';
import 'package:free_style/utils/common_widgets/common_image/common_image.dart';
import 'package:free_style/utils/common_widgets/common_refresh_indicator/common_refresh_indicator.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/utils/common_widgets/app_bars/custom_app_bar.dart';
import 'package:free_style/utils/common_widgets/text_form_field/common_text_form_field.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/views/global_lead_board/global_lead_board_cubit.dart';
import '../../generated/assets.dart';
import '../../main.dart';
import '../../routes/route.dart';
import '../../utils/common_widgets/common_button/common_button.dart';

class GlobalLeadBoardScreen extends StatefulWidget {
  const GlobalLeadBoardScreen({super.key});

  @override
  State<GlobalLeadBoardScreen> createState() => _GlobalLeadBoardScreenState();
}

class _GlobalLeadBoardScreenState extends State<GlobalLeadBoardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeDarkColor,
      appBar: CustomAppBar(
        title: "Global Leaderboard",
        actions: [
          /*IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              router.push(AppRouter.leagueRankingScreen);
            },
          ),*/
        ],
      ),
      body: BlocBuilder<GlobalLeadBoardCubit, GlobalLeadBoardState>(
        builder: (context, state) {
          var cubit = context.read<GlobalLeadBoardCubit>();
          return Column(
            children: [

              /// Search Bar
              Padding(
                padding: EdgeInsets.all(size(context).width * numD04),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: commonBgColorDecoration(
                          size(context).width * numD02,
                          Colors.white,
                        ),
                        child: CommonTextFormField(
                          controller: cubit.searchController,
                          hint: "Search by user name",
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(size(context).width * numD03),
                            child: Icon(Icons.search, color: Colors.grey.shade400),
                          ),
                          borderRadius: BorderRadius.circular(size(context).width * numD02),
                          onChanged: (value) {
                            cubit.debouncer.run(() {
                              cubit.callGlobalLeaderBoardApi(true);
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: size(context).width * numD03),
                    InkWell(
                      onTap: () => _showFilterBottomSheet(context,cubit),
                      borderRadius: BorderRadius.circular(size(context).width * numD02),
                      child: Container(
                        padding: EdgeInsets.all(size(context).width * numD02),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.blue.shade800, width: 1.5),
                          borderRadius: BorderRadius.circular(size(context).width * numD02),
                        ),
                        child: Icon(Icons.tune, color: Colors.white, size: size(context).width *
                            numD06),
                      ),
                    ),
                  ],
                ),
              ),

              /// Leaderboard List
              Expanded(
                child: _buildLeaderboardList(cubit),
              ),
            ],
          );
        },
      ),
    );
  }


  Widget _buildLeaderboardList(GlobalLeadBoardCubit cubit) {
    return CommonRefreshIndicator(
      onRefresh: () async {
        cubit.callGlobalLeaderBoardApi(true);
      },
      onLoadMore: () async {
        cubit.callGlobalLeaderBoardApi(false);
      },
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(size(context).width * numD04),
        itemCount: cubit.globalLeaderBoardList.length,
        separatorBuilder: (context, index) => SizedBox(height: size(context).width * numD03),
        itemBuilder: (context, index) {
          final player = cubit.globalLeaderBoardList[index];
          return InkWell(
            onTap: () {
              if(player.id == sharedPreferences.getString(PreferenceKeys.userIdKey)){
                return;
              }

              router.push(AppRouter.otherProfileScreen, extra: {"userId": player.id});
            },
            child: Container(
              padding: EdgeInsets.all(size(context).width * numD04),
              decoration: commonBgColorDecoration(
                size(context).width * numD04,
                Colors.white,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: size(context).width * numD08,
                    child: CommonText(
                      text: player.rank.toString(),
                      color: Colors.black,
                      fontSize: size(context).width * numD045,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: size(context).width * numD02),
                  CircleAvatar(
                    radius: size(context).width * numD07,
                    backgroundColor: Colors.green,
                    child: CircleAvatar(
                      radius: size(context).width * numD065,
                      child:
                      player.avatar != null ?
                      ClipOval(child: CommonImage(imagePath: player.avatar!.picture!.first.fullPath,
                        isNetwork: true,)) :
                      Center(
                        child: Icon(
                          Icons.account_circle_rounded,
                          color: CommonColors.greyColor,
                          size: size(context).width * numD1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size(context).width * numD04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: player.username,
                          color: Colors.black,
                          fontSize: size(context).width * numD04,
                          fontWeight: FontWeight.bold,
                        ),
                        Row(
                          children: [
                            Icon(Icons.emoji_events_outlined, color: Colors.orange.shade300,
                                size: size(context).width * numD035),
                            SizedBox(width: size(context).width * numD01),
                            CommonText(
                              text: player.league.toString().toCapitalize(),
                              color: Colors.grey.shade500,
                              fontSize: size(context).width * numD03,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CommonText(
                    text: "${player.rp} RP",
                    color: Colors.black,
                    fontSize: size(context).width * numD045,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context, GlobalLeadBoardCubit cubit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider.value(value: cubit, child:
           BlocBuilder<GlobalLeadBoardCubit, GlobalLeadBoardState>(
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.all(size(context).width * numD06),
                decoration: commonWhiteDecorationTopOnly(size(context), numD08),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: "Filter",
                          color: Colors.black,
                          fontSize: size(context).width * numD055,
                          fontWeight: FontWeight.bold,
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: size(context).width * numD04),

                    // Time Range Section
                    CommonText(
                      text: "League",
                      color: Colors.black,
                      fontSize: size(context).width * numD04,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: size(context).width * numD03),
                    Wrap(
                      spacing: size(context).width * numD03,
                      runSpacing: size(context).width * numD02,
                      children: List.generate(cubit.leagueList.length, (idx){
                        var item = cubit.leagueList[idx];
                        return GestureDetector(
                          onTap: () {
                            cubit.onSelectLeague(idx);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size(context).width * numD04,
                              vertical: size(context).width * numD02,
                            ),
                            decoration: BoxDecoration(
                              color: item.isSelected ? CommonColors.themeColor : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(size(context).width * numD02),
                              border: Border.all(
                                color: item.isSelected ? CommonColors.themeColor : Colors.grey.shade300,
                              ),
                            ),
                            child: CommonText(
                              text: item.name.toString().toCapitalize(),
                              color: item.isSelected ? Colors.white : Colors.black,
                              fontSize: size(context).width * numD035,
                            ),
                          ),
                        );
                      })
                    ),

                    SizedBox(height: size(context).width * numD1),

                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            text: "Clear Filter",
                            onTap: () {
                              Navigator.pop(context);
                              cubit.onResetFilter();

                            },
                          ),
                        ),
                        SizedBox(width: size(context).width * numD02),
                        Expanded(
                          child: CommonGradientButton(
                            text: "Apply Filter",
                            onTap: () {
                              Navigator.pop(context);
                              cubit.callGlobalLeaderBoardApi(true);
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: size(context).width * numD04),
                  ],
                ),
              );
            },
          ));
        });
  }



}


