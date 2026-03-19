import 'package:flutter/material.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/utils/common_widgets/linear_progress_indicator/custom_linear_progress.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_video_recorder/video_recorder_widget.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';

class RecordVideoScreen extends StatelessWidget {
  const RecordVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: size(context).height,
        width: size(context).width,
        child: true ?
        VideoRecorderWidget(maxDurationSecond: 15,
        onVideoRecorded:(file){
          debugPrint("onVideoRecorded::$file");
        },
        )


            :Stack(
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
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,color: Colors.white,),
                  onPressed: () => router.pop(),
                )),
            Positioned(
                right: size(context).width * numD04,
                top: size(context).width * numD07,
                child: IconButton(
                  icon: const Icon(Icons.cancel,color: Colors.white,),
                  onPressed: () => router.pop(),
                )),



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
                      children: [
                        IconButton(
                          icon: const Icon(Icons.volume_up,color: Colors.white,),
                          onPressed: () {},
                        ),
                      ],
                    ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: .start,
                          children: [
                            CommonText(text: "Technical Trio",
                              fontSize: size(context).width * numD05,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,),
                            CommonText(text: "Daily Challenge",color: Colors.white,),
                          ],
                        ),

                        Container(
                          decoration: commonBgColorDecoration(size(context).width * numD03, CommonColors.secondaryColor),
                          padding: EdgeInsets.symmetric(horizontal: size(context).width * numD03),
                          child: CommonText(text: "Ready",
                            fontWeight: .w500,
                            fontSize: size(context).width * numD035,
                            color: Colors.black,),
                        )


                      ],
                    ),

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
                            child: CommonButton(text: "Submit Challenge", onTap: (){
                              router.push(AppRouter.challengeApprovedScreen);
                            })),
                      ],
                    )







                  ],
                )),
          ],
        ),
      ),
    );
  }
}
