import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/routes/route.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:universal_stepper/universal_stepper.dart';

import '../../generated/assets.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import 'daily_challenge_cubit.dart';

class DailyChallengeScreen extends StatelessWidget {
  const DailyChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyChallengeCubit, DailyChallengeState>(
      builder: (context, state) {
        var cubit = context.read<DailyChallengeCubit>();
        return Scaffold(
          appBar: CommonAppBar(
            title: "Daily Challenge",
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.calendar_today_outlined,color: Colors.white,),
              ),
            ],
          ),

          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: size(context).width * numD04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: commonBgColorDecoration(
                    size(context).width * numD04,
                    CommonColors.secondaryColor,
                  ),
                  padding: EdgeInsets.all(size(context).width * numD04),
                  width: size(context).width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Container(
                              decoration: commonBgColorDecoration(
                                size(context).width * numD04,
                                Colors.white,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: size(context).width * numD04,
                                vertical: size(context).width * numD02,
                              ),
                              child: Row(
                                mainAxisSize: .min,
                                children: [
                                  CommonImage(
                                    imagePath: Assets.iconsIcBadge,
                                    color: CommonColors.buttonColor,
                                    isNetwork: false,
                                    height: size(context).width * numD05,
                                    width: size(context).width * numD05,
                                  ),
                                  SizedBox(width: size(context).width * numD02),
                                  CommonText(
                                    text: "BLUE TIER",
                                    fontWeight: FontWeight.w500,
                                    color: CommonColors.buttonColor,
                                    fontSize: size(context).width * numD035,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size(context).width * numD02),
                            CommonText(
                              text: "Challenge Ends in",
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: size(context).width * numD035,
                            ),
                            CommonText(
                              text: "14h 32m",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: size(context).width * numD05,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: commonCircularFill(
                          color: Colors.grey.withValues(alpha: 0.4),
                        ),
                        padding: EdgeInsets.all(size(context).width * numD02),
                        child: Icon(
                          Icons.watch_later_outlined,
                          color: Colors.black,
                          size: size(context).width * numD1,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size(context).width * numD04),
                CommonText(
                  text: "Trick Sequence",
                  fontWeight: FontWeight.bold,
                  fontSize: size(context).width * numD04,
                ),

                SizedBox(height: size(context).width * numD04),

                UniversalStepper(
                  inverted: false,
                  stepperDirection: Axis.vertical,
                  elementBuilder: (context, index) {
                    var item = cubit.stepData[index];
                    return Expanded(
                      child: Container(
                        decoration: commonOutlineDecoration(
                          size(context).width * numD02,
                          1,
                          Colors.grey.shade800,
                        ),
                        padding: EdgeInsets.all(size(context).width * numD03),
                        margin: EdgeInsets.only(
                          bottom: size(context).width * numD04,
                          left: size(context).width * numD04,
                          right: size(context).width * numD04,
                        ),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text: item.title,
                                    fontSize: size(context).width * numD04,
                                  ),
                                  CommonText(
                                    text: item.subtitle,
                                    color: Colors.grey,
                                    fontSize: size(context).width * numD035,
                                  ),
                                ],
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                router.push(AppRouter.tutorialVideoDetailScreen);
                              },
                              icon: Container(
                                decoration: commonCircularFill(
                                  color: Colors.grey.shade800,
                                ),
                                padding: EdgeInsets.all(
                                  size(context).width * numD03,
                                ),
                                child: CommonImage(
                                  imagePath: Assets.iconsIcPlay,
                                  isNetwork: false,
                                  width: size(context).width * numD05,
                                  height: size(context).width * numD05,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  badgeBuilder: (context, index) {
                    var item = cubit.stepData[index];
                    return Container(
                      width: size(context).width * numD09,
                      height: size(context).width * numD09,
                      padding: EdgeInsets.all(size(context).width * numD02),
                      decoration: BoxDecoration(
                        color: CommonColors.themeDarkColor,
                        border: Border.all(color: CommonColors.buttonColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(size(context).width * numD07),
                        ),
                      ),
                      child: FittedBox(
                        child: CommonText(
                          text: "${index + 1}",
                          color: CommonColors.buttonColor,
                        ),
                      ),
                    );
                  },
                  pathBuilder: (context, index) {
                    return Container(
                      color: index == cubit.stepData.length - 1
                          ? Colors.transparent
                          : CommonColors.buttonColor.withValues(alpha: 0.2),
                      width: size(context).width * numD005,
                      height: size(context).width * numD1,
                    );
                  },
                  subPathBuilder: (context, index) {
                    return Container(
                      color: index == cubit.stepData.length - 1
                          ? Colors.transparent
                          : CommonColors.buttonColor.withValues(alpha: 0.2),
                      width: size(context).width * numD005,
                      height: size(context).width * numD1,
                    );
                  },
                  elementCount: cubit.stepData.length,
                  badgePosition: StepperBadgePosition.start,
                ),

                SizedBox(height: size(context).width * numD04),

                Container(
                  decoration: commonOutlineDecoration(
                    size(context).width * numD02, 1, Colors.grey.shade800,
                  ),
                  padding: EdgeInsets.all(size(context).width * numD04),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info_outlined,
                        color: CommonColors.buttonColor,
                      ),
                      SizedBox(width: size(context).width * numD02),
                      Expanded(
                        child: CommonText(
                          text:
                              "Complete the sequence in one continuous take. Mistakes will require a restart. Good luck!",
                          fontSize: size(context).width * numD03,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size(context).width * numD1),

                Row(
                  children: [

                   Expanded(child: CommonButton(onTap: (){
                     router.push(AppRouter.matchMakingScreen);

                   }, text: "Attempt Challenge")),
                    SizedBox(width: size(context).width * numD02),
                   CommonGradientButton(text: "",
                       widget: SizedBox(
                           height: size(context).width * numD1,
                           width: size(context).width * numD15,
                           child: Icon(Icons.share_outlined,color: CommonColors.buttonColor,)),
                       onTap: (){})




                  ],
                ),

                SizedBox(height: size(context).width * numD1),
              ],
            ),
          ),
        );
      },
    );
  }
}
