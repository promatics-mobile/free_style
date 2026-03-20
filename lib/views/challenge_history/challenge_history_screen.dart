import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_methods.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_refresh_indicator/common_refresh_indicator.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/views/challenge_history/challenge_history_cubit.dart';

import '../../generated/assets.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../dialy_challenge/daily_challenge_cubit.dart';

class ChallengeHistoryScreen extends StatelessWidget {
  const ChallengeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeColor,
      appBar: const CommonAppBar(title: "Challenge History"),
      body: BlocBuilder<ChallengeHistoryCubit, ChallengeHistoryState>(
        builder: (context, state) {
          var cubit = context.read<ChallengeHistoryCubit>();
          return CommonRefreshIndicator(
            onRefresh: () async {
              cubit.callDailyChallengeHistoryApi(isRefresh: true);
            },
            onLoadMore: () async {
              cubit.callDailyChallengeHistoryApi();
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.all(size(context).width * numD04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(cubit.currentChallengeModel !=null)
                  _buildTodayChallenge(context,cubit),
                  if(cubit.currentChallengeModel !=null)
                  SizedBox(height: size(context).width * numD05),
                  CommonText(
                    text: "Past Challenge",
                    fontSize: size(context).width * numD04,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: size(context).width * numD04),
                  _buildPastChallengesList(context, cubit),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTodayChallenge(BuildContext context, ChallengeHistoryCubit cubit) {
    var statusUI = getStatusUI(cubit.currentChallengeModel!.submission!.status);
    return Container(
      width: size(context).width,
      padding: EdgeInsets.all(size(context).width * numD04),
      decoration: commonBgColorDecoration(size(context).width * numD04, Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: "TODAY'S CHALLENGE",
                color: Colors.grey,
                fontSize: size(context).width * numD03,
                fontWeight: FontWeight.bold,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size(context).width * numD03,
                  vertical: size(context).width * numD01,
                ),
                decoration: commonBgColorDecoration(
                  size(context).width * numD05,
                  const Color(0xFFFFF4E5),
                ),
                child: Row(
                  children: [

                    Icon(
                      statusUI.icon,
                      size: size(context).width * numD035,
                      color: statusUI.iconColor,
                    ),
                    SizedBox(width: size(context).width * numD01),
                    CommonText(
                      text: cubit.currentChallengeModel!.submission!.status.toCapitalize(),
                      color: Colors.orange,
                      fontSize: size(context).width * numD03,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: size(context).width * numD02),
          CommonText(
            text: cubit.currentChallengeModel!.skills.first.name,
            color: Colors.black,
            fontSize: size(context).width * numD055,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: size(context).width * numD02),
          Row(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size(context).width * numD02,
                      vertical: size(context).width * numD005,
                    ),
                    decoration: commonBgColorDecoration(
                      size(context).width * numD01,
                      const Color(0xFFF0F2FF),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.bolt, size: size(context).width * numD035, color: Colors.blue),
                        CommonText(
                          text: "+${cubit.currentChallengeModel!.rewards.xp} XP",
                          color: Colors.blue,
                          fontSize: size(context).width * numD03,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size(context).width * numD02),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size(context).width * numD02,
                      vertical: size(context).width * numD005,
                    ),
                    decoration: commonBgColorDecoration(
                      size(context).width * numD01,
                      CommonColors.secondaryLightColor,
                    ),
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
                          text: "+${cubit.currentChallengeModel!.rewards.coin} Coins",
                          color: Colors.black,
                          fontSize: size(context).width * numD03,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(width: size(context).width * numD02),
              CommonText(text: "• ${cubit.currentChallengeModel!.tier.name}",
                  fontSize: size(context).width * numD03,
                  color: Colors.grey),
            ],
          ),
          SizedBox(height: size(context).width * numD06),
          _buildProgressStepper(context,cubit),
          SizedBox(height: size(context).width * numD04),
        ],
      ),
    );
  }

  Widget _buildProgressStepper(BuildContext context, ChallengeHistoryCubit cubit) {
    var status = cubit.currentChallengeModel!.submission!.status;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStepIcon(context, Icons.check, Colors.green, true),
            Expanded(child: _buildConnector(context, true)),
            _buildStepIcon(context,
                status == "review" ? Icons.check:
                Icons.star_border, Colors.blue, false),
            Expanded(child: _buildConnector(context, false)),
            _buildStepIcon(context,
                status == "approved" ?Icons.check:
                Icons.assignment_outlined, Colors.orange, false),
          ],
        ),
        SizedBox(height: size(context).width * numD02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size(context).width * numD20,
              child: CommonText(
                text: "Submitted",
                color: Colors.black,
                fontSize: size(context).width * numD025,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: size(context).width * numD20,
              child: CommonText(
                text: "Review",
                color: Colors.black,
                fontSize: size(context).width * numD025,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: size(context).width * numD20,
              child: CommonText(
                text: "Result",
                color: Colors.black,
                fontSize: size(context).width * numD025,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepIcon(BuildContext context, IconData icon, Color color, bool isCompleted) {
    return CircleAvatar(
      radius: size(context).width * numD05,
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, color: color, size: size(context).width * numD05),
    );
  }

  Widget _buildConnector(BuildContext context, bool isActive) {
    return Container(height: 2, color: isActive ? Colors.grey.shade300 : Colors.grey.shade200);
  }

  Widget _buildPastChallengesList(BuildContext context, ChallengeHistoryCubit cubit) {

    if(cubit.challengeHistoryList.isEmpty){
      return SizedBox(
          height: size(context).width,
          width: size(context).width,
          child: Center(child: CommonText(text: "No Data Found",)));
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cubit.challengeHistoryList.length,
      separatorBuilder: (context, index) => SizedBox(height: size(context).width * numD04),
      itemBuilder: (context, index) {
        final item = cubit.challengeHistoryList[index];
        final statusUI = getStatusUI(item.status);
        return Container(
          decoration: commonBgColorDecoration(size(context).width * numD04, Colors.white),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(size(context).width * numD04),
                child: Row(
                  children: [
                    Column(
                      children: [
                        CommonText(
                          text: cubit.getDay(item.createdAt),
                          color: Colors.black,
                          fontSize: size(context).width * numD05,
                          fontWeight: FontWeight.bold,
                        ),

                        CommonText(
                          text: cubit.getMonthShort(item.createdAt),
                          color: Colors.black,
                          fontSize: size(context).width * numD03,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(width: size(context).width * numD04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: item.type,
                            color: Colors.black,
                            fontSize: size(context).width * numD045,
                            fontWeight: FontWeight.bold,
                          ),
                          CommonText(
                            text: item.status.toCapitalize(),
                            color: item.status == "failed" ? Colors.red : Colors.grey,
                            fontSize: size(context).width * numD035,
                          ),
                        ],
                      ),
                    ),

                    CircleAvatar(
                      radius: size(context).width * numD04,
                      backgroundColor: statusUI.bgColor,
                      child: Icon(
                        statusUI.icon,
                        color: statusUI.iconColor,
                        size: size(context).width * numD05,
                      ),
                    ),
                  ],
                ),
              ),
              if (item.adminFeedback.toString().isNotEmpty)
                Container(
                  margin: EdgeInsets.all(size(context).width * numD02),
                  padding: EdgeInsets.all(size(context).width * numD03),
                  decoration: commonBgColorDecoration(
                    size(context).width * numD02,
                    statusUI.bgColor,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        statusUI.icon,
                        color: statusUI.iconColor,
                        size: size(context).width * numD05,
                      ),
                      SizedBox(width: size(context).width * numD02),
                      Expanded(
                        child: CommonText(
                          text: item.adminFeedback,
                          color: statusUI.iconColor,
                          fontSize: size(context).width * numD03,
                        ),
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
