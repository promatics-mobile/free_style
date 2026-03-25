part of 'global_lead_board_cubit.dart';

@immutable
sealed class GlobalLeadBoardState {}

final class GlobalLeadBoardInitial extends GlobalLeadBoardState {}


class LeagueModel {
  String id = "";
  String name = "";
  bool isSelected = false;

  LeagueModel({required this.id, required this.name, required this.isSelected});

  factory LeagueModel.fromJson(Map<String, dynamic> json) {

    return LeagueModel(
      id: json['_id']??"",
      name: json['name']??"",
      isSelected: false
    );

  }

}

class GlobalLeaderboardModel {
  final String? id;
  final int? rank;
  final String? username;
  final int? rp;
  final AvatarModel? avatar;
  final String? league;

  GlobalLeaderboardModel({
    this.id,
    this.rank,
    this.username,
    this.rp,
    this.avatar,
    this.league,
  });

  factory GlobalLeaderboardModel.fromJson(Map<String, dynamic> json) {
    return GlobalLeaderboardModel(
      id: json['_id']??"",
      rank: json['rank'],
      username: json['username'],
      rp: json['rp'],
      avatar: json['avatar'] != null
          ? AvatarModel.fromJson(json['avatar'])
          : null,
      league: json['league'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'username': username,
      'rp': rp,
      'avatar': avatar?.toJson(),
      'league': league,
    };
  }
}

class AvatarModel {
  final String? id;
  final List<PictureModel>? picture;

  AvatarModel({this.id, this.picture});

  factory AvatarModel.fromJson(Map<String, dynamic> json) {
    return AvatarModel(
      id: json['_id'],
      picture: json['picture'] != null
          ? (json['picture'] as List)
          .map((e) => PictureModel.fromJson(e))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'picture': picture?.map((e) => e.toJson()).toList(),
    };
  }
}

class PictureModel {
  final String? id;
  final String? originalName;
  final int? size;
  final String? mimeType;
  final String? path;
  final String? filename;

  PictureModel({
    this.id,
    this.originalName,
    this.size,
    this.mimeType,
    this.path,
    this.filename,
  });

  factory PictureModel.fromJson(Map<String, dynamic> json) {
    return PictureModel(
      id: json['_id'],
      originalName: json['original_name'],
      size: json['size'],
      mimeType: json['mime_type'],
      path: json['path'],
      filename: json['filename'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'original_name': originalName,
      'size': size,
      'mime_type': mimeType,
      'path': path,
      'filename': filename,
    };
  }

  /// ✅ Helper for full image URL (optional)
  String get fullPath => "$mediaBaseUrl/$path/$filename";
}