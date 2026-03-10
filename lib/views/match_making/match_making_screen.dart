import 'package:flutter/material.dart';
import 'package:free_style/generated/assets.dart';
import 'package:free_style/routes/route.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/utils/common_widgets/common_image/common_image.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';

import '../../utils/common_constants.dart';


class MatchMakingScreen extends StatelessWidget {
  const MatchMakingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Match Making"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        child: Column(
          children: [
            CommonText(text:"Opponent Found!", fontWeight: FontWeight.bold,
              fontSize:size(context).width * numD05,),

            CommonText(text:"Prepare for Battle",
              fontSize:size(context).width * numD035,),

            SizedBox(height: size(context).width * numD1),

            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [

                Column(
                  children: [
                    ClipOval(
                      child: CommonImage(imagePath: Assets.assetsIcDummyUser1,
                        height: size(context).width * numD20,
                        width: size(context).width * numD20,
                        isNetwork: false,),
                    ),
                    SizedBox(height: size(context).width * numD01),
                    CommonText(text:"You",
                      fontWeight: FontWeight.bold,
                      fontSize:size(context).width * numD04,),
                    CommonText(text:"Blue Tier",
                      fontSize:size(context).width * numD035,),

                  ],



                ),


                CircleAvatar(
                  backgroundColor: CommonColors.buttonColor,
                  radius: size(context).width * numD05,
                  child: CommonText(
                    text: "VS",
                    color: Colors.white,
                    fontSize: size(context).width * numD04,
                  ),

                ),


                Column(
                  children: [
                    ClipOval(
                      child: CommonImage(imagePath: Assets.assetsIcDummyUser2,
                        height: size(context).width * numD20,
                        width: size(context).width * numD20,
                        isNetwork: false,),
                    ),
                    SizedBox(height: size(context).width * numD01),
                    CommonText(text:"Kai_Skate",
                      fontWeight: FontWeight.bold,
                      fontSize:size(context).width * numD04,),
                    CommonText(text:"Blue Tier",
                      fontSize:size(context).width * numD035),

                  ],



                )


              ],
            ),

            SizedBox(height: size(context).width * numD05),


            Container(
              decoration: commonBgColorDecoration(size(context).width * numD03, Colors.white),
              padding: EdgeInsets.all(size(context).width * numD04),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.watch_later_outlined,
                          size:  size(context).width * numD05,
                          color: Colors.red),
                      SizedBox(width: size(context).width * numD01),
                      CommonText(text: "23h 59m Remaining",color: Colors.red,
                        fontSize: size(context).width * numD045,
                        fontWeight: FontWeight.w500)

                    ],
                  ),
                  SizedBox(height: size(context).width * numD01),

                  CommonText(text: "Both players must submit their best combo within the limit. The community will vote in the winner",
                    color: Colors.grey,
                    textAlign: TextAlign.center,
                    fontSize: size(context).width * numD035),
                  Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CommonText(text: "12",
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: size(context).width * numD04,),
                          CommonText(text: "WINS",
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: size(context).width * numD035,),
                        ],
                      ),
                      Column(
                        children: [
                          CommonText(text: "Gold",
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: size(context).width * numD04,),
                          CommonText(text: "LEAGUE",
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: size(context).width * numD035,),
                        ],
                      ),
                      Column(

                        children: [
                          CommonText(text: "95%",
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: size(context).width * numD04,),
                          CommonText(text: "WIN RATE",
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: size(context).width * numD035,),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: size(context).width * numD02,),
                ],
              ),


            ),


            SizedBox(height: size(context).width * numD1),
            CommonButton(onTap: (){
              router.push(AppRouter.victoryScreen);
            }, text: "Start Battle"),
            SizedBox(height: size(context).width * numD02,),
            CommonGradientButton(onTap: (){
              router.pop();
            }, text: "Cancel Match"),
            SizedBox(height: size(context).width * numD1),





          ],

        )
      ),
    );
  }
}
