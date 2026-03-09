import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_button/common_short_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import '../../utils/common_widgets/linear_progress_indicator/custom_linear_progress.dart';

class SubmitProofScreen extends StatelessWidget {
  const SubmitProofScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Submit Proof",actions: [
        IconButton(onPressed: (){
          router.push(AppRouter.challengeHistoryScreen);
        }, icon: Icon(Icons.history,color: Colors.white,))

      ],),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        child: Column(
          crossAxisAlignment: .start,
          children: [

            Container(
              decoration: commonOutlineDecoration(
                size(context).width * numD03,
                1,
                Colors.red,
              ),
              child: Container(
                decoration: commonBgColorDecoration(
                  size(context).width * numD03,
                  Colors.white,
                ),
                padding: EdgeInsets.all(
                  size(context).width * numD02,
                ),
                child: Row(
                  crossAxisAlignment: .start,
                  children: [
                    Icon(Icons.error_outline,color: Colors.red,),
                    SizedBox(
                      width: size(context).width * numD02,
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          CommonText(
                            text: "Previous Attempt Rejected",
                            color: Colors.red,
                            fontWeight: .w500,
                            fontSize:
                            size(context).width * numD04,
                          ),
                          CommonText(
                            text: "Video was too blurry and feet were cut off from the frame. Please ensure full body visibility.",
                            color: Colors.red,
                            fontSize:
                            size(context).width * numD035,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size(context).width * numD02),
            CommonText(
              text: "Mission",
              color: Colors.grey,
              fontSize: size(context).width * numD035,
            ),
            SizedBox(height: size(context).width * numD02),
            CommonText(
              text: "ATW Endurance",
              fontWeight: .bold,
              fontSize:
              size(context).width * numD04,
            ),

            CommonText(
              text: "Requirement: 20 consecutive Around the worlds",
              fontSize:
              size(context).width * numD035,
            ),
            SizedBox(height: size(context).width * numD04),

            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius:BorderRadius.all(
                    Radius.circular(size(context).width * numD02),
                  ),
                  child: CommonImage(
                    imagePath: Assets.assetsDummyPlay2,
                    width: size(context).width,
                    height: size(context).width/4,
                    isNetwork: false,
                    fit: BoxFit.cover,
                  ),
                ),

                Container(
                    width: size(context).width * numD15,
                    height: size(context).width * numD15,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size(context).width * numD1),
                      gradient:  LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.shade700,
                          Color(0xFF1F1C3A),
                          CommonColors.themeColor
                        ],
                        stops: const [
                          0.0,
                          0.8,
                          1.0,
                        ],
                      ),
                      border: Border.all(
                        color: CommonColors.buttonColor.withValues(alpha: 0.5),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: CommonColors.buttonColor.withValues(alpha: 0.3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(size(context).width * numD04),
                    child: CommonImage(imagePath: Assets.iconsIcPlay,
                      isNetwork: false,
                    )
                ),
              ],
            ),
            SizedBox(height: size(context).width * numD04),
            Row(
              children: [
                Expanded(child: CommonButton(onTap: (){
                  router.push(AppRouter.recordVideoScreen);
                }, text: "Re-record")),
                SizedBox(width:  size(context).width * numD04,),
                Expanded(child: CommonGradientButton(onTap: (){

                }, text: "Upload File")),
              ],
            ),
            SizedBox(height: size(context).width * numD04),
            Container(
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
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outlined,color: Colors.black,),
                          SizedBox(width: size(context).width * numD02),
                          CommonText(
                            text: "Submission Rules",
                            color: Colors.black,
                            fontWeight: .bold,
                            fontSize: size(context).width * numD04,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check,color: Colors.black,),
                          SizedBox(width: size(context).width * numD02),
                          Expanded(
                            child: CommonText(
                              text: "Ensure your entire body is visible in the frame.",
                              color: Colors.black,
                              fontSize:
                              size(context).width * numD035,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check,color: Colors.black,),
                          SizedBox(width: size(context).width * numD02),
                          Expanded(
                            child: CommonText(
                              text: "Video must be continuous (no cuts).",
                              color: Colors.black,
                              fontSize:
                              size(context).width * numD035,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check,color: Colors.black,),
                          SizedBox(width: size(context).width * numD02),
                          Expanded(
                            child: CommonText(
                              text: "Max length: 15 seconds.",
                              color: Colors.black,
                              fontSize:
                              size(context).width * numD035,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: size(context).width * numD02),
                  CommonText(
                    text: "Complete 20 consecutive Around the Worlds without dropping the ball.",
                    fontSize: size(context).width * numD035,
                    color: Colors.black,
                  ),
                  SizedBox(height: size(context).width * numD02),

                ],
              ),
            ),
            SizedBox(height: size(context).width * numD04),

            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: CommonButton(onTap: (){
                      router.push(AppRouter.recordVideoScreen);
                    }, text: "Submit For Review")),
                SizedBox(width: size(context).width * numD04),
                Expanded(child: CommonGradientButton(onTap: (){
                  router.pop();
                }, text: "Cancel")),
              ],
            ),
            SizedBox(height: size(context).width * numD04),

          ],
        ),
      ),
    );
  }
}
