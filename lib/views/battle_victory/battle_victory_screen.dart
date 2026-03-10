import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_methods.dart';
import '../../utils/common_widgets/common_button/common_button.dart';

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
              SizedBox(height: size(context).width * numD08),

              SizedBox(
                 width: size(context).width * numD60,
                 height: size(context).width * numD60,
                 child: Center(
                   child: Image.asset(
                     Assets.iconsIcVictoryTrophy,
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


              CommonButton(onTap: (){
                router.push(AppRouter.challengeHistoryScreen);

              }, text: "View Battle History"),
              SizedBox(height: size(context).width * numD04),
              CommonGradientButton(
                text: "Return the Base",
                onTap: () {
                  router.go(AppRouter.dashboardScreen,extra: 0);
                },
              ),

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

}
