import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_button/common_gradient_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import '../../utils/common_widgets/linear_progress_indicator/custom_linear_progress.dart';

class PreviewSubmissionScreen extends StatelessWidget {
  const PreviewSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: size(context).height,
        width: size(context).width,
        child: Stack(
          children: [
            CommonImage(
              imagePath: Assets.assetsDummyPlay2,
              width: size(context).width,
              height: size(context).height,
              isNetwork: false,
              fit: BoxFit.cover,
            ),

            Positioned(
                left: size(context).width * numD04,
                top: size(context).width * numD07,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back,color: Colors.white,),
                          onPressed: () => router.pop(),
                        ),
                        CommonText(text: "Preview Submission",
                          fontSize: size(context).width * numD045,
                          fontWeight: FontWeight.bold,),
                      ],
                    ),
                    Container(
                      decoration: commonBgColorDecoration(size(context).width * numD03, Colors.black38),
                      padding: EdgeInsets.symmetric(
                          horizontal: size(context).width * numD03,
                          vertical: size(context).width * numD01,
                      ),
                      margin: EdgeInsets.only(left: size(context).width * numD03),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: size(context).width * numD012,
                            backgroundColor: Colors.red,
                          ),
                          CommonText(
                            text:
                            " Battle vs Kim Skatter ${CommonSymbol.dotSymbol} 14h 23m Left",
                            fontSize: size(context).width * numD028,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),


                  ],
                )),



            /*Positioned(
                right: size(context).width * numD04,
                top: size(context).width * numD07,
                child: IconButton(
                  icon: const Icon(Icons.more_horiz_rounded,color: Colors.white,),
                  onPressed: () => router.pop(),
                )),*/



            Center(
              child: Container(
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
            ),

            Positioned(
                bottom: size(context).width * numD04,
                left:size(context).width * numD04,
                right: size(context).width * numD04,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(text: "00:14",color: Colors.white,),
                        CommonText(text: "00:30",color: Colors.white,),
                      ],
                    ),

                    SizedBox(height: size(context).width * numD04),
                    commonNormalLinearProgress(context: context, value: 0.4, bgColor: Colors.white, valueColor: CommonColors.buttonColor),
                    SizedBox(height: size(context).width * numD04),

                    Row(
                      children: [
                        Expanded(
                            child: CommonGradientButton(text: "Retake", onTap: (){

                              router.push(AppRouter.previewSubmissionScreen);

                            })),
                        SizedBox(width: size(context).width * numD04),

                        Expanded(
                            flex: 2,
                            child: CommonButton(text: "Submit Video", onTap: (){
                              router.pop();
                            })),
                      ],
                    ),
                    SizedBox(height: size(context).width * numD04),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size(context).width * numD03),
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
                        boxShadow: [
                          BoxShadow(
                            color: CommonColors.buttonColor.withValues(alpha: 0.3),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(size(context).width * numD02),
                      child: Row(
                        crossAxisAlignment: .start,
                        children: [
                          Icon(Icons.info_outline,color: Colors.white),
                          SizedBox(
                            width: size(context).width * numD02,
                          ),

                          Expanded(
                            child: CommonText(
                              text: "Submitting will lock in your attempt. Ensure your trick is completely visible within the 15-second limit.",
                              fontSize:
                              size(context).width * numD035,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size(context).width * numD04),






                  ],
                )),
          ],
        ),
      ),
    );
  }
}
