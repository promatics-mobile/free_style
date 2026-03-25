import 'package:free_style/views/global_lead_board/global_lead_board_cubit.dart';
import 'package:free_style/views/home/home_cubit.dart';

import '../profile_setup/cosmetics_model.dart';

class UserModel {
  Wallet? wallet;
  String? id;
  String? name;
  String? email;
  bool? isEmailVerified=false;
  bool? isMobileVerified =false;
  Mobile? mobile;
  LeagueModel? leagueModel;
  TierModel? tierModel;
  int? xp;
  int? rp;
  int? level;
  int? xpRequired;
  int? tricks;
  int? challenges;
  int? battles;
  String? userName;
  Equipped? equipped;
  String? createdAt;
  String? updatedAt;
  int? v;

  UserModel({
    this.wallet,
    this.id,
    this.name,
    this.email,
    this.isEmailVerified,
    this.isMobileVerified,
    this.mobile,
    this.leagueModel,
    this.tierModel,
    this.xp,
    this.rp,
    this.level,
    this.xpRequired,
    this.tricks,
    this.challenges,
    this.battles,
    this.userName,
    this.equipped,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    isEmailVerified = json['is_email_verified']??false;
    isMobileVerified = json['is_mobile_verified']??false;
    mobile = json['mobile'] != null ? Mobile.fromJson(json['mobile']) : null;
    leagueModel = json['league_id'] != null ? LeagueModel.fromJson(json['league_id']) : null;
    tierModel = json['tier'] != null ? TierModel.fromJson(json['tier']) : null;
    xp = json['xp']??0;
    rp = json['rp']??0;
    level = json['level'];
    xpRequired = json['xp_required'];
    tricks = json['tricks']??0;
    challenges = json['challenges']??0;
    battles = json['battles']??0;
    userName = json['user_name'];
    equipped =
    json['equipped'] != null ? Equipped.fromJson(json['equipped']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    v = json['__v'];
  }

}

class Wallet {
  int? coins;

  Wallet({this.coins});

  Wallet.fromJson(Map<String, dynamic> json) {
    coins = json['coins'];
  }

  Map<String, dynamic> toJson() {
    return {'coins': coins};
  }
}

class Mobile {
  String? countryCode;
  String? number;

  Mobile({this.countryCode, this.number});

  Mobile.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    return {
      'country_code': countryCode,
      'number': number,
    };
  }
}

class Equipped {
  CosmeticItem? avatar;
  CosmeticItem? ball;

  Equipped({this.avatar, this.ball});

  Equipped.fromJson(Map<String, dynamic> json) {
    avatar =
    json['avatar'] != null ? CosmeticItem.fromJson(json['avatar']) : null;
    ball = json['ball'] != null ? CosmeticItem.fromJson(json['ball']) : null;
  }

}

