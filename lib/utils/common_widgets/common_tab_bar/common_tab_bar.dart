import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';

class CommonTabBar extends StatelessWidget {
  final List<String> tabs;
  final List<Widget> views;
  final double? viewHeight;
  final bool isScrollable;

  const CommonTabBar({
    Key? key,
    required this.tabs,
    required this.views,
    this.viewHeight,
    this.isScrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(tabs.length == views.length,
    "Tabs length and Views length must be same");

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: isScrollable,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            indicatorColor: CommonColors.secondaryColor,
            tabs: tabs.map((title) => Tab(
              child: CommonText(
                text: title,
                fontWeight: FontWeight.w500,
              ),
            )).toList(),
          ),
          SizedBox(height: size(context).width * numD02,),
          Expanded(
            child: TabBarView(
              children: views,
            ),
          ),
        ],
      ),
    );
  }
}