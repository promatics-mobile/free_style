import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_methods.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/views/tutorial/tutorial_details.dart';
import 'package:free_style/views/tutorial/tutorial_vdo_details/tutorial_video_detail_cubit.dart';
import 'package:free_style/views/tutorial/tutorial_vdo_details/tutorial_video_detail_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../generated/assets.dart';
import '../../../network_class/web_urls.dart';
import '../../../routes/route.dart';
import '../../../utils/common_constants.dart';
import '../../../utils/common_decorations/common_decorations.dart';
import '../../../utils/common_web_video_player/common_web_video_player.dart';
import '../../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../../utils/common_widgets/common_button/common_button.dart';
import '../../../utils/common_widgets/common_image/common_image.dart';
import '../../../utils/common_widgets/common_text/common_text.dart';
import '../../../utils/common_widgets/common_video_player/common_video_player.dart';

class TutorialVideoDetailScreen extends StatefulWidget {
  const TutorialVideoDetailScreen({super.key});

  @override
  State<TutorialVideoDetailScreen> createState() => _TutorialVideoDetailScreenState();
}

class _TutorialVideoDetailScreenState extends State<TutorialVideoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Tutorial Details"),
      body: BlocBuilder<TutorialVdoDetailCubit, TutorialVdoDetailState>(
        builder: (context, state) {
          var cubit = context.read<TutorialVdoDetailCubit>();
          if(cubit.tutorialModel == null){
            return Container();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(size(context).width * numD04),
                decoration: commonBgColorDecoration(
                  size(context).width * numD02,
                  CommonColors.themeDarkColor,
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(size(context).width * numD02),
                            topRight: Radius.circular(size(context).width * numD02),
                          ),
                          child: SizedBox(
                            width: size(context).width,
                            height: size(context).width / 2,
                            child: cubit.tutorialModel!.internalUrl !=null ?
                            CommonVideoPlayer(
                              videoUrl:
                              cubit.tutorialModel!.internalUrl!.getFileUrl(mediaBaseUrl),
                              isAsset: false,
                            ) :
                            CommonWebVideoPlayer(
                              videoUrl: cubit.tutorialModel!.externalUrl,
                            ),
                          ),
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
                              Icon(
                                Icons.watch_later_outlined,
                                color: Colors.grey,
                                size: size(context).width * numD05,
                              ),
                              SizedBox(width: size(context).width * numD01),
                              cubit.tutorialModel!.internalUrl !=null?
                              FutureBuilder<Duration>(
                                future: getVideoDuration(cubit.tutorialModel!.internalUrl!.getFileUrl(mediaBaseUrl),),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CommonText(
                                      text: "Loading...",
                                      fontSize: size(context).width * numD035,
                                      color: Colors.grey,
                                    );
                                  }

                                  if (!snapshot.hasData) {
                                    return const SizedBox();
                                  }

                                  final duration = snapshot.data!;

                                  return CommonText(
                                    text: formatVideoDuration(duration),
                                    fontSize: size(context).width * numD035,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  );
                                },
                              ) :
                              CommonText(
                                text: "N/A",
                                fontSize: size(context).width * numD035,
                                color: Colors.grey,
                              )

                            ],
                          ),
                        ),
                        SizedBox(width: size(context).width * numD02),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: .start,
                            children: [
                              Icon(
                                Icons.signal_cellular_alt_sharp,
                                color: Colors.grey,
                                size: size(context).width * numD05,
                              ),
                              SizedBox(width: size(context).width * numD02),
                              CommonText(
                                text: cubit.difficultyLevel.toCapitalize(),
                                fontSize: size(context).width * numD035,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showToast(isError: false, message: "Saved successfully");
                            setState(() {});
                          },
                          child: Icon(
                            Icons.bookmark_outline,
                            color: Colors.grey,
                            size: size(context).width * numD05,
                          ),
                        ),
                        SizedBox(width: size(context).width * numD04),
                      ],
                    ),
                    SizedBox(height: size(context).width * numD04),
                  ],
                ),
              ),

              SizedBox(height: size(context).width * numD02),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      CommonText(
                        text: cubit.tutorialModel!.displayTitle,
                        fontWeight: .bold,
                        fontSize: size(context).width * numD045,
                      ),
                      CommonText(
                        text: "",
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
                        itemCount: cubit.tutorialModel!.steps.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (ctx, idx) {
                          var item = cubit.tutorialModel!.steps[idx];

                          return Container(
                            padding: EdgeInsets.all(size(context).width * numD03),
                            alignment: Alignment.topLeft,
                            child: Row(
                              crossAxisAlignment: .start,
                              children: [
                                Container(
                                  decoration: commonOutlineDecoration(
                                    size(context).width * numD09,
                                    1,
                                    CommonColors.secondaryColor,
                                  ),
                                  padding: EdgeInsets.all(size(context).width * numD01),
                                  alignment: Alignment.center,
                                  height: size(context).width * numD08,
                                  width: size(context).width * numD08,
                                  child: CommonText(
                                    text: "${idx + 1}",
                                    color: CommonColors.secondaryColor,
                                  ),
                                ),
                                SizedBox(width: size(context).width * numD04),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                          text: item.title, fontSize: size(context).width * numD04),
                                      CommonText(
                                        text:
                                        item.description,
                                        color: Colors.grey,
                                        fontSize: size(context).width * numD035,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      ),

                      SizedBox(height: size(context).width * numD05),

                      CommonText(
                        text:
                        cubit.submissionStatus  == "not_submitted" ?
                        "Mark this tutorial as watched to unlock the rewards and xp." :
                        //"Your mark completed request is already submitted to admin.",
                        "",
                        color: Colors.grey,
                        fontSize: size(context).width * numD035,
                      ),

                      SizedBox(height: size(context).width * numD05),



                      if(cubit.submissionStatus  == "not_submitted")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CommonGradientButton(
                              text: "Mark watched",
                              onTap: () {
                                setState(() {});
                                cubit.callSubmitMarkWatchedApi();
                              },
                            ),
                          ),
                          if(cubit.isVidSubReq)
                          SizedBox(width: size(context).width * numD04),

                          if(cubit.isVidSubReq)
                          Expanded(
                            child: CommonButton(
                              onTap: () {
                                router.push(AppRouter.submitProofScreen,extra: {"id": cubit.skillId,"type": "skill_tree"}).then((_){
                                  cubit.callSkillDetailsApi(cubit.skillId);
                                });
                              },
                              text: "Submit Proof",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size(context).width * numD15),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
