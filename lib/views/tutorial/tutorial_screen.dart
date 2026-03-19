import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/views/tutorial/tutorial_cubit.dart';

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

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Tutorials",
      ),
      body: BlocBuilder<TutorialCubit, TutorialState>(
  builder: (context, state) {
    var cubit = context.read<TutorialCubit>();
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(
              height: size(context).width * numD09,
              width: size(context).width,
              child: ListView.builder(
                itemCount: ["All","Basics","Upper","Lower","Ground"].length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, idx) {
                  var item = ["All","Basics","Upper","Lower","Ground"][idx];
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
                      color:
                      idx == 0 ?
                      Colors.black : Colors.white,
                      fontSize: size(context).width * numD035,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: size(context).width * numD04),

            Expanded(child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  CommonText(text:"Continue Learning",
                    fontSize: size(context).width * numD04,
                    fontWeight: .bold,),
                  SizedBox(height: size(context).width * numD02),
                  ListView.builder(
                    itemCount: cubit.tutorialsList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, idx) {
                      var item = cubit.tutorialsList[idx];
                      return InkWell(
                          onTap: (){
                            router.push(AppRouter.tutorialVideoDetailScreen,
                                extra: {"id": item.id, "skill_id": cubit.skillId});
                          },
                          child: Container(
                            decoration: commonBgColorDecoration(size(context).width * numD03, CommonColors.themeDarkColor),
                            padding: EdgeInsets.all(size(context).width * numD02),
                            margin: EdgeInsets.only(bottom:size(context).width * numD02),

                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(size(context).width * numD02),
                                  child: CommonImage(imagePath: Assets.assetsDummyPlay1,
                                    width: size(context).width * numD20,
                                    height: size(context).width * numD15,
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
                                        text: item.displayTitle,
                                        fontSize: size(context).width * numD04,
                                      ), CommonText(
                                        text: "Basics",
                                        color: Colors.grey,
                                        fontSize: size(context).width * numD035,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                      );
                    },
                  ),

                 /* SizedBox(height: size(context).width * numD04),
                  CommonText(text:"Recommended for You",
                    fontSize: size(context).width * numD04,
                    fontWeight: .bold,),
                  SizedBox(height: size(context).width * numD02),
                  ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, idx) {
                      return InkWell(
                          onTap: (){
                            router.push(AppRouter.tutorialDetailScreen);
                          },
                          child: Container(
                            decoration: commonBgColorDecoration(size(context).width * numD03, CommonColors.themeDarkColor),
                            padding: EdgeInsets.all(size(context).width * numD02),
                            margin: EdgeInsets.only(bottom:size(context).width * numD02),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(size(context).width * numD02),
                                  child: CommonImage(imagePath:
                                  idx.isEven ?
                                  Assets.assetsDummyPlay1:
                                  Assets.assetsDummyPlay2,
                                    width: size(context).width * numD20,
                                    height: size(context).width * numD15,
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
                                        text: "Around The World : Step By Step Guide",
                                        fontSize: size(context).width * numD04,
                                      ), CommonText(
                                        text: "Lower . Novice",
                                        color: Colors.grey,
                                        fontSize: size(context).width * numD035,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                      );
                    },
                  ),*/
                ],
              ),
            )),

          ],
        ),
      );
  },
),
    );
  }
}
