import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_methods.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/utils/common_widgets/common_refresh_indicator/common_refresh_indicator.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/views/battles/battles_cubit.dart';

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
        body: BlocBuilder<BattlesCubit, BattlesState>(
          builder: (context, state) {
            var cubit = context.read<BattlesCubit>();
            return CommonRefreshIndicator(
                onRefresh: () async{
                  cubit.callBattleListApi();
                },
                child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
                physics: NeverScrollableScrollPhysics(),
                itemCount: cubit.battleList.length,
                itemBuilder: (context, index) {
                  var item = cubit.battleList[index];
                  return InkWell(
                    onTap: (){
                      router.push(AppRouter.battleDetailsScreen,extra: {"id":item.id});
                    },
                    child: Container(
                      decoration: commonBgColorDecoration(
                          size(context).width * numD03, Colors.white),
                      padding: EdgeInsets.all(size(context).width * numD04),
                      child: Row(
                        children: [
                          Container(
                            decoration: commonCircularFill(color: CommonColors.secondaryColor),
                            padding: EdgeInsets.all(size(context).width * numD04),
                            width: size(context).width * numD15,
                            height: size(context).width * numD15,
                            child: CommonImage(imagePath: Assets.iconsIcBattle,
                              fit: BoxFit.cover,
                              isNetwork: false,
                            ),
                          ),
                          SizedBox(width: size(context).width * numD02),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                CommonText(
                                  text: item.battleName,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size(context).width * numD04,
                                ),
                                SizedBox(height: size(context).width * numD02),

                                Row(
                                  children: [
                                    CommonText(
                                      text: "Start Date : ",
                                      color: Colors.black,
                                      fontSize: size(context).width * numD03,
                                    ),
                                    CommonText(
                                      text: item.startDate.toString().changeDateStringFormat(inputPattern: "yyyy-MM-dd",
                                          outputPattern: "dd-MM-yyyy"),
                                      color: Colors.grey,
                                      fontSize: size(context).width * numD03,
                                    ),
                                  ],
                                ),Row(
                                  children: [
                                    CommonText(
                                      text: "End Date : ",
                                      color: Colors.black,
                                      fontSize: size(context).width * numD03,
                                    ),
                                    CommonText(
                                      text: item.endDate.toString().changeDateStringFormat(inputPattern: "yyyy-MM-dd",
                                          outputPattern: "dd-MM-yyyy"),
                                      color: Colors.grey,
                                      fontSize: size(context).width * numD03,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right,color: CommonColors.secondaryColor,),
                        ],
                      ),
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: size(context).width * numD04);
                },));
          },
        )
    );
  }


  Widget arenaLockedUi(BuildContext context) {
    return Column(
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

        CommonText(text: "Arena Locked",
          fontWeight: FontWeight.bold,
          fontSize: size(context).width * numD06,),
        SizedBox(height: size(context).width * numD02),
        CommonText(
          text: "Prove your mastery to enter the Battle Arena. Reach Level 2 to complete daily challenges and unlock 1v1 battles. ",
          textAlign: TextAlign.center,
          fontSize: size(context).width * numD035,),
        SizedBox(height: size(context).width * numD1),

        Container(
          decoration: commonBgColorDecoration(
              size(context).width * numD03, CommonColors.secondaryColor),
          padding: EdgeInsets.all(size(context).width * numD04),
          margin: EdgeInsets.symmetric(horizontal: size(context).width * numD02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  CommonText(text: "Current Progress",
                    color: Colors.black,
                    fontSize: size(context).width * numD04,),
                  CommonText(text: "Level 1/2",
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
                  CommonText(text: "Level 1",
                    color: Colors.black,
                    fontSize: size(context).width * numD035,),
                  CommonText(text: "Level 2",
                    color: Colors.black,
                    fontSize: size(context).width * numD035,),
                ],
              ),


            ],
          ),
        ),
        SizedBox(height: size(context).width * numD1),
        CommonButton(onTap: () {
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
    );
  }

}
