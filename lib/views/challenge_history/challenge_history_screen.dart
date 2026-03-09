import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';

class ChallengeHistoryScreen extends StatelessWidget {
  const ChallengeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeColor,
      appBar: const CommonAppBar(title: "Challenge History"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size(context).width * numD04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTodayChallenge(context),
            SizedBox(height: size(context).width * numD05),
            CommonText(
              text: "Past Challenge",
              fontSize: size(context).width * numD04,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: size(context).width * numD04),
            _buildPastChallengesList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayChallenge(BuildContext context) {
    return Container(
      width: size(context).width,
      padding: EdgeInsets.all(size(context).width * numD04),
      decoration: commonBgColorDecoration(
        size(context).width * numD04,
        Colors.white,
      ),
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
                      Icons.access_time,
                      size: size(context).width * numD035,
                      color: Colors.orange,
                    ),
                    SizedBox(width: size(context).width * numD01),
                    CommonText(
                      text: "In Review",
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
            text: "Technical Trio",
            color: Colors.black,
            fontSize: size(context).width * numD055,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: size(context).width * numD02),
          Row(
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
                    Icon(
                      Icons.bolt,
                      size: size(context).width * numD035,
                      color: Colors.blue,
                    ),
                    CommonText(
                      text: "+150 XP",
                      color: Colors.blue,
                      fontSize: size(context).width * numD03,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              SizedBox(width: size(context).width * numD02),
              const CommonText(
                text: "• Blue Tier Combo",
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: size(context).width * numD06),
          _buildProgressStepper(context),
          SizedBox(height: size(context).width * numD04),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: size(context).width * numD04,
                color: Colors.grey,
              ),
              SizedBox(width: size(context).width * numD01),
              const CommonText(
                text: "Estimated review time: < 2 hours",
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStepper(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStepIcon(context, Icons.check, Colors.green, true),
            Expanded(child: _buildConnector(context, true)),
            _buildStepIcon(context, Icons.star_border, Colors.blue, false),
            Expanded(child: _buildConnector(context, false)),
            _buildStepIcon(context, Icons.assignment_outlined, Colors.orange, false),
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
    return Container(
      height: 2,
      color: isActive ? Colors.grey.shade300 : Colors.grey.shade200,
    );
  }

  Widget _buildPastChallengesList(BuildContext context) {
    final List<Map<String, dynamic>> challenges = [
      {
        "date": "24",
        "month": "OCT",
        "title": "Around the World",
        "xp": "Earned 50 XP",
        "icon": Icons.check,
        "iconColor": Colors.green,
        "status": "success",
      },
      {
        "date": "23",
        "month": "OCT",
        "title": "Around the World",
        "xp": "No Reward",
        "icon": Icons.close,
        "iconColor": Colors.red,
        "status": "failed",
        "error": "Video was too dark. Please ensure good lighting.",
      },
      {
        "date": "22",
        "month": "OCT",
        "title": "Header Stall",
        "xp": "Missed",
        "icon": Icons.remove,
        "iconColor": Colors.grey,
        "status": "missed",
      },
      {
        "date": "21",
        "month": "OCT",
        "title": "Basic Juggling",
        "xp": "Earned 30 XP",
        "icon": Icons.check,
        "iconColor": Colors.green,
        "status": "success",
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: challenges.length,
      separatorBuilder: (context, index) => SizedBox(height: size(context).width * numD04),
      itemBuilder: (context, index) {
        final challenge = challenges[index];
        return Container(
          decoration: commonBgColorDecoration(
            size(context).width * numD04,
            Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(size(context).width * numD04),
                child: Row(
                  children: [
                    Column(
                      children: [
                        CommonText(
                          text: challenge["date"],
                          color: Colors.black,
                          fontSize: size(context).width * numD05,
                          fontWeight: FontWeight.bold,
                        ),
                        CommonText(
                          text: challenge["month"],
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
                            text: challenge["title"],
                            color: Colors.black,
                            fontSize: size(context).width * numD045,
                            fontWeight: FontWeight.bold,
                          ),
                          CommonText(
                            text: challenge["xp"],
                            color: challenge["status"] == "failed" ? Colors.red : Colors.grey,
                            fontSize: size(context).width * numD035,
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: size(context).width * numD04,
                      backgroundColor: challenge["iconColor"].withOpacity(0.1),
                      child: Icon(
                        challenge["icon"],
                        color: challenge["iconColor"],
                        size: size(context).width * numD05,
                      ),
                    ),
                  ],
                ),
              ),
              if (challenge["error"] != null)
                Container(
                  margin: EdgeInsets.all(size(context).width * numD02),
                  padding: EdgeInsets.all(size(context).width * numD03),
                  decoration: commonBgColorDecoration(
                    size(context).width * numD02,
                    const Color(0xFFFFF1F0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.red,
                        size: size(context).width * numD05,
                      ),
                      SizedBox(width: size(context).width * numD02),
                      Expanded(
                        child: CommonText(
                          text: challenge["error"],
                          color: Colors.red,
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
