import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'notification_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsState(selectedTabIndex: 0)){
    selectedNotificationList = List.from(notificationsList);
  }

  var treatmentReminder = false;
  var appointmentAlert = false;
  var messageNotification = false;
  var markAllRead = false;

  List<NotificationModel> notificationsList = [
    NotificationModel(
      title: "Your prescription refill has been approved",
      description: "You can now request delivery or collection. Tap to view.",
      timeAgo: "2h ago",
      priority: NotificationPriority.medium,
      icon: Icons.medical_services_outlined,
      type: "prescription_detail",
    ),
    NotificationModel(
      title: "Appointment reminder",
      description: "Your appointment with Dr. Smith is tomorrow at 2:00 PM.",
      timeAgo: "Yesterday",
      priority: NotificationPriority.medium,
      icon: Icons.calendar_today_outlined,
      type: "appointment_detail",
    ),
    NotificationModel(
      title: "New message from Dr. Johnson",
      description: "Please continue your current dosage and monitor side effects.",
      timeAgo: "3d ago",
      priority: NotificationPriority.high,
      icon: Icons.message_outlined,
      type: "messages",
    ),
    NotificationModel(
      title: "Sleep pattern improvement",
      description: "Your sleep improved by 20% on evening oil use.",
      timeAgo: "5d ago",
      priority: NotificationPriority.low,
      icon: Icons.hotel_outlined,
      type: "sleep_insights",
    ),
    NotificationModel(
      title: "Payment confirmation",
      description: "Payment of £50 received for consultation on 12 April.",
      timeAgo: "1w ago",
      priority: NotificationPriority.low,
      icon: Icons.payment_outlined,
      type: "payment_history",
    ),
    NotificationModel(
      title: "Missed doses alert",
      description: "You missed 3 doses this week. Need help with reminders?",
      timeAgo: "1w ago",
      priority: NotificationPriority.medium,
      icon: Icons.warning_amber_outlined,
      type: "medication_tracker",
    ),
    NotificationModel(
      title: "New script issued",
      description: "New script issued for Cycle A: Northern Lights 20% THC.",
      timeAgo: "2w ago",
      priority: NotificationPriority.low,
      icon: Icons.receipt_long_outlined,
      type: "script_detail",
    ),
  ];
  List<NotificationModel> selectedNotificationList = [];


  List<CommonTabModel> notificationTabList = [
    CommonTabModel(title: "all", icon: Icons.list, isSelected: true),
    CommonTabModel(
        title: "prescription_detail", icon: Icons.sticky_note_2_outlined, isSelected: false),
    CommonTabModel(
        title: "appointment_detail", icon: Icons.calendar_today_outlined, isSelected: false),
    CommonTabModel(
        title: "messages", icon: Icons.chat_bubble_outline, isSelected: false),
    CommonTabModel(title: "sleep_insights", icon: Icons.android_outlined, isSelected: false),
    CommonTabModel(
        title: "script_detail",
        icon: Icons.notifications_active_outlined,
        isSelected: false),
  ];

  onChangeNotificationTab(int index) {
    filterNotifications(notificationTabList[index].title);
    Future.delayed(Duration(milliseconds: 500));
    int pos = notificationTabList.indexWhere((e) => e.isSelected);
    if (pos >= 0) {
      notificationTabList[pos].isSelected = false;
    }
    notificationTabList[index].isSelected = true;
    emit(state.copyWith(selectedTabIndex: index));
  }


  void filterNotifications(String selectedType) {
    if (selectedType == "all") {
      selectedNotificationList = List.from(notificationsList);
    } else {
      selectedNotificationList = notificationsList
          .where((notification) => notification.type == selectedType)
          .toList();
    }
    emit(state.copyWith());
  }

  treatmentReminderFn(){
    treatmentReminder = !treatmentReminder;
    emit(state.copyWith());
  }
  appointmentAlertFn(){
    appointmentAlert = !appointmentAlert;
    emit(state.copyWith());
  }
  messageNotificationFn(){
    messageNotification = !messageNotification;
    emit(state.copyWith());
  }
  markAllReadFn(){
    markAllRead = !markAllRead;
    emit(state.copyWith());
  }
}

class CommonTabModel {
  String title = "";
  IconData icon;
  bool isSelected = false;

  CommonTabModel(
      {required this.title, required this.icon, required this.isSelected});
}


enum NotificationPriority { low, medium, high }

class NotificationModel {
  final String title;
  final String description;
  final String timeAgo;
  final NotificationPriority priority;
  final IconData icon;
  final bool isViewed;
  final String actionLabel;
  final String type;

  NotificationModel({
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.priority,
    required this.icon,
    this.isViewed = false,
    this.actionLabel = "View",
    required this.type,
  });
}

