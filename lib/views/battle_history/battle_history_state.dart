part of 'battle_history_cubit.dart';

@immutable
sealed class BattleHistoryState {}

final class BattleHistoryInitial extends BattleHistoryState {}

class BattleHistoryModel {
  final String id;
  final String status;
  final DateTime? finishedAt;
  final List<TransactionSummary> transactionSummary;

  final String battleId;
  final String battleName;
  final String battleDescription;

  final User? user1;
  final User? user2;
  final User? initiatedBy;
  final User? winner;

  BattleHistoryModel({
    required this.id,
    required this.status,
    this.finishedAt,
    required this.transactionSummary,
    required this.battleId,
    required this.battleName,
    required this.battleDescription,
    required this.user1,
    required this.user2,
    required this.winner,
    required this.initiatedBy,
  });

  factory BattleHistoryModel.fromJson(Map<String, dynamic> json) {
    return BattleHistoryModel(
      id: json["_id"] ?? "",
      status: json["status"] ?? "",
      finishedAt: json["finished_at"] != null
          ? DateTime.tryParse(json["finished_at"])
          : null,
      transactionSummary: (json["transaction_summary"] as List? ?? [])
          .map((e) => TransactionSummary.fromJson(e))
          .toList(),
      battleId: json["battle_id"] ?? "",
      battleName: json["battle_name"] ?? "",
      battleDescription: json["battle_description"] ?? "",
      user1: json["user1"] !=null ? User.fromJson(json["user1"]) :null,
      user2: json["user2"] !=null ? User.fromJson(json["user2"] ) : null,
      initiatedBy: json["initiated_by"] !=null ? User.fromJson(json["initiated_by"]) :null,
      winner: json["winner"] !=null ? User.fromJson(json["winner"]) :null,
    );
  }
}

class TransactionSummary {
  final String type; // rp, coins, xp
  final int amountChange;

  TransactionSummary({
    required this.type,
    required this.amountChange,
  });

  factory TransactionSummary.fromJson(Map<String, dynamic> json) {
    return TransactionSummary(
      type: json["_id"] ?? "",
      amountChange: json["amount_change"] ?? 0,
    );
  }
}

extension BattleHistoryUI on BattleHistoryModel {
  bool get isCompleted => status == "completed";
  bool get isActive => status == "active";

  /// Get reward by type
  int getReward(String type) {
    try {
      return transactionSummary
          .firstWhere((e) => e.type == type)
          .amountChange;
    } catch (_) {
      return 0;
    }
  }

  String get formattedDate {
    if (finishedAt == null) return "";
    return "${finishedAt!.day}/${finishedAt!.month}/${finishedAt!.year}";
  }
}
