import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
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
            padding:
            EdgeInsets.symmetric(horizontal: size(context).width * numD04),
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
                  padding:
                  EdgeInsets.only(top: size(context).width * numD02),
                  itemBuilder: (context, idx) {
                    final challenge = cubit.incomingChallenges[idx];
                    return InkWell(
                      onTap: () {
                        router.push(AppRouter.otherProfileScreen);
                      },
                      child: Container(
                        decoration: commonBgColorDecoration(
                          size(context).width * numD04,
                          Colors.white,
                        ),
                        padding:
                        EdgeInsets.all(size(context).width * numD04),
                        margin: EdgeInsets.symmetric(
                          vertical: size(context).width * numD01,
                        ),
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
                                SizedBox(
                                    width: size(context).width * numD02),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: challenge.name,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                      size(context).width * numD04,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                        size(context).width * numD02,
                                      ),
                                      child: CommonText(
                                        text:
                                        "${challenge.level} ${CommonSymbol.dotSymbol} ${challenge.message}",
                                        color: Colors.black,
                                        fontSize:
                                        size(context).width * numD03,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                                height: size(context).width * numD02),
                            Row(
                              children: [
                                Expanded(
                                  child: commonOutlinedButton(
                                      onTap: () {
                                        cubit.cancelChallenge(idx);
                                        showToast(isError: true, message: "Challenge cancelled");
                                        },
                                      size: size(context),
                                      radius: numD03,
                                      borderColor: Colors.red,
                                      buttonHeight:
                                      size(context).width * numD1,
                                      buttonText: const CommonText(
                                          text: "Cancel",
                                          color: Colors.red)),
                                ),
                                SizedBox(
                                    width: size(context).width * numD02),
                                Expanded(
                                  child: commonShortButton(
                                      onTap: () {
                                        router.push(
                                            AppRouter.matchMakingScreen);
                                      },
                                      size: size(context),
                                      radius:
                                      size(context).width * numD03,
                                      buttonHeight:
                                      size(context).width * numD1,
                                      buttonText: "Accept Battle"),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: size(context).width * numD04),
                CommonText(
                  text: "Pending Requests (${cubit.pendingRequests.length})",
                  fontWeight: FontWeight.bold,
                  fontSize: size(context).width * numD04,
                ),
                SizedBox(height: size(context).width * numD02),
                cubit.pendingRequests.isEmpty
                    ? const Center(child: Text("No pending requests"))
                    : ListView.builder(
                  itemCount: cubit.pendingRequests.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                  EdgeInsets.only(top: size(context).width * numD02),
                  itemBuilder: (context, idx) {
                    final request = cubit.pendingRequests[idx];
                    return InkWell(
                      onTap: () {
                        router.push(AppRouter.otherProfileScreen);
                      },
                      child: Container(
                        decoration: commonBgColorDecoration(
                          size(context).width * numD04,
                          Colors.white,
                        ),
                        padding:
                        EdgeInsets.all(size(context).width * numD04),
                        margin: EdgeInsets.symmetric(
                          vertical: size(context).width * numD01,
                        ),
                        child: Row(
                          children: [
                            ClipOval(
                              child: CommonImage(
                                imagePath: Assets.assetsIcDummyUser2,
                                width: size(context).width * numD1,
                                height: size(context).width * numD1,
                                isNetwork: false,
                              ),
                            ),
                            SizedBox(
                                width: size(context).width * numD02),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: request.name,
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
                                    horizontal:
                                    size(context).width * numD02,
                                  ),
                                  child: CommonText(
                                    text: request.level,
                                    color: Colors.black,
                                    fontSize:
                                    size(context).width * numD03,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            commonShortButton(
                              onTap: () {
                                cubit.acceptRequest(idx);
                                showToast(isError: false, message: "Friend request accepted");
                              },
                              size: size(context),
                              radius: size(context).width * numD03,
                              buttonHeight: size(context).width * numD10,
                              buttonText: "Accept",
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.rejectRequest(idx);
                                showToast(isError: true, message: "Friend request rejected");
                              },
                              icon: Container(
                                decoration: commonOutlineDecoration(
                                  size(context).width * numD02,
                                  1,
                                  CommonColors.buttonColor,
                                ),
                                padding: EdgeInsets.all(
                                  size(context).width * numD015,
                                ),
                                child: const Icon(Icons.close,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: size(context).width * numD04),
                CommonText(
                  text: "My Friends (${cubit.myFriends.length})",
                  fontWeight: FontWeight.bold,
                  fontSize: size(context).width * numD04,
                ),
                SizedBox(height: size(context).width * numD02),
                cubit.myFriends.isEmpty
                    ? const Center(child: Text("No friends added yet"))
                    : ListView.builder(
                  itemCount: cubit.myFriends.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                  EdgeInsets.only(top: size(context).width * numD02),
                  itemBuilder: (context, idx) {
                    final friend = cubit.myFriends[idx];
                    return InkWell(
                      onTap: () {
                        router.push(AppRouter.otherProfileScreen);
                      },
                      child: Container(
                        decoration: commonBgColorDecoration(
                          size(context).width * numD04,
                          Colors.white,
                        ),
                        padding:
                        EdgeInsets.all(size(context).width * numD04),
                        margin: EdgeInsets.symmetric(
                          vertical: size(context).width * numD01,
                        ),
                        child: Row(
                          children: [
                            ClipOval(
                              child: CommonImage(
                                imagePath: Assets.assetsIcDummyUser2,
                                width: size(context).width * numD1,
                                height: size(context).width * numD1,
                                isNetwork: false,
                              ),
                            ),
                            SizedBox(
                                width: size(context).width * numD02),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: friend.name,
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
                                    horizontal:
                                    size(context).width * numD02,
                                  ),
                                  child: CommonText(
                                    text: friend.level,
                                    color: Colors.black,
                                    fontSize:
                                    size(context).width * numD03,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            commonShortButton(
                              onTap: () {
                                showToast(isError: false, message: "Invite sent to ${friend.name}");
                              },
                              size: size(context),
                              radius: size(context).width * numD03,
                              buttonHeight: size(context).width * numD10,
                              buttonText: "Invite",
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.removeFriend(idx);
                                showToast(isError: true, message: "${friend.name} removed from friends");
                              },
                              icon: Container(
                                decoration: commonOutlineDecoration(
                                  size(context).width * numD02,
                                  1,
                                  Colors.red,
                                ),
                                padding: EdgeInsets.all(
                                  size(context).width * numD015,
                                ),
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

