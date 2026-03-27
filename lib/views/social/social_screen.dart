import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_shimmers/common_shimmer.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';
import 'package:free_style/utils/common_widgets/common_refresh_indicator/common_refresh_indicator.dart';
import 'package:free_style/views/social/social_cubit.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_alerts/common_alert_dialog.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialState>(
      builder: (context, state) {
        var cubit = context.read<SocialCubit>();
        debugPrint("showShimmer:::${cubit.showShimmer}");
        if (cubit.showShimmer) {
          return Material(child: VerticalListShimmer());
        }

        return Scaffold(
          body: CommonRefreshIndicator(
            onRefresh: () async {
              cubit.callFriendListApi();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Pending Battle Requests::
                  if (state.battleRequests.isNotEmpty) ...[
                    CommonText(
                      text: "Incoming Challenges (${state.battleRequests.length})",
                      fontWeight: FontWeight.bold,
                      fontSize: size(context).width * numD04,
                    ),
                    SizedBox(height: size(context).width * numD02),
                    ListView.builder(
                      itemCount: state.battleRequests.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: size(context).width * numD02),
                      itemBuilder: (context, idx) {
                        final item = state.battleRequests[idx];

                        return InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: commonBgColorDecoration(
                              size(context).width * numD04,
                              Colors.white,
                            ),
                            padding: EdgeInsets.all(size(context).width * numD04),
                            margin: EdgeInsets.symmetric(vertical: size(context).width * numD01),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipOval(
                                      child: CommonImage(
                                        imagePath: item.userImage ?? "",
                                        isNetwork: true,
                                        width: size(context).width * numD1,
                                        height: size(context).width * numD1,
                                      ),
                                    ),
                                    SizedBox(width: size(context).width * numD02),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CommonText(
                                          text: item.name ?? "",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: size(context).width * numD04,
                                        ),
                                        CommonText(
                                          text: item.userName ?? "",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: size(context).width * numD03,
                                        ),
                                        SizedBox(height: size(context).width * numD01),
                                        CommonText(
                                          text: "Want's to battle with you !",
                                          color: Colors.grey,
                                          fontSize: size(context).width * numD03,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: size(context).width * numD02),
                                Row(
                                  children: [
                                    Expanded(
                                      child: commonOutlinedButton(
                                        onTap: () {
                                          cubit.callCancelBattleReqApi(item.battleId.toString());
                                        },
                                        size: size(context),
                                        radius: numD03,
                                        borderColor: Colors.red,
                                        buttonHeight: size(context).width * numD1,
                                        buttonText: const CommonText(
                                          text: "Cancel",
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: size(context).width * numD02),
                                    Expanded(
                                      child: commonShortButton(
                                        onTap: () {
                                          if (item.battleId != null) {
                                            cubit.callAcceptBattleReqApi(
                                              item.battleId.toString(),
                                              item.referenceId.toString(),
                                            );
                                          }
                                        },
                                        size: size(context),
                                        radius: size(context).width * numD03,
                                        buttonHeight: size(context).width * numD1,
                                        buttonText: "Accept Battle",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: size(context).width * numD04),
                  ],

                  /// Pending friend Requests::
                  if (state.pendingRequests.isNotEmpty) ...[
                    SizedBox(height: size(context).width * numD04),
                    CommonText(
                      text: "Pending Requests (${state.pendingRequests.length})",
                      fontWeight: FontWeight.bold,
                      fontSize: size(context).width * numD04,
                    ),
                    SizedBox(height: size(context).width * numD02),
                    ListView.builder(
                      itemCount: state.pendingRequests.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: size(context).width * numD02),
                      itemBuilder: (context, idx) {
                        final request = state.pendingRequests[idx];
                        return InkWell(
                          onTap: () {
                            router.push(
                              AppRouter.otherProfileScreen,
                              extra: {"userId": request.requester?.sId},
                            );
                          },
                          child: Container(
                            decoration: commonBgColorDecoration(
                              size(context).width * numD04,
                              Colors.white,
                            ),
                            padding: EdgeInsets.all(size(context).width * numD04),
                            margin: EdgeInsets.symmetric(vertical: size(context).width * numD01),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: CommonImage(
                                    imagePath:
                                        request.requester?.avatar?.picture?.isNotEmpty == true
                                        ? request.requester?.avatar!.picture!.first.fullPath ?? ""
                                        : "",
                                    isNetwork: true,
                                    width: size(context).width * numD1,
                                    height: size(context).width * numD1,
                                  ),
                                ),
                                SizedBox(width: size(context).width * numD02),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: request.requester?.name ?? "",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: size(context).width * numD04,
                                    ),
                                    CommonText(
                                      text: request.requester?.userName ?? "",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: size(context).width * numD03,
                                    ),
                                    SizedBox(height: size(context).width * numD02),

                                    Container(
                                      decoration: commonBgColorDecoration(
                                        size(context).width * numD04,
                                        CommonColors.secondaryColor,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size(context).width * numD02,
                                      ),
                                      child: CommonText(
                                        text: "Level ${request.requester?.level.toString()}",
                                        color: Colors.black,
                                        fontSize: size(context).width * numD03,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                commonShortButton(
                                  onTap: () {
                                    cubit.callAcceptReqApi(request.id.toString());
                                    // cubit.acceptRequest(idx);
                                  },
                                  size: size(context),
                                  radius: size(context).width * numD03,
                                  buttonHeight: size(context).width * numD10,
                                  buttonText: "Accept",
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.callCancelRequestApi(request.id.toString());
                                  },
                                  icon: Container(
                                    decoration: commonOutlineDecoration(
                                      size(context).width * numD02,
                                      1,
                                      CommonColors.buttonColor,
                                    ),
                                    padding: EdgeInsets.all(size(context).width * numD015),
                                    child: const Icon(Icons.close, color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: size(context).width * numD04),
                  ],

                  /// My friend::
                  if (state.myFriends.isNotEmpty) ...[
                    CommonText(
                      text: "My Friends (${state.myFriends.length})",
                      fontWeight: FontWeight.bold,
                      fontSize: size(context).width * numD04,
                    ),
                    SizedBox(height: size(context).width * numD02),
                    ListView.builder(
                      itemCount: state.myFriends.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: size(context).width * numD02),
                      itemBuilder: (context, idx) {
                        final friend = state.myFriends[idx];
                        return InkWell(
                          onTap: () {
                            router.push(
                              AppRouter.otherProfileScreen,
                              extra: {"userId": friend.sId},
                            );
                          },
                          child: Container(
                            decoration: commonBgColorDecoration(
                              size(context).width * numD04,
                              Colors.white,
                            ),
                            padding: EdgeInsets.all(size(context).width * numD04),
                            margin: EdgeInsets.symmetric(vertical: size(context).width * numD01),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: CommonImage(
                                    imagePath: friend.avatar?.picture?.isNotEmpty == true
                                        ? friend.avatar!.picture!.first.fullPath ?? ""
                                        : "",
                                    isNetwork: true,
                                    width: size(context).width * numD1,
                                    height: size(context).width * numD1,
                                  ),
                                ),
                                SizedBox(width: size(context).width * numD02),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: friend.name ?? "",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: size(context).width * numD04,
                                    ),
                                    CommonText(
                                      text: friend.userName ?? "",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: size(context).width * numD03,
                                    ),
                                    SizedBox(height: size(context).width * numD02),
                                    Container(
                                      decoration: commonBgColorDecoration(
                                        size(context).width * numD04,
                                        CommonColors.secondaryColor,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size(context).width * numD02,
                                      ),
                                      child: CommonText(
                                        text: "Level ${friend.level.toString()}",
                                        color: Colors.black,
                                        fontSize: size(context).width * numD03,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    cubit.callRoomIdApi(friend);
                                  },
                                  icon: Container(
                                    decoration: commonOutlineDecoration(
                                      size(context).width * numD02,
                                      1,
                                      Colors.green,
                                    ),
                                    padding: EdgeInsets.all(size(context).width * numD015),
                                    child: CommonImage(
                                      imagePath: Assets.iconsIcMessage,
                                      color: Colors.green,
                                      height: size(context).width * numD07,
                                      width: size(context).width * numD07,
                                      isNetwork: false,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    debugPrint("${friend.toJson()}");
                                    if (friend.relationId != null) {
                                      CommonAlertDialog.show(
                                        context: context,
                                        heading: "Remove",
                                        subTitle: "Are you sure you want to remove?",
                                        onFirstButtonTap: () {
                                          router.pop();
                                          cubit.callUnfollowApi(friend.relationId.toString());
                                        },
                                        onSecondButtonTap: () {
                                          router.pop();
                                        },
                                      );
                                    }
                                  },
                                  icon: Container(
                                    decoration: commonOutlineDecoration(
                                      size(context).width * numD02,
                                      1,
                                      Colors.red,
                                    ),
                                    padding: EdgeInsets.all(size(context).width * numD015),
                                    child: const Icon(
                                      Icons.person_remove_alt_1_rounded,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: size(context).width * numD04),
                  ],

                  if (state.pendingRequests.isEmpty && state.myFriends.isEmpty) ...[
                    SizedBox(height: size(context).height / 3),
                    Padding(
                      padding: EdgeInsets.all(size(context).width * numD04),
                      child: CommonText(
                        text:
                            "Your friend list is empty right now. Let's change that!\nUse the Add icon above to invite someone!",
                        color: Colors.white,
                        textAlign: TextAlign.center,
                        fontSize: size(context).width * numD04,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
