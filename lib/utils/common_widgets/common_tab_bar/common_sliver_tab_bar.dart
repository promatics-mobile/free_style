import 'package:flutter/material.dart';
import 'package:free_style/utils/common_constants.dart';

class CommonSliverTabBar extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> views;
  final Widget? flexibleSpace;
  final bool pinned;
  final bool floating;

  final Function(int index)? onTap;
  final Function(int index)? onChanged;

  const CommonSliverTabBar({
    super.key,
    required this.tabs,
    required this.views,
    this.flexibleSpace,
    this.pinned = true,
    this.floating = false,
    this.onTap,
    this.onChanged,
  });

  @override
  State<CommonSliverTabBar> createState() => _CommonSliverTabBarState();
}

class _CommonSliverTabBarState extends State<CommonSliverTabBar>
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: widget.pinned,
              floating: widget.floating,
              toolbarHeight: 0,
              expandedHeight: size(context).width / 0.86,
              flexibleSpace: widget.flexibleSpace,
              backgroundColor: CommonColors.themeColor,
              bottom: TabBar(
                controller: _controller,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                indicatorColor: CommonColors.secondaryColor,
                labelColor: CommonColors.secondaryColor,
                unselectedLabelColor: Colors.white,
                onTap: widget.onTap,
                tabs: widget.tabs.map((e) => Tab(text: e)).toList(),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _controller,
          children: widget.views,
        ),
      ),
    );
  }
}
