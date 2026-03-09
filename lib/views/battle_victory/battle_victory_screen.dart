import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import '../../generated/assets.dart';

class BattleVictoryScreen extends StatelessWidget {
  const BattleVictoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeDarkColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size(context).width * numD06),
          child: Column(
            children: [
              SizedBox(height: size(context).width * numD04),
              // Top Notification Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(size(context).width * numD04),
                decoration: commonBgColorDecoration(
                  size(context).width * numD03,
                  Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(size(context).width * numD02),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.notifications_outlined, color: Colors.orange, size: size(context).width * numD05),
                    ),
                    SizedBox(width: size(context).width * numD04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonText(
                                text: "Battle Result Declared",
                                color: Colors.black,
                                fontSize: size(context).width * numD04,
                                fontWeight: FontWeight.bold,
                              ),
                              CommonText(
                                text: "Just now",
                                color: Colors.grey,
                                fontSize: size(context).width * numD03,
                              ),
                            ],
                          ),
                          SizedBox(height: size(context).width * numD01),
                          CommonText(
                            text: "Admin confirmed your victory in Sector 7 match. Rewards applied.",
                            color: Colors.grey.shade600,
                            fontSize: size(context).width * numD03,
                            height: 1.4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Trophy Image (Golden theme)
              Container(
                 width: size(context).width * numD60,
                 height: size(context).width * numD60,
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   border: Border.all(color: Colors.blue.withOpacity(0.3), width: 2, style: BorderStyle.solid),
                 ),
                 child: Center(
                   child: Image.asset(
                     Assets.iconsIcTrophy, // Replace with golden trophy image if available
                     width: size(context).width * numD50,
                     fit: BoxFit.contain,
                   ),
                 ),
              ),
              SizedBox(height: size(context).width * numD08),

              // Victory Text
              CommonText(
                text: "VICTORY!",
                fontSize: size(context).width * numD08,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size(context).width * numD02),
              CommonText(
                text: "You dominated the battlefield",
                fontSize: size(context).width * numD035,
                color: Colors.white.withOpacity(0.6),
                textAlign: TextAlign.center,
              ),
              const Spacer(),

              // Side-by-Side Reward Cards
              Row(
                children: [
                  Expanded(
                    child: _rewardCard(
                      context,
                      icon: Icons.track_changes_outlined,
                      label: "RANKING PTS",
                      value: "+45",
                    ),
                  ),
                  SizedBox(width: size(context).width * numD04),
                  Expanded(
                    child: _rewardCard(
                      context,
                      icon: Icons.toll_outlined,
                      label: "BATTLE COINS",
                      value: "+150",
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),

              // Bottom Buttons
              CommonGradientButton(
                text: "View Battle History",
                onTap: () {},
              ),
              SizedBox(height: size(context).width * numD04),
              _buildSecondaryButton(context, "Return the Base", () {}),
              SizedBox(height: size(context).width * numD06),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rewardCard(BuildContext context, {required IconData icon, required String label, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size(context).width * numD06),
      decoration: commonBgColorDecoration(
        size(context).width * numD04,
        Colors.white,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(size(context).width * numD02),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.black, size: size(context).width * numD06),
          ),
          SizedBox(height: size(context).width * numD04),
          CommonText(
            text: label,
            color: Colors.grey.shade400,
            fontSize: size(context).width * numD028,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: size(context).width * numD02),
          CommonText(
            text: value,
            color: Colors.black,
            fontSize: size(context).width * numD055,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size(context).width * numD15,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size(context).width * numD03),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.05),
            ],
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: CommonText(
          text: text,
          fontSize: size(context).width * numD04,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
