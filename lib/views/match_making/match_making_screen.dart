import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/main.dart';
import 'package:free_style/network_class/web_urls.dart';
import 'package:free_style/routes/route.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_button/common_button.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import 'package:free_style/utils/common_widgets/common_image/common_image.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/views/match_making/match_making_cubit.dart';

import '../../utils/common_constants.dart';

class MatchMakingScreen extends StatelessWidget {
  const MatchMakingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Match Making"),
      body: BlocBuilder<MatchMakingCubit, MatchMakingState>(
        builder: (context, state) {
          var cubit = context.read<MatchMakingCubit>();

          if (cubit.ongoingBattleModel == null) {
            return Container();
          }

          final isUser1 =
              cubit.ongoingBattleModel!.user1!.id ==
              sharedPreferences.getString(PreferenceKeys.userIdKey);

          final me = isUser1 ? cubit.ongoingBattleModel!.user1 : cubit.ongoingBattleModel!.user2;
          final opponent = isUser1
              ? cubit.ongoingBattleModel!.user2
              : cubit.ongoingBattleModel!.user1;

          final hasUploadedVideo = isUser1
              ? cubit.ongoingBattleModel!.user1Video != null
              : cubit.ongoingBattleModel!.user2Video != null;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
            child: Column(
              children: [
                CommonText(
                  text: cubit.ongoingBattleModel!.winner == null
                      ? "Opponent Matched!"
                      : "Result Declared!",
                  fontWeight: FontWeight.bold,
                  fontSize: size(context).width * numD05,
                ),

                CommonText(
                  text: cubit.ongoingBattleModel!.battle!.name,
                  textAlign: TextAlign.center,
                  fontSize: size(context).width * numD035,
                ),

                SizedBox(height: size(context).width * numD1),

                /// 👇 PLAYERS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _playerCard(context, "You", me, cubit.ongoingBattleModel!.battle!.tierName),
                    CircleAvatar(
                      backgroundColor: CommonColors.buttonColor,
                      radius: size(context).width * numD05,
                      child: CommonText(text: "VS", color: Colors.white),
                    ),
                    _playerCard(
                      context,
                      opponent != null ? opponent.name : "",
                      opponent,
                      cubit.ongoingBattleModel!.battle!.tierName,
                    ),
                  ],
                ),

                SizedBox(height: size(context).width * numD1),

                /// 👇 BATTLE INFO
                Container(
                  decoration: commonBgColorDecoration(size(context).width * numD03, Colors.white),
                  padding: EdgeInsets.all(size(context).width * numD04),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.watch_later_outlined, color: Colors.red),
                          SizedBox(width: size(context).width * numD01),
                          CommonText(
                            text:
                            cubit.ongoingBattleModel!.winner == null ?
                            _remainingTime(cubit.ongoingBattleModel!.updatedAt!) : "Battle Ended",
                            color: Colors.red,
                          ),
                        ],
                      ),

                      SizedBox(height: size(context).width * numD02),

                      CommonText(
                        text: cubit.ongoingBattleModel!.battle!.description,
                        textAlign: TextAlign.center,
                        color: Colors.grey,
                      ),

                      Divider(),

