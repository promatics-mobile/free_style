import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/generated/assets.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/common_image/common_image.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/utils/common_widgets/loaders/common_loader.dart';
import 'package:free_style/views/home/home_cubit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../routes/route.dart';
import '../../utils/common_widgets/linear_progress_indicator/custom_linear_progress.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    var cubit = context.read<HomeCubit>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size(context).width* numD04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: commonBgColorDecoration(size(context).width * numD04, CommonColors.secondaryColor),
              padding: EdgeInsets.all(size(context).width * numD04),
              width:  size(context).width,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(text: "CURRENT LEAGUE",
                          color: Colors.black,
                          fontSize: size(context).width * numD035,),
                        CommonText(text: "Street Legend",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: size(context).width * numD05,),

                        SizedBox(height: size(context).width * numD02,),
                        Container(
                          decoration: commonBgColorDecoration(size(context).width * numD02, Colors.black),
                          padding: EdgeInsets.symmetric(
                              horizontal:size(context).width * numD04,
                              vertical:size(context).width * numD01,
                          ),
                          child: Column(
                            children: [
                              CommonText(text: "XP Progress",
                                color: Colors.white,
                                fontSize: size(context).width * numD03,),
                              CommonText(text: "2450 / 3000",
                                color: Colors.white,
                                fontSize: size(context).width * numD03,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size(context).width * numD20,
                    width: size(context).width * numD20,
                    child: CircularPercentIndicator(
                      radius: size(context).width * numD09,
                      lineWidth: size(context).width * numD015,
                      animation: true,
                      percent: 0.85,
                      center:  CommonText(
                        text: "85%",
                        color: Colors.black,
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size(context).width * numD04,),

            CommonText(text: "Live Activity",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD04,),
            SizedBox(height: size(context).width * numD04,),
            SizedBox(
              height: size(context).width * numD28,
              width: size(context).width,
              child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,idx){

                return InkWell(
                  onTap: (){
                    router.push(AppRouter.dailyChallenge);
                  },
                  child: Container(
                    decoration: commonBgColorDecoration(size(context).width * numD03, Colors.orange.shade50,),
                    width: size(context).width/1.5,
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
                        CommonText(text:"Ends in 4h 20m",
                          color:Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size(context).width * numD04,),
                        SizedBox(height: size(context).width * numD01),
                        commonNormalLinearProgress(
                            context: context,
                            value: 0.8,
                            bgColor: Colors.grey,
                            valueColor: CommonColors.buttonColor),

                      ],
                    ),

                  ),
                );
              }),
            ),
            SizedBox(height: size(context).width * numD04,),
            CommonText(text: "Menu",
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * numD04,),
            SizedBox(height: size(context).width * numD04,),
            GridView.builder(
                itemCount: cubit.menuItemsList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    crossAxisSpacing: size(context).width * numD02,
                    mainAxisSpacing: size(context).width * numD02,
                    childAspectRatio: 2.5),
                itemBuilder: (context,idx){
                  var item =  cubit.menuItemsList[idx];

                  return InkWell(
                    onTap: (){
                      switch (item.title){
                        case "Battle Arena":
                          router.push(AppRouter.matchMakingScreen);
                          break;
                          case "Training":
                            router.push(AppRouter.trainingScreen);
                          break;
                          case "Skill Tree":
                            router.push(AppRouter.skillTreeScreen);
                          break;
                          case "Skill States":
                            router.push(AppRouter.skillStateScreen);
                          break;
                          case "Tutorials":
                            router.push(AppRouter.tutorialScreen);
                          break;
                          case "Missions":
                            router.push(AppRouter.missionScreen);
                          break;
                          default:
                            break;
                      }
                    },
                    child: Container(
                      decoration: commonBgColorDecoration(size(context).width * numD03, Colors.white,),
                      padding: EdgeInsets.all(size(context).width * numD04),
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: CommonColors.secondaryLightColor,
                              radius: size(context).width * numD05,
                              child: CommonImage(imagePath: item.icon,
                                width: size(context).width * numD05,
                                color: Colors.black,
                                height: size(context).width * numD05,
                                isNetwork: false,)),
                          SizedBox(width: size(context).width * numD02,),
                          CommonText(text: item.title,
                            color: Colors.black,
                            fontSize: size(context).width * numD035,),
                        ],
                      ),

                    ),
                  );
                }, ),


          ],

        ),
      )
    );
  },
);
  }
}
