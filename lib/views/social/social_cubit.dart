import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  List<SocialModel> incomingChallenges = [
    SocialModel(name: "@Kim_skater", level: "Blue Tier 1", message: "Wants to battle!"),
  ];

  List<SocialModel> pendingRequests = [
    SocialModel(name: "@NeonNinja", level: "SILVER 1", message: ""),
    SocialModel(name: "@Cryptoking", level: "GOLD 2", message: ""),
  ];

  List<SocialModel> myFriends = [
    SocialModel(name: "@QueenBee", level: "GOLD 1", message: ""),
    SocialModel(name: "@ViperStrike", level: "BRONZE 3", message: ""),
    SocialModel(name: "@ShadowStriker", level: "PLATINUM 1", message: ""),
    SocialModel(name: "@TrickMaster", level: "GOLD 1", message: ""),
    SocialModel(name: "@SkatyCat", level: "SILVER 2", message: ""),
  ];

  void acceptChallenge(int index) {
    incomingChallenges.removeAt(index);
    emit(SocialInitial());
  }

  void cancelChallenge(int index) {
    incomingChallenges.removeAt(index);
    emit(SocialInitial());
  }

  void acceptRequest(int index) {
    var user = pendingRequests.removeAt(index);
    myFriends.add(user);
    emit(SocialInitial());
  }

  void rejectRequest(int index) {
    pendingRequests.removeAt(index);
    emit(SocialInitial());
  }

  void removeFriend(int index) {
    myFriends.removeAt(index);
    emit(SocialInitial());
  }
}

class SocialModel {
  final String name;
  final String level;
  final String message;

  SocialModel({required this.name, required this.level, required this.message});
}
