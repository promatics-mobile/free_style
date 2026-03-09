import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/views/training/training_cubit.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_button/common_gradient_button.dart';
import '../../utils/common_widgets/common_button/common_short_button.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';


class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingCubit, TrainingState>(
  builder: (context, state) {
    var cubit = context.read<TrainingCubit>();
    return Scaffold(
      appBar: CommonAppBar(title: "Training mode",
        actions: [
          IconButton(onPressed: (){
            router.push(AppRouter.challengeHistoryScreen);

          }, icon: Icon(Icons.history,color: Colors.white,))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: commonBgColorDecoration(size(context).width * numD03,Colors.white),
                    padding: EdgeInsets.all(size(context).width * numD03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(text: "42m",
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: size(context).width * numD04),
                        CommonText(text: "This Week",
                            color: Colors.black,
                            fontSize: size(context).width * numD035),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: size(context).width * numD02),
                Expanded(
                  child: Container(
                    decoration: commonBgColorDecoration(size(context).width * numD03,Colors.white),
                    padding: EdgeInsets.all(size(context).width * numD03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(text: "350",
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: size(context).width * numD04),
                        CommonText(text: "Total Reps",
                            color: Colors.black,
                            fontSize: size(context).width * numD035),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size(context).width * numD02),
            CommonText(text: "New Session",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD04,),
            SizedBox(height: size(context).width * numD02),
            CommonText(text: "Select Branch",
              fontSize: size(context).width * numD04,),
            SizedBox(height: size(context).width * numD04),
            SizedBox(
              height: size(context).width * numD09,
              width: size(context).width,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 0),
                itemCount: ["Lower","Upper","Sit Down","Ground"].length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, idx) {
                  var item = ["Lower","Upper","Sit Down","Ground"][idx];

                  return Container(
                    decoration: commonBgColorDecoration(
                        size(context).width * numD05,
                        idx == 0 ?
                        CommonColors.secondaryColor:
                        CommonColors.themeDarkColor
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
                      color: idx == 0 ?
                      Colors.black : Colors.white,
                      fontSize: size(context).width * numD035,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: size(context).width * numD04),
            CommonText(text: "Focus Trick",
              fontWeight: FontWeight.bold,fontSize: size(context).width * numD04,),
            SizedBox(height: size(context).width * numD02),
            Container(
              decoration: commonBgColorDecoration(size(context).width * numD03,Colors.white),
              padding: EdgeInsets.all(size(context).width * numD03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CommonText(text: "Around the World",
                        color: Colors.black,
                        fontSize: size(context).width * numD035),
                  ),

                  Icon(Icons.keyboard_arrow_down_rounded,color: Colors.black,)

                ],
              ),
            ),


            SizedBox(height: size(context).width * numD04),
            CommonText(text: "Goal Type",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD04,),
            SizedBox(height: size(context).width * numD02),
            Container(
              decoration: commonBgColorDecoration(
                size(context).width * numD02,
                Colors.grey.shade200,
              ),
              padding: EdgeInsets.all(
                size(context).width * numD02,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        cubit.changeGoalType("Free");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: size(context).width * numD03,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                          cubit.goalType == "Free"
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            size(context).width * numD02,
                          ),
                        ),
                        child: CommonText(
                          text: "Free",
                          fontSize: size(context).width * numD04,
                          color:
                          cubit.goalType == "Free"
                              ? CommonColors.themeColor
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: size(context).width * numD03),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        cubit.changeGoalType("Reps");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: size(context).width * numD03,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                          cubit.goalType == "Reps"
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            size(context).width * numD02,
                          ),
                        ),
                        child: CommonText(
                          text: "Reps",
                          fontSize: size(context).width * numD04,
                          color:
                          cubit.goalType == "Reps"
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: size(context).width * numD03),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        cubit.changeGoalType("Timer");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: size(context).width * numD03,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                          cubit.goalType == "Timer"
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            size(context).width * numD02,
                          ),
                        ),
                        child: CommonText(
                          text: "Timer",
                          fontSize: size(context).width * numD04,
                          color:
                          cubit.goalType == "Timer"
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size(context).width * numD04),
            Container(
              decoration: commonBgColorDecoration(size(context).width * numD03,Colors.white),
              padding: EdgeInsets.all(size(context).width * numD03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.remove_circle,color: CommonColors.buttonColor),
                  Expanded(
                    child: CommonText(text: "50 Reps",
                        color: Colors.black,
                        textAlign: TextAlign.center,
                        fontSize: size(context).width * numD04),
                  ),

                  Icon(Icons.add_circle,color: CommonColors.buttonColor),

                ],
              ),
            ),



            SizedBox(height: size(context).width * numD04),
            CommonText(text: "Saved Sessions",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD04,),
            SizedBox(height: size(context).width * numD02),


            ListView.builder(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ["Juggling Endurance","Neck Stall Hold"].length,
                itemBuilder: (ctx,idx){
                  var item = ["Juggling Endurance","Neck Stall Hold"][idx];

              return Container(
                decoration: commonBgColorDecoration(
                  size(context).width * numD02,
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
                      padding: EdgeInsets.all(size(context).width * numD01),
                      child: CommonImage(imagePath: Assets.iconsIcFilterHori,isNetwork: false,
                      height: size(context).width * numD08,
                      width: size(context).width * numD08,
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

                    IconButton(
                      onPressed: () {},
                      icon: CommonImage(
                        imagePath: Assets.iconsIcPlay,
                        isNetwork: false,
                        color:Colors.black,
                        width: size(context).width * numD05,
                        height: size(context).width * numD05,
                      ),
                    ),
                  ],
                ),
              );
            })



          ],
        ),
      ),
    );
  },
);
  }
}
