import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';
import 'package:free_style/utils/common_widgets/linear_progress_indicator/custom_linear_progress.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Missions",actions: [
        IconButton(onPressed: (){
          router.push(AppRouter.challengeHistoryScreen);

        }, icon: Icon(Icons.history,color: Colors.white,))

      ],),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(
              height: size(context).width * numD09,
              width: size(context).width,
              child: ListView.builder(
                itemCount: ["All", "Basics", "Upper", "Lower", "Ground"].length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, idx) {
                  var item = ["All", "Basics", "Upper", "Lower", "Ground"][idx];
                  return Container(
                    decoration: commonBgColorDecoration(
                      size(context).width * numD05,

                      idx == 0
                          ? CommonColors.secondaryColor
                          : CommonColors.themeDarkColor,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: size(context).width * numD04,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: size(context).width * numD02,
                    ),
                    alignment: Alignment.center,
                    child: CommonText(
                      text: item,
                      color: idx == 0 ? Colors.black : Colors.white,
                      fontSize: size(context).width * numD035,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: size(context).width * numD04),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    CommonText(
                      text: "Saved Sessions",
                      fontSize: size(context).width * numD04,
                      fontWeight: .bold,
                    ),
                    SizedBox(height: size(context).width * numD02),
                    ListView.builder(
                      itemCount: [
                        "ATW Endurance",
                        "Precision Strike",
                        "Infinite Juggles",
                        "ATW Endurance",
                      ].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, idx) {
                        var item = [
                          "ATW Endurance",
                          "Precision Strike",
                          "Infinite Juggles",
                          "ATW Endurance",
                        ][idx];
                        return InkWell(
                          onTap: () {
                            //router.push(AppRouter.tutorialDetailScreen);
                          },
                          child: Container(
                            decoration: commonBgColorDecoration(
                              size(context).width * numD03,
                              Colors.white,
                            ),
                            padding: EdgeInsets.all(
                              size(context).width * numD02,
                            ),
                            margin: EdgeInsets.only(
                              bottom: size(context).width * numD02,
                            ),

                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        size(context).width * numD02,
                                      ),
                                      child: Container(
                                        decoration: commonCircularFill(
                                          color:
                                              CommonColors.secondaryLightColor,
                                        ),
                                        padding: EdgeInsets.all(
                                          size(context).width * numD01,
                                        ),
                                        child: CommonImage(
                                          imagePath: Assets.iconsIcFilterHori,
                                          width: size(context).width * numD07,
                                          height: size(context).width * numD07,
                                          isNetwork: false,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size(context).width * numD02,
                                    ),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: .start,
                                        children: [
                                          CommonText(
                                            text: item,
                                            color: Colors.black,
                                            fontWeight: .w500,
                                            fontSize:
                                                size(context).width * numD04,
                                          ),
                                          CommonText(
                                            text: "Around the World",
                                            color: Colors.grey,

                                            fontSize:
                                                size(context).width * numD035,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size(context).width * numD02),
                                CommonText(
                                  text:
                                      "Complete 20 consecutive Around the Worlds without dropping the ball.",
                                  fontSize: size(context).width * numD035,
                                  color: Colors.black,
                                ),
                                SizedBox(height: size(context).width * numD02),
                                if (idx.isEven)
                                  Row(
                                    mainAxisAlignment: .spaceBetween,
                                    children: [
                                      CommonText(
                                        text: "Progress",
                                        fontSize: size(context).width * numD035,
                                        color: Colors.black,
                                      ),
                                      CommonText(
                                        text: "12 / 20",
                                        fontSize: size(context).width * numD035,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                SizedBox(height: size(context).width * numD02),
                                if (idx.isEven)
                                  commonNormalLinearProgress(
                                    context: context,
                                    value: 0.5,
                                    bgColor: Colors.grey,
                                    valueColor: CommonColors.secondaryColor,
                                  ),
                                SizedBox(height: size(context).width * numD02),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.electric_bolt,
                                            color: CommonColors.secondaryColor,
                                          ),
                                          SizedBox(
                                            width: size(context).width * numD02,
                                          ),
                                          CommonText(
                                            text: "+1,250 XP",
                                            color: Colors.black,
                                            fontWeight: .w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: commonShortButton(
                                        onTap: () {
                                          //router.push(AppRouter.submitProofScreen);

                                        },
                                        size: size(context),
                                        buttonHeight: size(context).width * numD1,
                                        buttonText: idx.isEven
                                            ? "Start"
                                            : "Resume",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: size(context).width * numD04),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
