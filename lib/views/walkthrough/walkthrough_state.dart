class WalkthroughState {
  double currentPage = 0;

  WalkthroughState({
    required this.currentPage,
  });

  WalkthroughState copyWith({double? currentPage}) {
    return WalkthroughState(currentPage: currentPage ?? this.currentPage);
  }
}
