import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_widgets/common_button/common_button.dart';

class ChallengeApprovedScreen extends StatelessWidget {
  const ChallengeApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeDarkColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size(context).width * numD06),
          child: Column(
            children: [
              const Spacer(flex: 3),
              
              // Trophy Icon in White Circle
              Container(
                width: size(context).width * numD25,
                height: size(context).width * numD25,
                decoration: commonCircularFill(color: Colors.white),
                padding: EdgeInsets.all(size(context).width * numD07),
                child: Image.asset(
                  Assets.iconsIcTrophy,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: size(context).width * numD08),

              // Title
              CommonText(
                text: "Challenge Approved!",
                fontSize: size(context).width * numD075,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size(context).width * numD04),

              // Subtitle
              CommonText(
                text: 'Your submission for "Technical Trio" has been verified. Rewards have been added to your wallet.',
                fontSize: size(context).width * numD04,
                color: Colors.white.withOpacity(0.8),
                textAlign: TextAlign.center,
                height: 1.5,
              ),
              const Spacer(flex: 2),

              // Rewards Card
              Container(
                width: double.infinity,
                decoration: commonBgColorDecoration(
                  size(context).width * numD04,
                  Colors.white,
                ),
                child: Column(
                  children: [
                    _rewardItem(
                      context,
                      icon: Icons.bolt,
                      iconColor: Colors.orange.shade300,
                      title: "Experience",
                      subtitle: "Level progress",
                      value: "+150 XP",
                      valueColor: Colors.green,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size(context).width * numD05),
                      child: Divider(height: 1, color: Colors.grey.shade200),
                    ),
                    _rewardItem(
                      context,
                      icon: Icons.toll,
                      iconColor: Colors.orange.shade300,
                      title: "Coins",
                      subtitle: "Currency",
                      value: "+50",
                      valueColor: Colors.green,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size(context).width * numD06),

              // Balance Section
              _buildBalanceSection(context),

              const Spacer(flex: 4),

              // Continue Button
              CommonButton(
                text: "Continue",
                onTap: () {
                 router.go(AppRouter.dashboardScreen);
                },
              ),
              SizedBox(height: size(context).width * numD06),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rewardItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String value,
    required Color valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.all(size(context).width * numD05),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(size(context).width * numD02),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: size(context).width * numD06),
          ),
          SizedBox(width: size(context).width * numD03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: title,
                  color: Colors.black,
                  fontSize: size(context).width * numD045,
                  fontWeight: FontWeight.bold,
                ),
                CommonText(
                  text: subtitle,
                  color: Colors.grey.shade500,
                  fontSize: size(context).width * numD03,
                ),
              ],
            ),
          ),
          CommonText(
            text: value,
            color: valueColor,
            fontSize: size(context).width * numD04,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size(context).width * numD04,
        horizontal: size(context).width * numD02,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24, width: 1.5),
        borderRadius: BorderRadius.circular(size(context).width * numD04),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _balanceItem(
                context,
                label: "NEW BALANCE",
                value: "2,450 XP",
                icon: Icons.bolt,
                iconColor: Colors.orange.shade300,
              ),
            ),
            VerticalDivider(color: Colors.white24, thickness: 1.5, indent: 5, endIndent: 5),
            Expanded(
              child: _balanceItem(
                context,
                label: "NEW BALANCE",
                value: "820",
                icon: Icons.toll,
                iconColor: Colors.orange.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _balanceItem(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      children: [
        CommonText(
          text: label,
          fontSize: size(context).width * numD028,
          color: Colors.white.withOpacity(0.6),
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: size(context).width * numD02),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: size(context).width * numD045),
            SizedBox(width: size(context).width * numD015),
            CommonText(
              text: value,
              fontSize: size(context).width * numD04,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ],
    );
  }
}