                      /// 👇 REWARDS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _stat(
                            context,
                            "XP",
                            cubit.ongoingBattleModel!,
                            cubit.ongoingBattleModel!.battle!.xp.toString(),
                          ),
                          _stat(
                            context,
                            "Coins",
                            cubit.ongoingBattleModel!,
                            cubit.ongoingBattleModel!.battle!.coins.toString(),
                          ),
                          //_stat("Tier", cubit.ongoingBattleModel!.battle!.tierName),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size(context).width * numD1),

                /// Winner UI ::
                cubit.ongoingBattleModel!.winner != null
                    ? buildWinnerUI(context, cubit.ongoingBattleModel!)
                    : Column(
                        children: [
                          CommonText(
                            text: hasUploadedVideo
                                ? "You have submitted your video"
                                : "Submit your video to start",
                            color: hasUploadedVideo ? Colors.green : Colors.orange,
                          ),
                          SizedBox(height: size(context).width * numD03),
                          CommonButton(
                            onTap: () {
                              if (hasUploadedVideo) {
                                return;
                              }
                              router
                                  .push(
                                    AppRouter.submitProofScreen,
                                    extra: {"id": cubit.ongoingBattleModel!.id, "type": "battle"},
                                  )
                                  .then((_) {
                                    cubit.callOngoingBattleApi();
                                  });
                            },
                            text: hasUploadedVideo ? "Submitted" : "Start Battle",
                          ),
                        ],
                      ),

                /// If Video is not uploaded  then cancel::
                if (!hasUploadedVideo) ...[
                  SizedBox(height: size(context).width * numD02),
                  CommonGradientButton(onTap: () => router.pop(), text: "Cancel Match"),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _playerCard(BuildContext context, String label, User? user, String tier) {
    final isUserAvailable = user != null;

    debugPrint("_playerCard::${user?.equipped?.avatar!.pictures.first.getFileUrl(mediaBaseUrl)}");
    return Column(
      children: [
        CircleAvatar(
          radius: size(context).width * numD15,
          backgroundColor: Colors.grey.shade200,
          child: isUserAvailable
              ? user.equipped != null
                    ? ClipOval(
                        child: CommonImage(
                          imagePath: user.equipped!.avatar!.pictures.first.getFileUrl(mediaBaseUrl),
                          isNetwork: true,
                        ),
                      )
                    : Text(
                        user.name.isNotEmpty ? user.name[0].toUpperCase() : "?",
                        style: TextStyle(
                          fontSize: size(context).width * numD06,
                          fontWeight: FontWeight.bold,
                        ),
                      )
              : Icon(Icons.person, size: size(context).width * numD08, color: Colors.grey),
        ),

        SizedBox(height: size(context).width * numD01),

        CommonText(text: label, fontWeight: FontWeight.bold),

        /*CommonText(
          text: isUserAvailable ? "Level ${user.level}" : "Waiting...",
          color: isUserAvailable ? Colors.white : Colors.grey,
        ),

        CommonText(
          text: isUserAvailable ? tier : "-",
          color: isUserAvailable ? Colors.white : Colors.grey,
        ),*/
      ],
    );
  }

  Widget _stat(BuildContext context, String title, OngoingBattleModel battle, String value) {
    bool? isMe;
    if(battle.winner !=null){
      final winner = battle.winner!;
      final myId = sharedPreferences.getString(PreferenceKeys.userIdKey);
      isMe = winner.id == myId;
    }


    return Column(
      children: [
        if(isMe ==null)
          CommonText(
            text: value,
            color: Colors.black,
            fontSize: size(context).width * numD05,
            fontWeight: FontWeight.bold,
          )else
        CommonText(
          text: "${isMe ? "+" : "-"} $value",
          color: isMe ? Colors.green : Colors.red,
          fontSize: size(context).width * numD05,
          fontWeight: FontWeight.bold,
        ),
        CommonText(text: title, color: Colors.black, fontWeight: FontWeight.bold),
      ],
    );
  }

  String _remainingTime(DateTime updatedAt) {
    final end = updatedAt.add(const Duration(hours: 24));
    final diff = end.difference(DateTime.now());

    final h = diff.inHours;
    final m = diff.inMinutes.remainder(60);

    return "${h}h ${m}m Remaining";
  }

  Widget buildWinnerUI(BuildContext context, OngoingBattleModel battle) {
    if (battle.winner == null) return const SizedBox();

    final winner = battle.winner!;
    final myId = sharedPreferences.getString(PreferenceKeys.userIdKey);
    final isMe = winner.id == myId;

    final avatar = winner.equipped?.avatar?.pictures.isNotEmpty == true
        ? winner.equipped!.avatar!.pictures.first.getFileUrl(mediaBaseUrl) ?? ""
        : "";

    return Container(
      padding: EdgeInsets.all(size(context).width * numD04),
      margin: EdgeInsets.only(bottom: size(context).width * numD04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size(context).width * numD04),
        gradient: LinearGradient(colors: [Colors.amber.shade200, Colors.orange.shade400]),
        boxShadow: [
          BoxShadow(color: Colors.orange.withValues(alpha: 0.3), blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Column(
        children: [
          CommonText(
            text: "Result",
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: size(context).width * numD05,
          ),

          SizedBox(height: size(context).width * numD04),

          /// 👤 Avatar
          CircleAvatar(
            radius: size(context).width * numD15,
            backgroundColor: Colors.white,
            backgroundImage: avatar.isNotEmpty ? NetworkImage(avatar) : null,
            child: avatar.isEmpty
                ? Icon(Icons.person, size: size(context).width * numD1, color: Colors.grey)
                : null,
          ),

          SizedBox(height: size(context).width * numD03),

          /// 🧑 Name
          CommonText(
            text: isMe ? "🏆 You Won!" : "Winner : ${winner.name ?? ""}",
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: size(context).width * numD05,
          ),

          SizedBox(height: size(context).width * numD02),

          /// 🎉 Subtitle
          CommonText(
            text: isMe
                ? "Congratulations! 🎉 You won the battle and showcased your skills brilliantly!"
                : "Good effort! 💪 You gave it your best—keep practicing and come back stronger!",
            color: Colors.black,
            textAlign: TextAlign.center,
            fontSize: size(context).width * numD035,
          ),
        ],
      ),
    );
  }
}
