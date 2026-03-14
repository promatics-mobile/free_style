class ShopModel {
  bool? success;
  String? message;
  List<ShopItem>? shop;

  ShopModel({this.success, this.message, this.shop});

  ShopModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['shop'] != null) {
      shop = <ShopItem>[];
      json['shop'].forEach((v) {
        shop!.add(ShopItem.fromJson(v));
      });
    }
  }
}

class InventoryModel {
  bool? success;
  String? message;
  List<ShopItem>? shop;

  InventoryModel({this.success, this.message, this.shop});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['inventory'] != null) {
      shop = <ShopItem>[];
      json['inventory'].forEach((v) {

        if(v.containsKey('product')){
          shop!.add(ShopItem.fromJson(v['product']));
        }else{
          shop!.add(ShopItem.fromJson(v));
        }

      });
    }
  }
}

class ShopItem {
  bool? owned;
  String? sId;
  String? name;
  String? type;
  String? description;
  String? rarity;
  String? collection;
  Price? price;
  bool? isFree = false;
  List<Pictures>? pictures;

  ShopItem(
      {this.owned,
      this.sId,
      this.name,
      this.type,
      this.description,
      this.rarity,
      this.collection,
      this.price,
      this.isFree,
      this.pictures});

  ShopItem.fromJson(Map<String, dynamic> json) {
    owned = json['owned'];
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    rarity = json['rarity'];
    collection = json['collection'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    isFree = json['is_free']??false;
    if (json['pictures'] != null) {
      pictures = <Pictures>[];
      json['pictures'].forEach((v) {
        pictures!.add(Pictures.fromJson(v));
      });
    }
  }
}

class Price {
  String? currency;
  int? value;
  String? sId;

  Price({this.currency, this.value, this.sId});

  Price.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    value = json['value'];
    sId = json['_id'];
  }
}

class Pictures {
  String? originalName;
  int? size;
  String? mimeType;
  String? path;
  String? filename;
  String? fullpath;

  Pictures(
      {this.originalName,
      this.size,
      this.mimeType,
      this.path,
      this.filename,
      this.fullpath});

  Pictures.fromJson(Map<String, dynamic> json) {
    originalName = json['original_name'];
    size = json['size'];
    mimeType = json['mime_type'];
    path = json['path'];
    filename = json['filename'];
    fullpath = json['fullpath'];
  }
}
