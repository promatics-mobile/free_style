part of 'match_making_cubit.dart';

@immutable
sealed class MatchMakingState {}

final class MatchMakingInitial extends MatchMakingState {}

class OngoingBattleModel {
  final String? id;
  final Battle? battle;
  final User? user1;
  final User? user2;
  final User? initiatedBy;
  final User? winner;

  final InternalMediaModel? user1Video;
  final InternalMediaModel? user2Video;

  final String? status;
  final String? reason;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OngoingBattleModel({
    this.id,
    this.battle,
    this.user1,
    this.user2,
    this.initiatedBy,
    this.winner,
    this.user1Video,
    this.user2Video,
    this.status,
    this.reason,
    this.createdAt,
    this.updatedAt,
  });

  factory OngoingBattleModel.fromJson(Map<String, dynamic> json) {
    return OngoingBattleModel(
      id: json["_id"],
      battle: json["battle_id"] != null
          ? Battle.fromJson(json["battle_id"])
          : null,

      user1: json["user1"] != null
          ? User.fromJson(json["user1"])
          : null,

      user2: json["user2"] != null
          ? User.fromJson(json["user2"])
          : null,

      initiatedBy: json["initiated_by"] != null
          ? User.fromJson(json["initiated_by"])
          : null,

      /// ✅ Winner same as user model
      winner: json["winner"] != null
          ? User.fromJson(json["winner"])
          : null,

      /// ✅ Dynamic video keys
      user1Video: json["user1video"] != null
          ? InternalMediaModel.fromJson(json["user1video"])
          : null,

      user2Video: json["user2video"] != null
          ? InternalMediaModel.fromJson(json["user2video"])
          : null,

      status: json["status"],
      reason: json["reason"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null,
    );
  }
}

class Battle {
  final String name;
  final String description;
  final String tierName;
  final int xp;
  final int coins;

  Battle({
    required this.name,
    required this.description,
    required this.tierName,
    required this.xp,
    required this.coins,
  });

  factory Battle.fromJson(Map<String, dynamic> json) {
    return Battle(
      name: json["battle_name"] ?? "",
      description: json["description"] ?? "",
      tierName: json["tier_id"]?["name"] ?? "",
      xp: json["reward"]?["xp"] ?? 0,
      coins: json["reward"]?["coins"] ?? 0,
    );
  }
}

class User {
  final String id;
  final String name;
  final Equipped? equipped;
  final String? avatar;
  final int level;
  final int xp;

  User({
    required this.id,
    required this.name,
    this.equipped,
    this.avatar,
    required this.level,
    required this.xp,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    String fullImagePath = "";

    if(json["avatar"] != null){
      var iList = json["avatar"]['picture'] as List;
      if(iList.isNotEmpty){
        var iData = iList.first;
        fullImagePath = "$mediaBaseUrl/${iData['path']}/${iData['filename']}";
      }
    }

    return User(
      id: json["_id"],
      name: json["name"] ?? "",
        level: json["level"] ?? 0,
        xp: json["xp"] ?? 0,
      equipped: json["equipped"] != null
          ? Equipped.fromJson(json["equipped"])
          : null,
    avatar: fullImagePath);
  }
}

class Equipped {
  final MediaGroup? avatar;
  final MediaGroup? ball;

  Equipped({this.avatar, this.ball});

  factory Equipped.fromJson(Map<String, dynamic> json) {
    return Equipped(
      avatar: json["avatar"] != null
          ? MediaGroup.fromJson(json["avatar"])
          : null,
      ball: json["ball"] != null
          ? MediaGroup.fromJson(json["ball"])
          : null,
    );
  }
}

class MediaGroup {
  final List<InternalMediaModel> pictures;

  MediaGroup({this.pictures = const []});

  factory MediaGroup.fromJson(Map<String, dynamic> json) {
    return MediaGroup(
      pictures: (json["picture"] as List? ?? [])
          .map((e) => InternalMediaModel.fromJson(e))
          .toList(),
    );
  }
}