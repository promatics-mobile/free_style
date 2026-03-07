import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';
import 'package:free_style/utils/common_widgets/common_text/common_text.dart';

class CommonTabBar extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> views;
  final double? viewHeight;
  final bool isScrollable;

  final Function(int index)? onTap;
  final Function(int index)? onChanged;

  const CommonTabBar({
    super.key,
    required this.tabs,
    required this.views,
    this.viewHeight,
    this.isScrollable = true,
    this.onTap,
    this.onChanged,
  });

  @override
  State<CommonTabBar> createState() => _CommonTabBarState();
}

class _CommonTabBarState extends State<CommonTabBar>
    with SingleTickerProviderStateMixin {

  late TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: widget.tabs.length, vsync: this);

    _controller.addListener(() {
      if (!_controller.indexIsChanging) {
        widget.onChanged?.call(_controller.index);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.tabs.length == widget.views.length,
    "Tabs length and Views length must be same");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: _controller,
          isScrollable: widget.isScrollable,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          indicatorColor: CommonColors.secondaryColor,
          onTap: widget.onTap,
          tabs: widget.tabs
              .map((title) => Tab(
            child: CommonText(
              text: title,
              fontWeight: FontWeight.w500,
            ),
          ))
              .toList(),
        ),
        SizedBox(height: size(context).width * numD02),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: widget.views,
          ),
        ),
      ],
    );
  }
}