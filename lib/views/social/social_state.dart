part of 'social_cubit.dart';

class SocialState {
  List<PlayerModel> myFriends;
  List<PendingRequestModel> pendingRequests;
  List<BattleRequestModel> battleRequests;

  String text;

  SocialState({
    required this.myFriends,
    required this.pendingRequests,
    required this.battleRequests,
    this.text = "",
  });

  SocialState copyWith({
    List<PlayerModel>? myFriends,
    List<PendingRequestModel>? pendingRequests,
    List<BattleRequestModel>? battleRequests,
    String? text,
  }) {
    return SocialState(
      myFriends: myFriends ?? this.myFriends,
      pendingRequests: pendingRequests ?? this.pendingRequests,
      battleRequests: battleRequests ?? this.battleRequests,
      text: text ?? this.text,
    );
  }
}

class PendingRequestModel {
  String? id;
  PlayerModel? requester;
  String? status;
  String? actionBy;
  String? createdAt;
  String? updatedAt;

  PendingRequestModel({
    this.id,
    this.requester,
    this.status,
    this.actionBy,
    this.createdAt,
    this.updatedAt,
  });

  PendingRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    requester = json['requester'] != null ? PlayerModel.fromJson(json['requester']) : null;
    status = json['status'];
    actionBy = json['action_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['_id'] = id;
    data['status'] = status;
    data['action_by'] = actionBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    if (requester != null) {
      data['requester'] = requester!.toJson();
    }

    return data;
  }
}

class BattleRequestModel {
  String? id;
  String? name;
  String? userName;
  String? userImage;
  String? battleId;
  String? referenceId;

  BattleRequestModel({this.id, this.name, this.userName, this.userImage, this.battleId,this.referenceId});

  BattleRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['sender']['_id'];
    name = json['sender']['name'] ?? "";
    userName = json['sender']['user_name'] ?? "";

    if (json['sender']['avatar'] != null && json['sender']['avatar']['picture'] !=null) {
      var list = json['sender']['avatar']['picture'] as List;

      if (list.isNotEmpty) {
        var picture = PictureItem.fromJson(list.first);
        userImage = getFullFileUrl(
          baseUrl: mediaBaseUrl,
          path: picture.path ?? "",
          filename: picture.filename ?? "",
        );
      }
    }

    battleId = json['_id'] ?? "";
    referenceId = json['reference_id'] ?? "";
  }
}
