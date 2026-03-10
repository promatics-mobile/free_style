import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';
import 'package:free_style/utils/common_widgets/app_bars/custom_app_bar.dart';
import 'package:free_style/utils/common_widgets/text_form_field/common_text_form_field.dart';
import 'package:free_style/utils/common_widgets/common_button/common_gradient_button.dart';
import '../../generated/assets.dart';
import '../../routes/route.dart';

class GlobalLeadBoardScreen extends StatefulWidget {
  const GlobalLeadBoardScreen({super.key});

  @override
  State<GlobalLeadBoardScreen> createState() => _GlobalLeadBoardScreenState();
}

class _GlobalLeadBoardScreenState extends State<GlobalLeadBoardScreen> {
  int selectedTabIndex = 1; // "Gold" is index 1
  final List<String> tabs = ["Bronze", "Gold", "Silver", "Platinum"];
  
  String selectedTimeRange = "Weekly";
  String selectedRegion = "Global";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeDarkColor,
      appBar: CustomAppBar(
        title: "Global Leaderboard",
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              router.push(AppRouter.leagueRankingScreen);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Horizontal Tabs
          SizedBox(height: size(context).width * numD04),
          _buildTabs(),
          
          // Search Bar
          Padding(
            padding: EdgeInsets.all(size(context).width * numD04),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: commonBgColorDecoration(
                      size(context).width * numD02,
                      Colors.white,
                    ),
                    child: CommonTextFormField(
                      hint: "Search player...",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(size(context).width * numD03),
                        child: Icon(Icons.search, color: Colors.grey.shade400),
                      ),
                      borderRadius: BorderRadius.circular(size(context).width * numD02),
                    ),
                  ),
                ),
                SizedBox(width: size(context).width * numD03),
                InkWell(
                  onTap: () => _showFilterBottomSheet(context),
                  borderRadius: BorderRadius.circular(size(context).width * numD02),
                  child: Container(
                    padding: EdgeInsets.all(size(context).width * numD02),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.blue.shade800, width: 1.5),
                      borderRadius: BorderRadius.circular(size(context).width * numD02),
                    ),
                    child: Icon(Icons.tune, color: Colors.white, size: size(context).width * numD06),
                  ),
                ),
              ],
            ),
          ),
          
          // Leaderboard List
          Expanded(
            child: _buildLeaderboardList(),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(size(context).width * numD06),
              decoration: commonWhiteDecorationTopOnly(size(context), numD08),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                        text: "Filters",
                        color: Colors.black,
                        fontSize: size(context).width * numD055,
                        fontWeight: FontWeight.bold,
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: size(context).width * numD04),

                  // Time Range Section
                  CommonText(
                    text: "Time Range",
                    color: Colors.black,
                    fontSize: size(context).width * numD04,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: size(context).width * numD03),
                  _buildFilterOptions(
                    ["Daily", "Weekly", "Monthly", "All Time"],
                    selectedTimeRange,
                    (val) => setModalState(() => selectedTimeRange = val),
                  ),

                  SizedBox(height: size(context).width * numD06),

                  // Region Section
                  CommonText(
                    text: "Region",
                    color: Colors.black,
                    fontSize: size(context).width * numD04,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: size(context).width * numD03),
                  _buildFilterOptions(
                    ["Global", "My Region"],
                    selectedRegion,
                    (val) => setModalState(() => selectedRegion = val),
                  ),

                  SizedBox(height: size(context).width * numD08),

                  // Apply Button
                  CommonGradientButton(
                    text: "Apply Filters",
                    onTap: () {
                      // Apply filters logic here
                      Navigator.pop(context);
                      setState(() {}); // Trigger refresh on screen
                    },
                  ),
                  SizedBox(height: size(context).width * numD04),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterOptions(List<String> options, String selectedOption, Function(String) onSelect) {
    return Wrap(
      spacing: size(context).width * numD03,
      runSpacing: size(context).width * numD02,
      children: options.map((option) {
        final isSelected = option == selectedOption;
        return GestureDetector(
          onTap: () => onSelect(option),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size(context).width * numD04,
              vertical: size(context).width * numD02,
            ),
            decoration: BoxDecoration(
              color: isSelected ? CommonColors.themeColor : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(size(context).width * numD02),
              border: Border.all(
                color: isSelected ? CommonColors.themeColor : Colors.grey.shade300,
              ),
            ),
            child: CommonText(
              text: option,
              color: isSelected ? Colors.white : Colors.black,
              fontSize: size(context).width * numD035,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTabs() {
    return SizedBox(
      height: size(context).width * numD1,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        itemCount: tabs.length,
        separatorBuilder: (context, index) => SizedBox(width: size(context).width * numD03),
        itemBuilder: (context, index) {
          final isSelected = selectedTabIndex == index;
          return GestureDetector(
            onTap: () => setState(() => selectedTabIndex = index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size(context).width * numD06),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? CommonColors.secondaryColor : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(size(context).width * numD05),
              ),
              child: CommonText(
                text: tabs[index],
                color: isSelected ? Colors.black : Colors.grey.shade400,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLeaderboardList() {
    final players = [
      {"rank": "1", "name": "@NeonNinja", "division": "Gold Div 1", "rp": "1,825 RP", "color": Colors.yellow.shade700},
      {"rank": "2", "name": "@Cryptoking", "division": "Gold Div 1", "rp": "1,820 RP", "color": Colors.grey.shade400},
      {"rank": "3", "name": "@ViperStrike", "division": "Gold Div 1", "rp": "1,800 RP", "color": Colors.orange.shade700},
      {"rank": "4", "name": "@ViperStrike", "division": "Gold Div 1", "rp": "1,800 RP", "color": Colors.transparent},
      {"rank": "5", "name": "@NeonNinja", "division": "Gold Div 1", "rp": "1,798 RP", "color": Colors.transparent},
      {"rank": "6", "name": "@NeonNinja", "division": "Gold Div 1", "rp": "1,798 RP", "color": Colors.transparent},
    ];

    return ListView.separated(
      padding: EdgeInsets.all(size(context).width * numD04),
      itemCount: players.length,
      separatorBuilder: (context, index) => SizedBox(height: size(context).width * numD03),
      itemBuilder: (context, index) {
        final player = players[index];
        return InkWell(
          onTap: (){
            router.push(AppRouter.otherProfileScreen);
          },
          child: Container(
            padding: EdgeInsets.all(size(context).width * numD04),
            decoration: commonBgColorDecoration(
              size(context).width * numD04,
              Colors.white,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: size(context).width * numD08,
                  child: CommonText(
                    text: player["rank"] as String,
                    color: Colors.black,
                    fontSize: size(context).width * numD045,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: size(context).width * numD02),
                CircleAvatar(
                  radius: size(context).width * numD07,
                  backgroundColor: player["color"] as Color,
                  child: CircleAvatar(
                    radius: size(context).width * numD065,
                    backgroundImage: const AssetImage(Assets.assetsIcDummyUser1),
                  ),
                ),
                SizedBox(width: size(context).width * numD04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: player["name"] as String,
                        color: Colors.black,
                        fontSize: size(context).width * numD04,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          Icon(Icons.emoji_events_outlined, color: Colors.orange.shade300, size: size(context).width * numD035),
                          SizedBox(width: size(context).width * numD01),
                          CommonText(
                            text: player["division"] as String,
                            color: Colors.grey.shade500,
                            fontSize: size(context).width * numD03,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CommonText(
                  text: player["rp"] as String,
                  color: Colors.black,
                  fontSize: size(context).width * numD045,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
