import 'package:flutter/material.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';

import '../../utils/common_constants.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return FaqsState();
  }
}

class FaqsState extends State<FaqsScreen> {
  final List<Map<String, String>> faqData = [
    {
      "question": "How do I earn Ranking Points (RP)?",
      "answer": "You can earn RP by winning battles against other players in the arena. Winning a match typically grants you +25 to +50 RP depending on your opponent's rank."
    },
    {
      "question": "What are Daily Missions?",
      "answer": "Daily Missions are set tasks refreshed every 24 hours. Completing them rewards you with XP and Battle Coins which can be used in the Shop."
    },
    {
      "question": "How do I submit a skill challenge like 'Technical Trio'?",
      "answer": "Go to the Mission section, record a video of yourself performing the trick, and submit it for review. Our admins will verify it within 2 hours."
    },
    {
      "question": "How can I level up to a new League?",
      "answer": "As you accumulate RP, you will automatically climb the divisions. Once you reach the RP threshold for your current league (e.g., Gold II), you'll be promoted to the next tier."
    },
    {
      "question": "What happens if my challenge submission is rejected?",
      "answer": "If a video is rejected (e.g., due to poor lighting), you will see an error message in your Challenge History. You can retry the challenge immediately after fixing the issue."
    },
    {
      "question": "Where can I find my purchased Balls and Outfits?",
      "answer": "All your purchased items are stored in the 'Inventory' section, accessible from your Profile. From there, you can equip or change your gear."
    },
    {
      "question": "How do I challenge a specific friend to a battle?",
      "answer": "Navigate to the Social tab, find your friend's profile using the search bar, and tap the 'Challenge' button to send them a 1v1 battle request."
    },
    {
      "question": "What are 'Battle Coins' used for?",
      "answer": "Battle Coins are the primary currency in Free Style. You can use them in the Shop to unlock new ball skins, outfits, and special emotes."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "FAQs", showBack: true),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: size(context).width * numD04,
          horizontal: size(context).width * numD04,
        ),
        itemBuilder: (context, index) {
          final faq = faqData[index];
          return Container(
            decoration: commonOutlineDecoration(
              size(context).width * numD03,
              1,
              Colors.white.withOpacity(0.2),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: CommonColors.secondaryColor,
                collapsedIconColor: Colors.white,
                leading: Container(
                  decoration: commonBgColorDecoration(size(context).width * numD01, Colors.white),
                  width: size(context).width * numD08,
                  height: size(context).width * numD08,
                  alignment: Alignment.center,
                  child: CommonText(
                    text: "Q",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: size(context).width * numD045,
                  ),
                ),
                title: CommonText(
                  text: faq["question"]!,
                  maxLines: 3,
                  fontWeight: FontWeight.w500,
                  fontSize: size(context).width * numD04,
                ),
                expandedAlignment: Alignment.centerLeft,
                childrenPadding: EdgeInsets.symmetric(
                  horizontal: size(context).width * numD04,
                ),
                children: [
                  CommonText(
                    text: faq["answer"]!,
                    fontSize: size(context).width * numD035,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.4,
                  ),
                  SizedBox(height: size(context).width * numD04),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: size(context).width * numD04);
        },
        itemCount: faqData.length,
      ),
    );
  }
}