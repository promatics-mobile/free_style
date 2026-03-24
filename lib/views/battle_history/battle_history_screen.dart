import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/common_image/common_image.dart';

import '../../generated/assets.dart';
import '../../main.dart';
import '../../network_class/web_urls.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_decorations/common_decorations.dart';
import '../../utils/common_methods.dart';
import '../../utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_refresh_indicator/common_refresh_indicator.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import '../match_making/match_making_cubit.dart';
import 'battle_history_cubit.dart';

class BattleHistoryScreen extends StatelessWidget {
  const BattleHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeColor,
      appBar: const CommonAppBar(title: "Battle History"),
      body: BlocBuilder<BattleHistoryCubit, BattleHistoryState>(
        builder: (context, state) {
          final cubit = context.read<BattleHistoryCubit>();

          return CommonRefreshIndicator(
            onRefresh: () async {
              cubit.fetchBattleHistory(isRefresh: true);
            },
            onLoadMore: () async {
              cubit.fetchBattleHistory();
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.all(size(context).width * numD04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔥 ACTIVE BATTLE
                  if (cubit.activeBattle != null) _buildActiveBattle(context, cubit.activeBattle!),

                  if (cubit.activeBattle != null) SizedBox(height: size(context).width * numD05),

                  /// 🔥 PAST BATTLES
                  CommonText(
                    text: "Past Battles",
                    fontSize: size(context).width * numD04,
                    fontWeight: FontWeight.bold,
                  ),

                  SizedBox(height: size(context).width * numD04),

                  _buildBattleList(context, cubit.historyList),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActiveBattle(BuildContext context, BattleHistoryModel item) {
    final isUser1 = item.user1!.id == sharedPreferences.getString(PreferenceKeys.userIdKey);

    final me = isUser1 ? item.user1 : item.user2;
    final opponent = isUser1 ? item.user2 : item.user1;

    return Container(
      decoration: commonBgColorDecoration(size(context).width * numD03, Colors.white),
      padding: EdgeInsets.all(size(context).width * numD04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonText(
            text: "Active Battle",
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: size(context).width * numD04,
          ),
          SizedBox(height: size(context).width * numD02),

          CommonText(
            text: item.battleName,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: size(context).width * numD035,
          ),

          /// 👇 PLAYERS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _playerCard(context, "You", me, ""),
              CircleAvatar(
                backgroundColor: CommonColors.buttonColor,
                radius: size(context).width * numD05,
                child: CommonText(text: "VS", color: Colors.white),
              ),
              _playerCard(context, opponent != null ? opponent.name : "", opponent, ""),
            ],
          ),

          /// 👇 BATTLE INFO
          Container(
            decoration: commonBgColorDecoration(size(context).width * numD03, Colors.white),
            padding: EdgeInsets.all(size(context).width * numD04),
            child: Column(
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.watch_later_outlined, color: Colors.red),
                    SizedBox(width: size(context).width * numD01),
                    CommonText(
                      text: _remainingTime(item.finishedAt ?? DateTime.now()),
                      color: Colors.red,
                    ),
                  ],
                ),

                SizedBox(height: size(context).width * numD02),
                CommonText(
                  text: item.battleDescription,
                  textAlign: TextAlign.center,
                  color: Colors.black,
                ),
              ],
            ),
          ),

          SizedBox(height: size(context).width * numD05),

          CommonButton(
            onTap: () {
              router.push(AppRouter.matchMakingScreen, extra: {
                "reference_id": item.id,
              },);

            },
            text: "Continue Battle",
          ),
        ],
      ),
    );
  }

  Widget _playerCard(BuildContext context, String label, User? user, String tier) {
    final isUserAvailable = user != null;

    return Column(
      children: [
        CircleAvatar(
          radius: size(context).width * numD1,
          backgroundColor: Colors.grey.shade200,
          child: isUserAvailable
              ? user.avatar!.isNotEmpty
              ? ClipOval(
            child: CommonImage(
              imagePath: user.avatar??"",
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

        CommonText(text: label,
            color: Colors.black,
            fontWeight: FontWeight.bold),

      ],
    );
  }

  Widget _stat(String title, String value) {
    return Column(
      children: [
        CommonText(text: value, fontWeight: FontWeight.bold),
        CommonText(text: title),
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

  Widget _buildBattleList(BuildContext context, List<BattleHistoryModel> list) {
    if (list.isEmpty) {
      return const Center(child: CommonText(text: "No battles found"));
    }

    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = list[index];
        return _battleCard(context, item);
      },
    );
  }

  Widget _battleCard(BuildContext context, BattleHistoryModel item) {

    final winner = item.winner;
    final myId = sharedPreferences.getString(PreferenceKeys.userIdKey);
    final isMe = winner!.id == myId;

    final avatar = winner.equipped?.avatar?.pictures.isNotEmpty == true
        ? winner.equipped!.avatar!.pictures.first.getFileUrl(mediaBaseUrl) ?? ""
        : "";

    final isUser1 = item.user1!.id ==
            sharedPreferences.getString(PreferenceKeys.userIdKey);

    final me = isUser1 ? item.user1 : item.user2;
    final opponent = isUser1
        ? item.user2
        : item.user1;

    return Container(
      margin: EdgeInsets.only(bottom: size(context).width * numD03),
      padding: EdgeInsets.all(size(context).width * numD04),
      decoration: commonBgColorDecoration(size(context).width * numD03, Colors.white),
      child: Column(
        children: [
          Row(
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
                    CommonText(
                      text: item.battleDescription,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: size(context).width * numD035,
                    ),

                    ])
              ),
            ],
          ),

          SizedBox(height: size(context).width * numD04),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _playerCard(context, "You", me, ""),
              CircleAvatar(
                backgroundColor: CommonColors.buttonColor,
                radius: size(context).width * numD05,
                child: CommonText(text: "VS", color: Colors.white),
              ),
              _playerCard(
                context,
                opponent != null ? opponent.name : "",
                opponent,
                "",
              ),
            ],
          ),

          SizedBox(height: size(context).width * numD04),

          /// 🔥 REWARDS
          Container(
            decoration: commonBgColorDecoration(size(context).width * numD02, Colors.green.shade100),
            padding: EdgeInsets.all(size(context).width * numD02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _rewardItem("XP", item.getReward("xp"), isMe),
                _rewardItem("Coins", item.getReward("coins"),isMe),
                _rewardItem("RP", item.getReward("rp"),isMe),
              ],
            ),
          ),

          SizedBox(height: size(context).width * numD02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: item.formattedDate,
                color: Colors.grey,
                fontSize: size(context).width * numD03,
              ),

              CommonText(
                text: isMe ? "VICTORY" : "DEFEAT",
                color: isMe ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _userAvatar(String name) {
    return CircleAvatar(radius: 18, child: Text(name.isNotEmpty ? name[0] : ""));
  }

  Widget _rewardItem(String title, int value, bool isWinner) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonText(text: "${isWinner ? "+" : "-"} $value", color:
        isWinner ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
        CommonText(text: title,
            fontWeight: FontWeight.bold,
            color: Colors.black, fontSize: 12),
      ],
    );
  }

  Widget _statusBadge(String status) {
    Color color;

    switch (status) {
      case "completed":
        color = Colors.green;
        break;
      case "active":
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CommonText(text: status.toUpperCase(), color: color, fontSize: 12),
    );
  }
}
