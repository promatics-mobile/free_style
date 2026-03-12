class UserModel {
  Wallet? wallet;
  String? id;
  String? name;
  String? email;
  bool? isEmailVerified;
  bool? isMobileVerified;
  int? xp;
  int? level;
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
    this.xp,
    this.level,
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
    isEmailVerified = json['is_email_verified'];
    isMobileVerified = json['is_mobile_verified'];
    xp = json['xp'];
    level = json['level'];
    equipped =
    json['equipped'] != null ? Equipped.fromJson(json['equipped']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (wallet != null) {
      data['wallet'] = wallet!.toJson();
    }
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['is_email_verified'] = isEmailVerified;
    data['is_mobile_verified'] = isMobileVerified;
    data['xp'] = xp;
    data['level'] = level;
    if (equipped != null) {
      data['equipped'] = equipped!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = v;
    return data;
  }
}

class Wallet {
  int? coins;

  Wallet({this.coins});

  Wallet.fromJson(Map<String, dynamic> json) {
    coins = json['coins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['coins'] = coins;
    return data;
  }
}

class Equipped {
  dynamic avatar;
  dynamic ball;

  Equipped({this.avatar, this.ball});

  Equipped.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    ball = json['ball'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['avatar'] = avatar;
    data['ball'] = ball;
    return data;
  }
}