import 'package:flutter/material.dart';

import '../../common_constants.dart';

class CommonRefreshIndicator extends StatefulWidget {
  final Widget child;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;
  final ScrollController? controller;
  final bool enableLoadMore;
  final bool hasMoreData;

  const CommonRefreshIndicator({
    super.key,
    required this.child,
    this.onRefresh,
    this.onLoadMore,
    this.controller,
    this.enableLoadMore = true,
    this.hasMoreData = true,
  });

  @override
  State<CommonRefreshIndicator> createState() => _CommonRefreshIndicatorState();
}

class _CommonRefreshIndicatorState extends State<CommonRefreshIndicator> {
  late ScrollController _scrollController;

  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    _scrollController = widget.controller ?? ScrollController();

    if (widget.enableLoadMore) {
      _scrollController.addListener(_scrollListener);
    }
  }

  Future<void> _scrollListener() async {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    /// Trigger lazy loading when near bottom
    if (currentScroll >= maxScroll - 150 &&
        !_isLoadingMore &&
        widget.onLoadMore != null &&
        widget.hasMoreData) {
      setState(() {
        _isLoadingMore = true;
      });

      await widget.onLoadMore!();

      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  Future<void> _handleRefresh() async {
    if (widget.onRefresh != null) {
      await widget.onRefresh!();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: CommonColors.secondaryColor,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.child,

              /// Bottom Loader
              if (_isLoadingMore)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
