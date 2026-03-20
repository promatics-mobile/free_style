part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class MenuItemModel {
  final String title;
  final String icon;

  const MenuItemModel({
    required this.title,
    required this.icon,
  });
}

class ItemModel {
   String title;
   String? icon;
   bool isSelected;

   ItemModel({
     required this.title,
     required this.isSelected,
     this.icon,
  });
}

class CurrentChallengeModel {
  final String id;
  final TierModel tier;
  final ChallengeHistoryModel? submission;
  final List<SkillModel> skills;
  final Rewards rewards;
  final DateTime date;
  final DateTime startAt;
  final DateTime endAt;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  CurrentChallengeModel({
    required this.id,
    required this.tier,
    required this.submission,
    required this.skills,
    required this.rewards,
    required this.date,
    required this.startAt,
    required this.endAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CurrentChallengeModel.fromJson(Map<String, dynamic> json) {
    return CurrentChallengeModel(
      id: json['_id'] ?? '',
      tier: _parseTier(json['tier_id']),
      submission: json['submission'] !=null ? ChallengeHistoryModel.fromJson(json['submission']) : null,
      skills: (json['skills'] as List? ?? []).map((e) {
        if (e is String) {
          return SkillModel(id: e);
        } else if (e is Map<String, dynamic>) {
          return SkillModel.fromJson(e);
        } else {
          return SkillModel(id: '');
        }
      }).toList(),
      rewards: Rewards.fromJson(json['rewards'] ?? {}),
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      startAt: DateTime.tryParse(json['start_at'] ?? '') ?? DateTime.now(),
      endAt: DateTime.tryParse(json['end_at'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "rewards": rewards.toJson(),
      "date": date.toIso8601String(),
      "start_at": startAt.toIso8601String(),
      "end_at": endAt.toIso8601String(),
      "status": status,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  /// 🔥 Helper: check active
  bool get isActive => status == "active";

  /// 🔥 Helper: remaining time
  Duration get remainingTime => endAt.difference(DateTime.now());
}

class Rewards {
  final int xp;
  final int coin;

  Rewards({
    required this.xp,
    required this.coin,
  });

  factory Rewards.fromJson(Map<String, dynamic> json) {
    return Rewards(
      xp: json['xp'] ?? 0,
      coin: json['coin'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "xp": xp,
      "coin": coin,
    };
  }
}

class TierModel {
  final String id;
  final String? name;
  final int? minLevel;
  final Rewards? completionRewards;
  final bool? isActive;

  TierModel({
    required this.id,
    this.name,
    this.minLevel,
    this.completionRewards,
    this.isActive,
  });

  factory TierModel.fromJson(Map<String, dynamic> json) {
    return TierModel(
      id: json['_id'] ?? '',
      name: json['name'],
      minLevel: json['min_level'],
      completionRewards: json['tier_completion_rewards'] != null
          ? Rewards.fromJson(json['tier_completion_rewards'])
          : null,
      isActive: json['is_active'],
    );
  }
}

TierModel _parseTier(dynamic data) {
  if (data is String) {
    /// Case 1: Only ID
    return TierModel(id: data);
  } else if (data is Map<String, dynamic>) {
    /// Case 2: Full Object
    return TierModel.fromJson(data);
  } else {
    /// Fallback
    return TierModel(id: '');
  }
}