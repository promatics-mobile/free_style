class CosmeticItem {
  String? sId;
  String? name;
  String? type;
  String? description;
  String? rarity;
  List<PictureItem>? picture;
  bool? isFree;
  bool? isSelected = false;

  CosmeticItem({
    this.sId,
    this.name,
    this.type,
    this.description,
    this.rarity,
    this.picture,
    this.isFree,
    this.isSelected,
  });

  CosmeticItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    rarity = json['rarity'];
    if (json['pictures'] != null) {
      picture = <PictureItem>[];
      json['pictures'].forEach((v) {
        picture!.add(PictureItem.fromJson(v));
      });
    }
    isFree = json['is_free'];
    isSelected = false;
  }
}

class PictureItem {
  String? originalName;
  String? path;
  String? filename;
  String? fullPath;
  String? sId;

  PictureItem({this.originalName, this.path, this.fullPath, this.filename, this.sId});

  PictureItem.fromJson(Map<String, dynamic> json) {
    originalName = json['original_name'];
    path = json['path'];
    fullPath = json['fullpath'];
    filename = json['filename'];
    sId = json['_id'];
  }
}
