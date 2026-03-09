import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';


class TutorialVideoDetailScreen extends StatelessWidget {
  const TutorialVideoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Tutorial Details"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            margin: EdgeInsets.all(size(context).width * numD04),
            decoration: commonBgColorDecoration(size(context).width * numD02, CommonColors.themeDarkColor),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:BorderRadius.only(
                          topLeft: Radius.circular(size(context).width * numD02),
                          topRight: Radius.circular(size(context).width * numD02),
                      ),
                      child: CommonImage(
                        imagePath: Assets.assetsDummyPlay2,
                        width: size(context).width,
                        height: size(context).width/2.5,
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
                    SizedBox(width: size(context).width * numD04),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: .start,
                        children: [
                          Icon(Icons.watch_later_outlined,
                            color: Colors.grey,size: size(context).width * numD05),
                          SizedBox(width: size(context).width * numD01),
                          CommonText(
                            text: "2 mins",
                            fontSize: size(context).width * numD035,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                      
                        ],
                      ),
                    ),
                    SizedBox(width: size(context).width * numD02),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: .start,
                        children: [
                          Icon(Icons.signal_cellular_alt_sharp,
                            color: Colors.grey,size: size(context).width * numD05),
                          SizedBox(width: size(context).width * numD02),
                          CommonText(
                            text: "Beginners",
                            fontSize: size(context).width * numD035,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                      
                        ],
                      ),
                    ),
                    Icon(Icons.bookmark_outline,
                        color: Colors.grey,size: size(context).width * numD05),
                    SizedBox(width: size(context).width * numD04),
                   
                  ],
                ),
                SizedBox(height: size(context).width * numD04),
              ],
            ),
          ),

          SizedBox(height: size(context).width * numD02),

          Expanded(child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                CommonText(
                  text: "Around the world",
                  fontWeight: .bold,
                  fontSize: size(context).width * numD045,
                ),
                CommonText(
                  text: "Lower body trick Freestyle football",
                  color: Colors.grey,
                  fontSize: size(context).width * numD035,
                ),
                SizedBox(height: size(context).width * numD04),

                CommonText(
                  text: "Steps",
                  fontWeight: .bold,
                  fontSize: size(context).width * numD04,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: ["Start position","The Rotation","The Catch"].length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (ctx,idx){
                      var item = ["Start position","The Rotation","The Catch"][idx];

                      return Container(
                        padding: EdgeInsets.all(size(context).width * numD03),
                        alignment: Alignment.topLeft,
                        child: Row(
                          crossAxisAlignment: .start,
                          children: [
                            Container(
                              decoration: commonOutlineDecoration(size(context).width * numD09, 1, CommonColors.secondaryColor),
                              padding: EdgeInsets.all(size(context).width * numD01),
                              alignment: Alignment.center,
                              height:size(context).width * numD08,
                              width:size(context).width * numD08,
                              child: CommonText(text:"${idx+1}",color: CommonColors.secondaryColor,),
                            ),
                            SizedBox(width: size(context).width * numD04),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    text: item,
                                    fontSize: size(context).width * numD04,
                                  ),
                                  CommonText(
                                    text: "Hop lightly on your supporting leg while moving your dominant foot around the ball in an outward circle, keeping contact as smooth as possible.",
                                    color: Colors.grey,
                                    fontSize: size(context).width * numD035,
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                },),

                SizedBox(height: size(context).width * numD05),
                CommonText(
                  text: "Mark this tutorial as watched or continue to your missions.",
                  color: Colors.grey,
                  fontSize: size(context).width * numD035,
                ),

                SizedBox(height: size(context).width * numD05),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: CommonGradientButton(
                        text: "Mark watched", onTap: (){})),
                    SizedBox(width: size(context).width * numD04),
                    Expanded(
                      child: CommonButton(onTap: (){
                        router.push(AppRouter.missionScreen);
                      }, text: "Go to missions"),
                    ),
                  ],
                ),
                SizedBox(height: size(context).width * numD15),
              ],
            ),
          )),


        ],
      ),

    );
  }
}
