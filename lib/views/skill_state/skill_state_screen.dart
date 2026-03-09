import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';

class SkillStateScreen extends StatelessWidget {
  const SkillStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Skill States"),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(horizontal: size(context).width * numD04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(text:"Future Tiers (Locked)",
              fontWeight: FontWeight.bold,fontSize: size(context).width * numD04,),
            SizedBox(height : size(context).width * numD02),
            Container(
              decoration: commonBgColorDecoration(size(context).width * numD03, CommonColors.themeDarkColor),
              padding: EdgeInsets.all(size(context).width * numD04),
              child: Row(
                children: [
                  Container(
                      decoration: commonBgColorDecoration(size(context).width * numD02, CommonColors.themeColor),
                      padding: EdgeInsets.all(size(context).width * numD02),
                      child: Icon(Icons.lock_outline,color: Colors.white,)),
                  SizedBox(width: size(context).width * numD02,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        CommonText(text:"Double Around the World",fontSize: size(context).width * numD035,),
                        CommonText(text:"Tier 4 . Upper",
                          color: Colors.grey,
                          fontSize: size(context).width * numD03,),
                      ],
                    ),
                  ),
                  SizedBox(width: size(context).width * numD02,),
                  CommonText(text:"Locked",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: size(context).width * numD03,),


                ],
              ),
            ),
            SizedBox(height : size(context).width * numD04),


            CommonText(text:"Available To Unlock",
              fontWeight: FontWeight.bold,fontSize: size(context).width * numD04,),
            SizedBox(height : size(context).width * numD02),
            Container(
              decoration: commonOutlineDecoration(size(context).width * numD03, 1, CommonColors.secondaryColor),
              child: Container(
                decoration: commonBgColorDecoration(
                    size(context).width * numD03, CommonColors.themeDarkColor),
                padding: EdgeInsets.all(size(context).width * numD04),
                child: Row(
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                        decoration: commonBgColorDecoration(size(context).width * numD02, CommonColors.themeColor),
                        padding: EdgeInsets.all(size(context).width * numD02),
                        child: Icon(Icons.lock_outline,color: CommonColors.secondaryColor,)),
                    SizedBox(width: size(context).width * numD02,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          CommonText(text:"Crossover",fontSize: size(context).width * numD035,),
                          CommonText(text:"Cost: 5 SP",
                            color: Colors.grey,
                            fontSize: size(context).width * numD03,),
                        ],
                      ),
                    ),
                    SizedBox(width: size(context).width * numD02,),
                    Container(
                      decoration: commonBgColorDecoration(size(context).width * numD03, CommonColors.secondaryColor),
                      padding: EdgeInsetsGeometry.symmetric(
                          vertical: size(context).width * numD01,
                          horizontal: size(context).width * numD02,
                      ),
                      child: CommonText(text:"Unlock",
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: size(context).width * numD03,),
                    ),


                  ],
                ),
              ),
            ),
            SizedBox(height : size(context).width * numD04),


            CommonText(text:"Unlocked (Ready to Train)",
              fontWeight: FontWeight.bold,fontSize: size(context).width * numD04,),
            SizedBox(height : size(context).width * numD02),
            Container(
              decoration: commonBgColorDecoration(size(context).width * numD03, CommonColors.themeDarkColor),
              padding: EdgeInsets.all(size(context).width * numD04),
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  Container(
                      decoration: commonBgColorDecoration(size(context).width * numD02, CommonColors.themeColor),
                      padding: EdgeInsets.all(size(context).width * numD02),

                      child: Icon(Icons.lock_outline,color: Colors.white,)),
                  SizedBox(width: size(context).width * numD02,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        CommonText(text:"Sole Stall",fontSize: size(context).width * numD035,),
                        CommonText(text:"0 / 3 missions",
                          color: Colors.grey,
                          fontSize: size(context).width * numD03,),
                      ],
                    ),
                  ),
                  SizedBox(width: size(context).width * numD02,),

                  Container(
                    decoration: commonBgColorDecoration(size(context).width * numD03, CommonColors.secondaryColor),
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: size(context).width * numD01,
                      horizontal: size(context).width * numD02,
                    ),
                    child: CommonText(text:"Train",
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: size(context).width * numD03,),
                  ),



                ],
              ),
            ),
            SizedBox(height : size(context).width * numD04),


            CommonText(text:"Verification Pending",
              fontWeight: FontWeight.bold,fontSize: size(context).width * numD04,),
            SizedBox(height : size(context).width * numD02),
            Container(
              decoration: commonBgColorDecoration(size(context).width * numD03, CommonColors.themeDarkColor),
              padding: EdgeInsets.all(size(context).width * numD04),
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  Container(
                      decoration: commonBgColorDecoration(size(context).width * numD02, CommonColors.themeColor),
                      padding: EdgeInsets.all(size(context).width * numD02),
                      child: Icon(Icons.watch_later_outlined,color: Colors.white,)),
                  SizedBox(width: size(context).width * numD02,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        CommonText(text:"Around the World",fontSize: size(context).width * numD035,),
                        CommonText(text:"Submitted today",
                          color: Colors.grey,
                          fontSize: size(context).width * numD03,),
                      ],
                    ),
                  ),
                  SizedBox(width: size(context).width * numD02,),

                  Container(
                    decoration: commonOutlineDecoration(size(context).width * numD03, 1, Colors.orange),
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: size(context).width * numD01,
                      horizontal: size(context).width * numD02,
                    ),
                    child: CommonText(text:"In Review",
                      color: Colors.orange,
                      fontWeight: FontWeight.w500,
                      fontSize: size(context).width * numD03,),
                  ),



                ],
              ),
            ),
            SizedBox(height : size(context).width * numD04),


            CommonText(text:"Completed",
              fontWeight: FontWeight.bold,fontSize: size(context).width * numD04,),
            SizedBox(height : size(context).width * numD02),
            Container(
              decoration: commonBgColorDecoration(size(context).width * numD03, CommonColors.themeDarkColor),
              padding: EdgeInsets.all(size(context).width * numD04),
              child: Row(
                children: [
                  Container(
                      decoration: commonBgColorDecoration(size(context).width * numD02, CommonColors.themeColor),
                      padding: EdgeInsets.all(size(context).width * numD02),
                      child: Icon(Icons.check,color: Colors.white,)),
                  SizedBox(width: size(context).width * numD02,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        CommonText(text:"Basic Juggling",fontSize: size(context).width * numD035,),
                        CommonText(text:"Verfied . Oct24",
                          color: Colors.grey,
                          fontSize: size(context).width * numD03,),
                      ],
                    ),
                  ),




                ],
              ),
            ),
            SizedBox(height : size(context).width * numD02),


          ],
        ),
      ),
    );
  }
}
