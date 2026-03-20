import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/linear_progress_indicator/custom_linear_progress.dart';


class BattlesScreen extends StatelessWidget {
  const BattlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        child: Column(
          crossAxisAlignment: .center,
          children: [
            SizedBox(height: size(context).width * numD04),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: size(context).width * numD1,
              child: Icon(Icons.lock_outline,
                 size: size(context).width * numD1,
                color: Colors.grey,),
            ),
            SizedBox(height: size(context).width * numD04),

            CommonText(text:"Arena Locked",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD06,),
            SizedBox(height: size(context).width * numD02),
            CommonText(text:"Prove your mastery to enter the Battle Arena. Reach Level 2 to complete daily challenges and unlock 1v1 battles. ",
              textAlign: TextAlign.center,
              fontSize: size(context).width * numD035,),
            SizedBox(height: size(context).width * numD1),

            Container(
              decoration: commonBgColorDecoration(size(context).width * numD03, CommonColors.secondaryColor),
              padding: EdgeInsets.all(size(context).width * numD04),
              margin: EdgeInsets.symmetric(horizontal: size(context).width * numD02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [



                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      CommonText(text:"Current Progress",
                        color: Colors.black,
                        fontSize: size(context).width * numD04,),
                      CommonText(text:"Level 1/2",
                        color: Colors.black,
                        fontSize: size(context).width * numD04,),
                    ],
                  ),

                  SizedBox(height: size(context).width * numD01),
                  commonNormalLinearProgress(
                      context: context,
                      value: 0.5,
                      bgColor: Colors.grey,
                      valueColor: CommonColors.buttonColor),
                  SizedBox(height: size(context).width * numD01),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      CommonText(text:"Level 1",
                        color: Colors.black,
                        fontSize: size(context).width * numD035,),
                      CommonText(text:"Level 2",
                        color: Colors.black,
                        fontSize: size(context).width * numD035,),
                    ],
                  ),




                ],
              ),
            ),
            SizedBox(height: size(context).width * numD1),
            CommonButton(onTap: (){
              router.push(AppRouter.missionScreen);
            }, text: 'Go to Missions'),
            SizedBox(height: size(context).width * numD02),
            CommonGradientButton(
              text: "Start Training Mode",
              onTap: () {
                //router.push(AppRouter.trainingScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
