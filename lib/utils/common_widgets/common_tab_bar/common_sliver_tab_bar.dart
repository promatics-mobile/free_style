import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';

class CommonSliverTabBar extends StatelessWidget {
  final List<String> tabs;
  final List<Widget> views;
  final Widget? flexibleSpace;
  final bool pinned;
  final bool floating;

  const CommonSliverTabBar({
    Key? key,
    required this.tabs,
    required this.views,
    this.flexibleSpace,
    this.pinned = true,
    this.floating = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(tabs.length == views.length,
    "Tabs length and Views length must be same");

    return DefaultTabController(
      length: tabs.length,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: pinned,
                floating: floating,
                expandedHeight: size(context).width / 0.9,
                flexibleSpace: flexibleSpace,
                backgroundColor: CommonColors.themeColor,
                bottom: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  indicatorColor: CommonColors.secondaryColor,
                  labelColor: CommonColors.secondaryColor,
                  unselectedLabelColor: Colors.white,
                  tabs: tabs
                      .map((e) => Tab(text: e))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: views,
          ),
        ),
      ),
    );
  }
}