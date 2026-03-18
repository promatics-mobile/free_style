import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/common_button/common_short_button.dart';
import 'package:free_style/views/social/social_cubit.dart';

import '../../generated/assets.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_methods.dart';
import '../../utils/common_widgets/common_image/common_image.dart';
import '../../utils/common_widgets/common_text/common_text.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialState>(
      builder: (context, state) {
        var cubit = context.read<SocialCubit>();
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: "Incoming Challenges (${cubit.incomingChallenges.length})",
                  fontWeight: FontWeight.bold,
                  fontSize: size(context).width * numD04,
                ),
                SizedBox(height: size(context).width * numD02),
                cubit.incomingChallenges.isEmpty
                    ? const Center(child: Text("No incoming challenges"))
                    : ListView.builder(
                        itemCount: cubit.incomingChallenges.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: size(context).width * numD02),
                        itemBuilder: (context, idx) {
                          final challenge = cubit.incomingChallenges[idx];
                          return InkWell(
                            onTap: () {
                              // router.push(AppRouter.otherProfileScreen, extra: {"userId": ""});
                            },
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
                                          imagePath: Assets.assetsIcDummyUser2,
                                          width: size(context).width * numD1,
                                          height: size(context).width * numD1,
                                          isNetwork: false,
                                        ),
                                      ),
                                      SizedBox(width: size(context).width * numD02),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CommonText(
                                            text: challenge.name,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size(context).width * numD04,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: size(context).width * numD02,
                                            ),
                                            child: CommonText(
                                              text:
                                                  "${challenge.level} ${CommonSymbol.dotSymbol} ${challenge.message}",
                                              color: Colors.black,
                                              fontSize: size(context).width * numD03,
                                            ),
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
                                            cubit.cancelChallenge(idx);
                                            showToast(
                                              isError: true,
                                              message: "Challenge cancelled",
                                            );
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
                                            router.push(AppRouter.matchMakingScreen);
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

                if (state.pendingRequests.isNotEmpty) ...[
                  SizedBox(height: size(context).width * numD04),

                  CommonText(
                    text: "Pending Requests (${state.pendingRequests.length})",
                    fontWeight: FontWeight.bold,
                    fontSize: size(context).width * numD04,
                  ),
                ],

                SizedBox(height: size(context).width * numD02),
                state.pendingRequests.isEmpty
                    ? const Center(child: Text("No pending requests"))
                    : ListView.builder(
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
                                        text: request.requester?.userName ?? "",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: size(context).width * numD04,
                                      ),
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
                state.myFriends.isNotEmpty
                    ? CommonText(
                        text: "My Friends (${state.myFriends.length})",
                        fontWeight: FontWeight.bold,
                        fontSize: size(context).width * numD04,
                      )
                    : SizedBox.shrink(),
                SizedBox(height: size(context).width * numD02),
                state.myFriends.isEmpty
                    ? Center(
                        child: CommonText(
                          text: "No friends added yet",

                          fontSize: size(context).width * numD034,
                        ),
                      )
                    : ListView.builder(
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
                                      // imagePath: Assets.assetsIcDummyUser2,
                                      width: size(context).width * numD1,
                                      height: size(context).width * numD1,
                                    ),
                                  ),
                                  SizedBox(width: size(context).width * numD02),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                        text: friend.userName ?? "",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: size(context).width * numD04,
                                      ),
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
                                  commonShortButton(
                                    onTap: () {
                                      showToast(
                                        isError: false,
                                        message: "Invite sent to ${friend.name}",
                                      );
                                    },
                                    size: size(context),
                                    radius: size(context).width * numD03,
                                    buttonHeight: size(context).width * numD10,
                                    buttonText: "Invite",
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (friend.relationStatus?.relationId != null) {
                                        cubit.callUnfollowApi(
                                          friend.relationStatus!.relationId.toString(),
                                        );
                                      }

                                      // cubit.removeFriend(idx);
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
              ],
            ),
          ),
        );
      },
    );
  }
}
