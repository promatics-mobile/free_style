part of 'search_players_cubit.dart';

class SearchPlayersState {
  List<PlayerModel> userList;
  String text;

  SearchPlayersState({required this.userList , this.text = ""});

  SearchPlayersState copyWith({List<PlayerModel>? userList, String? text}) {
    return SearchPlayersState(userList: userList ?? this.userList, text: text ?? this.text);
  }
}

class PlayerModel {
  String? sId;
  String? relationId;
  String? name;
  String? userName;
  int? xp;
  int? level;
  String? createdAt;
  CosmeticItem? avatar;
  CosmeticItem? ball;
  RelationStatus? relationStatus;
  int?challenges;
  int? battles;
  int? tricks;
  int? playerRanking;
  TierModel? tierModel;
  LeagueModel? leagueModel;



  PlayerModel({
    this.sId,
    this.name,
    this.userName,
    this.xp,
    this.level,
    this.createdAt,
    this.avatar,
    this.ball,
    this.relationStatus,
    this.challenges,
    this.battles,
    this.tricks,
    this.playerRanking,
    this.tierModel,
    this.leagueModel,
  });

  PlayerModel.fromJson(Map<String, dynamic> json, {String? rId}) {
    sId = json['_id'];
    relationId = rId??"";
    name = json['name'];
    userName = json['user_name'];
    xp = json['xp'];
    level = json['level'];
    createdAt = json['created_at'];

    avatar = json['avatar'] != null ? CosmeticItem.fromJson(json['avatar']) : null;
    ball = json['ball'] != null ? CosmeticItem.fromJson(json['ball']) : null;

    leagueModel = json['league_id'] != null
        ? LeagueModel.fromJson(json['league_id'])
        : null;

    tierModel = json['tier'] != null ? TierModel.fromJson(json['tier']) : null;

    relationStatus = json['relation_status'] != null
        ? RelationStatus.fromJson(json['relation_status'])
        : null;


    battles = json['battles'];
    tricks = json['tricks'];
    playerRanking = json['player_ranking'];
    challenges=json['challenges'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['_id'] = sId;
    data['name'] = name;
    data['user_name'] = userName;
    data['xp'] = xp;
    data['level'] = level;
    data['relation_status'] = relationStatus;
    data['created_at'] = createdAt;

    // if (avatar != null) {
    //   data['avatar'] = avatar!.toJson();
    // }
    //
    // if (ball != null) {
    //   data['ball'] = ball!.toJson();
    // }

    return data;
  }
}


