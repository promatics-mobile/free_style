import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'notification_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsState(selectedTabIndex: 0));

  List<NotificationModel> notificationsList = [
    NotificationModel(
      title: "Battle Victory!",
      description: "You successfully defeated @ShadowStriker in the arena. +50 RP earned.",
      timeAgo: "2h ago",
      icon: Icons.emoji_events_outlined,
      type: "battles",
    ),
    NotificationModel(
      title: "Challenge Approved!",
      description: "Your submission for 'Technical Trio' has been verified. Rewards added.",
      timeAgo: "3h ago",
      icon: Icons.check_circle_outline,
      type: "challenges",
    ),
    NotificationModel(
      title: "New Friend Request",
      description: "@NeonNinja wants to connect with you. Tap to accept.",
      timeAgo: "5h ago",
      icon: Icons.person_add_outlined,
      type: "social",
    ),
    NotificationModel(
      title: "Daily Mission Update",
      description: "New daily tasks are available! Complete them to earn extra XP.",
      timeAgo: "Yesterday",
      icon: Icons.assignment_outlined,
      type: "missions",
    ),
    NotificationModel(
      title: "Promotion!",
      description: "Congratulations! You've climbed the ranks to Gold League II.",
      timeAgo: "1d ago",
      icon: Icons.trending_up,
      type: "league",
    ),
    NotificationModel(
      title: "Battle Request",
      description: "@Cryptoking has challenged you to a 1v1 match in the Sector 7.",
      timeAgo: "2d ago",
      icon: Icons.sports_kabaddi_outlined,
      type: "battles",
    ),
    NotificationModel(
      title: "Shop Reward",
      description: "You've earned a discount coupon for the 'Classic Sphere' ball.",
      timeAgo: "3d ago",
      icon: Icons.local_offer_outlined,
      type: "rewards",
    ),
  ];


}




class NotificationModel {
  final String title;
  final String description;
  final String timeAgo;
  final IconData icon;
  final bool isViewed;
  final String actionLabel;
  final String type;

  NotificationModel({
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.icon,
    this.isViewed = false,
    this.actionLabel = "View",
    required this.type,
  });
}
