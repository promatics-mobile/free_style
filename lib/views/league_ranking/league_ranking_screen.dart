import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/utils/common_widgets/app_bars/custom_app_bar.dart';
import '../../generated/assets.dart';

class LeagueRankingScreen extends StatelessWidget {
  const LeagueRankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeDarkColor,
      appBar: CustomAppBar(
        title: "League Ranking",
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLeagueCard(context, isUnclassified: false), // Set to true for the "n/a" state
            Padding(
              padding: EdgeInsets.all(size(context).width * numD04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    text: "RP History",
                    fontSize: size(context).width * numD05,
                    fontWeight: FontWeight.bold,
                  ),
                  CommonText(
                    text: "All Matches",
                    color: CommonColors.secondaryColor,
                    fontSize: size(context).width * numD04,
                  ),
                ],
              ),
            ),
            _buildHistoryList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLeagueCard(BuildContext context, {bool isUnclassified = false}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(size(context).width * numD04),
      padding: EdgeInsets.all(size(context).width * numD06),
      decoration: commonBgColorDecoration(
        size(context).width * numD05,
        CommonColors.secondaryColor,
      ),
      child: Column(
        children: [
          // Badge Icon
          Container(
            width: size(context).width * numD20,
            height: size(context).width * numD20,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black.withOpacity(0.1), width: 8),
            ),
            child: Icon(
              isUnclassified ? Icons.help_outline : Icons.shield_outlined,
              color: Colors.white,
              size: size(context).width * numD1,
            ),
          ),
          SizedBox(height: size(context).width * numD04),
          
          // RP Value
          CommonText(
            text: isUnclassified ? "n/a" : "1,450 RP",
            color: Colors.black,
            fontSize: size(context).width * numD08,
            fontWeight: FontWeight.bold,
          ),
          
          // League Name
          CommonText(
            text: isUnclassified ? "UNCLASSIFIED" : "GOLD LEAGUE II",
            color: Colors.black,
            fontSize: size(context).width * numD04,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: size(context).width * numD06),
          
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: isUnclassified ? 0.6 : 0.4,
              minHeight: 12,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          SizedBox(height: size(context).width * numD02),
          
          // Next Tier Text
          CommonText(
            text: isUnclassified 
              ? "3 of 5 Placement Matches Completed"
              : "50 RP to Gold League I",
            color: Colors.black,
            fontSize: size(context).width * numD035,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    final history = [
      {"name": "@NeonNinja", "time": "Today, 14:30", "rp": "+25RP", "status": "Victory", "color": Colors.blue},
      {"name": "@Cryptoking", "time": "Yesterday, 14:30", "rp": "-15RP", "status": "Defeat", "color": Colors.red},
      {"name": "@ViperStrike", "time": "Oct 12, 14:30", "rp": "+30RP", "status": "Victory", "color": Colors.blue},
      {"name": "@NeonNinja", "time": "Oct 15, 10:35", "rp": "-25RP", "status": "Victory", "color": Colors.red},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
      itemCount: history.length,
      separatorBuilder: (context, index) => SizedBox(height: size(context).width * numD03),
      itemBuilder: (context, index) {
        final item = history[index];
        return Container(
          padding: EdgeInsets.all(size(context).width * numD04),
          decoration: commonBgColorDecoration(
            size(context).width * numD04,
            Colors.white,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: size(context).width * numD06,
                backgroundImage: const AssetImage(Assets.assetsIcDummyUser1),
              ),
              SizedBox(width: size(context).width * numD04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: item["name"] as String,
                      color: Colors.black,
                      fontSize: size(context).width * numD04,
                      fontWeight: FontWeight.bold,
                    ),
                    CommonText(
                      text: item["time"] as String,
                      color: Colors.grey,
                      fontSize: size(context).width * numD03,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonText(
                    text: item["rp"] as String,
                    color: item["color"] as Color,
                    fontSize: size(context).width * numD04,
                    fontWeight: FontWeight.bold,
                  ),
                  CommonText(
                    text: item["status"] as String,
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

void showPromotionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: size(context).width * numD06),
      child: Container(
        padding: EdgeInsets.all(size(context).width * numD06),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size(context).width * numD05),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Promotion Icon
            Container(
              width: size(context).width * numD25,
              height: size(context).width * numD25,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: size(context).width * numD15,
                  height: size(context).width * numD15,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: size(context).width * numD08,
                  ),
                ),
              ),
            ),
            SizedBox(height: size(context).width * numD06),
            
            const CommonText(
              text: "Promoted!",
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: size(context).width * numD02),
            
            CommonText(
              text: "Congratulations! You've successfully climbed the ranks to a new division",
              color: Colors.grey.shade600,
              fontSize: size(context).width * numD04,
              textAlign: TextAlign.center,
              height: 1.4,
            ),
            SizedBox(height: size(context).width * numD06),
            
            // Division Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(size(context).width * numD06),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(size(context).width * numD04),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.emoji_events_outlined,
                    color: Colors.blue,
                    size: size(context).width * numD1,
                  ),
                  SizedBox(height: size(context).width * numD02),
                  CommonText(
                    text: "Gold Division II",
                    color: Colors.black,
                    fontSize: size(context).width * numD06,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            SizedBox(height: size(context).width * numD08),
            
            CommonGradientButton(
              text: "Claim Rewards",
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: size(context).width * numD04),
            
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                height: size(context).width * numD15,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size(context).width * numD03),
                  border: Border.all(color: Colors.blue),
                ),
                child: const CommonText(
                  text: "View Battle History",
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
