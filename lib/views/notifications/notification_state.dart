part of 'notification_cubit.dart';

class NotificationsState {
  int? selectedTabIndex;

  NotificationsState({this.selectedTabIndex});

  NotificationsState copyWith({int? selectedTabIndex}) {
    return NotificationsState(
        selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex);
  }
}
