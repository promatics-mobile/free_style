import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';


class TutorialDetailScreen extends StatelessWidget {
  const TutorialDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: CommonColors.themeDarkColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Stack(
                children: [
                  CommonImage(
                    imagePath: Assets.assetsDummyPlay1,
                    width: size(context).width,
                    height: size(context).width,
                    isNetwork: false,
                  ),

                  Positioned(
                    top: size(context).width * numD07,
                    right: size(context).width * numD04,
                    left: size(context).width * numD01,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back,color: Colors.white,),
                          onPressed: () => router.pop(),
                        ),
                        Spacer(),
                        Container(
                          decoration: commonBgColorDecoration(
                            size(context).width * numD04,
                            CommonColors.secondaryLightColor,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: size(context).width * numD02,
                          ),
                          height: size(context).width * numD065,
                          child: Row(
                            children: [
                              Icon(Icons.electric_bolt,
                                color: CommonColors.secondaryColor,),
                              CommonText(
                                text: "45000 XP",
                                fontSize: size(context).width * numD03,
                                color: Colors.black,
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: size(context).width * numD04,
                    right: size(context).width * numD04,
                    left: size(context).width * numD04,
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.my_location,color: Colors.white,),
                            SizedBox(width: size(context).width * numD02),
                            CommonText(
                              text: "LOWER BODY",
                              fontSize: size(context).width * numD04,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        CommonText(
                          text: "Around the World",
                          fontSize: size(context).width * numD05,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: size(context).width * numD01),
                        Row(
                          children: [

                            Container(
                              decoration: commonBgColorDecoration(
                                size(context).width * numD04,
                                CommonColors.secondaryColor,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: size(context).width * numD02,
                              ),
                              height: size(context).width * numD065,
                              child: Row(
                                children: [
                                  Icon(Icons.signal_cellular_alt_sharp,
                                    color: Colors.black,),
                                  CommonText(
                                    text: "Tier 2",
                                    fontSize: size(context).width * numD035,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(width: size(context).width * numD02),
                            Container(
                              decoration: commonBgColorDecoration(
                                size(context).width * numD04,
                                CommonColors.secondaryColor,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: size(context).width * numD02,
                              ),
                              height: size(context).width * numD065,
                              child: Row(
                                children: [
                                  Icon(Icons.watch_later_outlined,
                                    color: Colors.black,),
                                  CommonText(
                                    text: "5m Practice",
                                    fontSize: size(context).width * numD035,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: size(context).width * numD04),

              Expanded(child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    CommonText(
                      text: "Unlock Reward",
                      fontWeight: .bold,
                      fontSize: size(context).width * numD04,
                    ),
                    SizedBox(height: size(context).width * numD02,),
                    SizedBox(
                      height: size(context).width * numD25,
                      width: size(context).width,
                      child: ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,idx){

                            return InkWell(
                              onTap: (){
                                //router.push(AppRouter.dailyChallenge);
                              },
                              child: Container(
                                decoration: commonBgColorDecoration(size(context).width * numD03, Colors.orange.shade50,),
                                width: size(context).width/2,
                                padding: EdgeInsets.all(size(context).width * numD04),
                                margin: EdgeInsets.symmetric(horizontal: size(context).width * numD02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: .spaceBetween,
                                      children: [
                                        CommonText(text:"Daily Goal",
                                          color: Colors.grey,
                                          fontSize: size(context).width * numD035,),
                                        CommonImage(imagePath: Assets.iconsIcSuitcase,
                                          width: size(context).width * numD05,
                                          height: size(context).width * numD05,
                                          isNetwork: false,),
                                      ],
                                    ),
                                    Spacer(),
                                    CommonText(text:"Video + Steps",
                                      color:Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: size(context).width * numD04,),

                                  ],
                                ),

                              ),
                            );
                          }),
                    ),
                    SizedBox(height: size(context).width * numD04),

                    CommonText(
                      text: "Requirements",
                      fontWeight: .bold,
                      fontSize: size(context).width * numD04,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: ["Basic Juggling"].length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (ctx,idx){
                          var item = ["Basic Juggling"][idx];

                          return Container(
                            decoration: commonBgColorDecoration(
                              size(context).width * numD03,
                              Colors.white,
                            ),
                            padding: EdgeInsets.all(size(context).width * numD03),
                            margin: EdgeInsets.symmetric(
                              vertical:size(context).width * numD02,
                            ),
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Container(
                                  decoration:commonCircularFill(color: CommonColors.secondaryLightColor),
                                  padding: EdgeInsets.all(size(context).width * numD02),
                                  child: Icon(Icons.check_circle_outline_outlined,
                                    color: Colors.black,
                                    size: size(context).width * numD08,
                                  ),
                                ),
                                SizedBox(width: size(context).width * numD02),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                        text: item,
                                        color: Colors.black,
                                        fontSize: size(context).width * numD04,
                                      ),
                                      CommonText(
                                        text: "Basic ${CommonSymbol.dotSymbol} 50 Reps",
                                        color: Colors.grey,
                                        fontSize: size(context).width * numD035,
                                      ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          );
                        }),

                    SizedBox(height: size(context).width * numD15),
                    CommonButton(onTap: (){
                      //router.push(AppRouter.tutorialVideoDetailScreen);

                    }, text: "Start Tutorial"),
                    SizedBox(height: size(context).width * numD15),
                  ],
                ),
              )),




            ],
          ),
        ),

    );
  }
}
