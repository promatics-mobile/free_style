part of 'other_profile_cubit.dart';

class OtherProfileState {
  UserProfileModel? user;

  String text;

  OtherProfileState({required this.user, this.text = ""});

  OtherProfileState copyWith({UserProfileModel? user, String? text}) {
    return OtherProfileState(user: user ?? this.user, text: text ?? this.text);
  }
}
class RelationStatus {
  String? relationId;
  String? status;
  bool? isFriend;
  bool? isRequestSent;
  bool? isRequestReceived;

  RelationStatus({
    this.relationId,
    this.status,
    this.isFriend,
    this.isRequestSent,
    this.isRequestReceived,
  });

  RelationStatus.fromJson(Map<String, dynamic> json) {
    relationId = json['relation_id'];
    status = json['status'];
    isFriend = json['is_friend'];
    isRequestSent = json['is_request_sent'];
    isRequestReceived = json['is_request_received'];
  }
}

class UserProfileModel {
  bool? success;
  String? message;
  PlayerModel? user;
  RelationStatus? relationStatus;

  UserProfileModel({
    this.success,
    this.message,
    this.user,
    this.relationStatus,
  });

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    user = json['user'] != null ? PlayerModel.fromJson(json['user']) : null;

    relationStatus = json['relation_status'] != null
        ? RelationStatus.fromJson(json['relation_status'])
        : null;
  }
}