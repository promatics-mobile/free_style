part of 'notification_cubit.dart';

class NotificationsState {
  int? selectedTabIndex;

  NotificationsState({this.selectedTabIndex});

  NotificationsState copyWith({int? selectedTabIndex}) {
    return NotificationsState(
        selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex);
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String note;
  final String purpose;
  final String referenceId;
  final String referenceModel;
  final String senderType;
  final String senderId;
  final String receiverType;
  final String receiverId;
  final bool isRead;
  final bool isActionTaken;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.note,
    required this.purpose,
    required this.referenceId,
    required this.referenceModel,
    required this.senderType,
    required this.senderId,
    required this.receiverType,
    required this.receiverId,
    required this.isRead,
    required this.isActionTaken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      note: json["note"] ?? "",
      purpose: json["purpose"] ?? "",
      referenceId: json["reference_id"] ?? "",
      referenceModel: json["reference_model"] ?? "",
      senderType: json["sender_type"] ?? "",
      senderId: json["sender_id"] ?? "",
      receiverType: json["receiver_type"] ?? "",
      receiverId: json["receiver_id"] ?? "",
      isRead: json["is_read"] ?? false,
      isActionTaken: json["is_action_taken"] ?? false,
      createdAt: DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? "") ?? DateTime.now(),
    );
  }
}


extension NotificationUI on NotificationModel {

  String get tAgo => timeAgo(createdAt);

  IconData get icon {
    switch (purpose) {
      case "battle_result":
        return Icons.emoji_events;
      case "battle_invite":
        return Icons.sports_kabaddi;
      case "update":
        return Icons.notifications;
      default:
        return Icons.notifications_none;
    }
  }

  String get actionLabel {
    switch (purpose) {
      case "battle_invite":
        return isActionTaken ? "Accepted" : "Respond";
      case "battle_result":
        return "View Result";
      default:
        return "View";
    }
  }

  bool get isViewed => isRead;
}
