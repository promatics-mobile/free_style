import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_methods.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/utils/common_widgets/app_bars/custom_app_bar.dart';
import '../../generated/assets.dart';
import '../../routes/route.dart';

class VictoryScreen extends StatelessWidget {
  const VictoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeDarkColor,
      appBar: CustomAppBar(
        title: "Match Complete",
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size(context).width * numD06),
          child: Column(
            children: [
              const Spacer(),
              // Trophy Icon with Green Background
              Container(
                width: size(context).width * numD35,
                height: size(context).width * numD35,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: size(context).width * numD25,
                    height: size(context).width * numD25,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(size(context).width * numD05),
                      child: Image.asset(
                        Assets.iconsIcTrophy,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size(context).width * numD08),

              // Victory Title
              CommonText(
                text: "VICTORY!",
                fontSize: size(context).width * numD1,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size(context).width * numD04),

              // Description
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: size(context).width * numD04,
                    color: Colors.white.withOpacity(0.8),
                    fontFamily: fontFamily,
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(text: "You successfully defeated\n"),
                    TextSpan(
                      text: "@ShadowStriker",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const TextSpan(text: " in the arena."),
                  ],
                ),
              ),
              const Spacer(),

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
                      icon: Icons.workspace_premium_outlined,
                      iconColor: const Color(0xFFFBBF24),
                      title: "Ranking Points",
                      value: "+50 RP",
                      valueColor: const Color(0xFF10B981),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size(context).width * numD05),
                      child: Divider(height: 1, color: Colors.grey.shade200),
                    ),
                    _rewardItem(
                      context,
                      icon: Icons.toll_outlined,
                      iconColor: const Color(0xFFFBBF24),
                      title: "Reward Coins",
                      value: "+120",
                      valueColor: const Color(0xFF10B981),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),

              CommonButton(onTap: (){
                showToast(isError: false, message: "Reward Claimed successfully!");

              }, text: "Claim Rewards"),
              SizedBox(height: size(context).width * numD04),
              CommonGradientButton(
                text: "View Battle History",
                onTap: () {
                  router.push(AppRouter.challengeHistoryScreen);

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
              color: iconColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: size(context).width * numD06),
          ),
          SizedBox(width: size(context).width * numD04),
          Expanded(
            child: CommonText(
              text: title,
              color: Colors.black,
              fontSize: size(context).width * numD04,
              fontWeight: FontWeight.bold,
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

  Widget _buildOutlineButton(BuildContext context, String text, VoidCallback onTap) {
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
