part of 'skill_tree_cubit.dart';

class SkillTreeState {
  List<BranchModel> branchList;
  List<TierModel> tierList;
  List<SkillModel> skillList;
  String text;
  final int selectedTierIndex;
  final int selectedSkillIndex;

  SkillTreeState({
    required this.branchList,
    required this.tierList,
    this.skillList = const [],
    this.text = "",
    this.selectedTierIndex = 0,
    this.selectedSkillIndex = 0,
  });

  SkillTreeState copyWith({
    List<BranchModel>? branchList,
    List<TierModel>? tierList,
    List<SkillModel>? skillList,
    String? text,
    int? selectedTierIndex,
    int? selectedSkillIndex,
  }) {
    return SkillTreeState(
      branchList: branchList ?? this.branchList,
      tierList: tierList ?? this.tierList,
      skillList: skillList ?? this.skillList,
      text: text ?? this.text,
      selectedTierIndex: selectedTierIndex ?? this.selectedTierIndex,
      selectedSkillIndex: selectedSkillIndex ?? this.selectedSkillIndex,
    );
  }
}

class StepperData {
  final String? icon;
  final String? title;
  final String? subtitle;

  const StepperData({this.icon, this.title, this.subtitle});
}

class BranchModel {
  String? id;
  String? name;

  BranchModel({
    this.id,
    this.name,
  });

  BranchModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    return data;
  }
}

class TierModel {
  String? id;
  String? name;
  int? minLevel;
  TierCompletionRewards? tierCompletionRewards;
  bool? isActive;
  int? v;

  TierModel({
    this.id,
    this.name,
    this.minLevel,
    this.tierCompletionRewards,
    this.isActive,
    this.v,
  });

  TierModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    minLevel = json['min_level'];

    tierCompletionRewards = json['tier_completion_rewards'] != null
        ? TierCompletionRewards.fromJson(json['tier_completion_rewards'])
        : null;

    isActive = json['is_active'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['_id'] = id;
    data['name'] = name;
    data['min_level'] = minLevel;

    if (tierCompletionRewards != null) {
      data['tier_completion_rewards'] = tierCompletionRewards!.toJson();
    }

    data['is_active'] = isActive;
    data['__v'] = v;

    return data;
  }
}

class TierCompletionRewards {
  int? coin;
  int? xp;

  TierCompletionRewards({
    this.coin,
    this.xp,
  });

  TierCompletionRewards.fromJson(Map<String, dynamic> json) {
    coin = json['coin'];
    xp = json['xp'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['coin'] = coin;
    data['xp'] = xp;

    return data;
  }
}

class SkillModel {
  String? id;
  String? branchId;
  String? tierId;
  Prerequisite? prerequisite;
  int? minLvlReq;
  String? name;
  String? difficultyLevel;
  List<String>? tags;
  CompletionRewards? completionRewards;
  bool? isVidSubReq;
  bool? isActive;
  List<dynamic>? tutorials;
  String? createdAt;
  String? updatedAt;
  int? v;
  bool? isUnLocked = false;

  SkillModel({
    this.id,
    this.branchId,
    this.tierId,
    this.prerequisite,
    this.minLvlReq,
    this.name,
    this.difficultyLevel,
    this.tags,
    this.completionRewards,
    this.isVidSubReq,
    this.isActive,
    this.tutorials,
    this.createdAt,
    this.updatedAt,
    this.isUnLocked,
    this.v,
  });

  SkillModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    branchId = json['branch_id'];
    tierId = json['tier_id'];
    prerequisite = json['prerequisite'] != null
        ? Prerequisite.fromJson(json['prerequisite'])
        : null;
    minLvlReq = json['min_lvl_req'];
    name = json['name'];
    difficultyLevel = json['difficulty_level'];
    tags = json['tags']?.cast<String>();
    completionRewards = json['completion_rewards'] != null
        ? CompletionRewards.fromJson(json['completion_rewards'])
        : null;
    isVidSubReq = json['is_vid_sub_req'];
    isActive = json['is_active'];
    if (json['tutorials'] != null) {
      tutorials = <dynamic>[];
      json['tutorials'].forEach((v) {
        tutorials!.add(v);
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isUnLocked = json['unlocked']??false;
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['branch_id'] = branchId??"";
    data['tier_id'] = tierId??"";
    if (prerequisite != null) {
      data['prerequisite'] = prerequisite!.toJson();
    }
    data['min_lvl_req'] = minLvlReq;
    data['name'] = name;
    data['difficulty_level'] = difficultyLevel;
    data['tags'] = tags;
    if (completionRewards != null) {
      data['completion_rewards'] = completionRewards!.toJson();
    }
    data['is_vid_sub_req'] = isVidSubReq;
    data['is_active'] = isActive;
    if (tutorials != null) {
      data['tutorials'] = tutorials;
    }
    data['created_at'] = createdAt??"";
    data['unlocked'] = isUnLocked;
    data['updated_at'] = updatedAt??"";
    data['__v'] = v;
    return data;
  }
}

class Prerequisite {
  List<String>? skillsToComplete;

  Prerequisite({this.skillsToComplete});

  Prerequisite.fromJson(Map<String, dynamic> json) {
    skillsToComplete = json['skills_to_complete']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['skills_to_complete'] = skillsToComplete;
    return data;
  }
}

class CompletionRewards {
  int? xp;
  int? coin;

  CompletionRewards({this.xp, this.coin});

  CompletionRewards.fromJson(Map<String, dynamic> json) {
    xp = json['xp'];
    coin = json['coin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['xp'] = xp;
    data['coin'] = coin;
    return data;
  }
}
