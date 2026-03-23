part of 'battles_cubit.dart';

@immutable
sealed class BattlesState {}

final class BattlesInitial extends BattlesState {}
class BattleModel {
  final String id;
  final String battleName;
  final RewardModel reward;
  final TierModel tier;
  final List<SkillModel> skills;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String description;

  BattleModel({
    required this.id,
    required this.battleName,
    required this.reward,
    required this.tier,
    required this.skills,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
  });

  factory BattleModel.fromJson(Map<String, dynamic> json) {
    return BattleModel(
      id: json['_id'] ?? '',
      battleName: json['battle_name'] ?? '',
      reward: RewardModel.fromJson(json['reward'] ?? {}),
      tier: TierModel.fromJson(json['tier_id'] ?? {}),
      skills: (json['skills_to_perform'] as List<dynamic>? ?? [])
          .map((e) => SkillModel.fromJson(e))
          .toList(),
      startDate: DateTime.parse(json['start_date']??DateTime.now().toString()),
      endDate: DateTime.parse(json['end_date']??DateTime.now().toString()),
      isActive: json['is_active'] ?? false,
      createdAt: DateTime.parse(json['created_at']??DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updated_at']??DateTime.now().toString()),
      description: json['description'] ?? '',
    );
  }

  Duration get remainingTime => endDate.difference(DateTime.now());
}

class RewardModel {
  final int xp;
  final int coins;

  RewardModel({
    required this.xp,
    required this.coins,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      xp: json['xp'] ?? 0,
      coins: json['coins'] ?? 0,
    );
  }
}