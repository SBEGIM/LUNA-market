class TapeBloggerModel {
  TapeBloggerModel(
      {int? id,
      int? tapeId,
      String? name,
      String? catName,
      int? price,
      String? description,
      int? compound,
      String? video,
      String? image,
      bool? inBasket,
      bool? inReport,
      bool? inFavorite,
      bool? inSubscribe,
      bool? isDelete,
      int? viewCount,
      int? basketCount,
      int? shareCount,
      Shop? shop,
      Statistics? statistics}) {
    _id = id;
    _tapeId = tapeId;
    _name = name;
    _catName = catName;
    _price = price;
    _description = description;
    _compound = compound;
    _video = video;
    _image = image;
    _inBasket = inBasket;
    _inReport = inReport;
    _inFavorite = inFavorite;
    _inSubscribe = inSubscribe;
    _isDelete = isDelete;
    _viewCount = viewCount;
    _basketCount = basketCount;
    _shareCount = shareCount;
    _shop = shop;
    _statistics = statistics;
  }

  TapeBloggerModel.fromJson(dynamic json) {
    _id = json['id'];
    _tapeId = json['tape_id'];
    _name = json['name'];
    _catName = json['cat_name'];
    _price = json['price'];
    _description = json['description'];
    _compound = json['compound'];
    _video = json['video'];
    _image = json['image'];
    _inBasket = json['in_basket'];
    _inReport = json['in_report'];
    _inFavorite = json['in_favorite'];
    _inSubscribe = json['in_subscribe'];
    _isDelete = json['is_delete'];
    _viewCount = json['view_count'];
    _basketCount = json['basket_count'];
    _shareCount = json['share_count'];
    _shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    _statistics = json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null;
  }
  int? _id;
  int? _tapeId;
  String? _name;
  String? _catName;
  int? _price;
  String? _description;
  int? _compound;
  String? _video;
  String? _image;
  bool? _inBasket;
  bool? _inReport;
  bool? _inFavorite;
  bool? _inSubscribe;
  bool? _isDelete;
  int? _viewCount;
  int? _basketCount;
  int? _shareCount;
  Shop? _shop;
  Statistics? _statistics;

  int? get id => _id;
  int? get tapeId => _tapeId;
  String? get name => _name;
  String? get catName => _catName;
  int? get price => _price;
  String? get description => _description;
  int? get compound => _compound;
  String? get video => _video;
  String? get image => _image;
  bool? get inBasket => _inBasket;
  bool? get inReport => _inReport;
  bool? get inFavorite => _inFavorite;
  bool? get inSubscribe => _inSubscribe;
  bool? get isDelete => _isDelete;
  int? get viewCount => _viewCount;
  int? get basketCount => _basketCount;
  int? get shareCount => _shareCount;
  Shop? get shop => _shop;
  Statistics? get statistics => _statistics;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['tape_id'] = _tapeId;
    map['name'] = _name;
    map['cat_name'] = _catName;
    map['price'] = _price;
    map['description'] = _description;
    map['compound'] = _compound;
    map['video'] = _video;
    map['image'] = _image;
    map['in_basket'] = _inBasket;
    map['in_report'] = _inReport;
    map['in_favorite'] = _inFavorite;
    map['inSubscribe'] = _inSubscribe;
    map['isDelete'] = _isDelete;
    map['view_count'] = _viewCount;
    map['basket_count'] = _basketCount;
    map['share_count'] = _shareCount;
    if (_shop != null) {
      map['shop'] = _shop?.toJson();
    }

    if (_statistics != null) {
      map['statistics'] = _statistics?.toJson();
    }
    return map;
  }
}

class Shop {
  Shop({
    int? id,
    String? iin,
    int? mainCatId,
    String? name,
    String? userName,
    String? email,
    String? phone,
    String? password,
    String? logo,
    String? image,
    int? courier,
    dynamic token,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _iin = iin;
    _mainCatId = mainCatId;
    _name = name;
    _userName = userName;
    _email = email;
    _phone = phone;
    _password = password;
    _logo = logo;
    _image = image;
    _courier = courier;
    _token = token;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Shop.fromJson(dynamic json) {
    _id = json['id'];
    _iin = json['iin'];
    _mainCatId = json['main_cat_id'];
    _name = json['name'];
    _userName = json['user_name'];
    _email = json['email'];
    _phone = json['phone'];
    _password = json['password'];
    _logo = json['logo'];
    _image = json['image'];
    _courier = json['courier'];
    _token = json['token'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _iin;
  int? _mainCatId;
  String? _name;
  String? _userName;
  String? _email;
  String? _phone;
  String? _password;
  String? _logo;
  String? _image;
  int? _courier;
  dynamic _token;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get iin => _iin;
  int? get mainCatId => _mainCatId;
  String? get name => _name;
  String? get userName => _userName;
  String? get email => _email;
  String? get phone => _phone;
  String? get password => _password;
  String? get logo => _logo;
  String? get image => _image;
  int? get courier => _courier;
  dynamic get token => _token;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['iin'] = _iin;
    map['main_cat_id'] = _mainCatId;
    map['name'] = _name;
    map['user_name'] = _userName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['password'] = _password;
    map['logo'] = _logo;
    map['image'] = _image;
    map['courier'] = _courier;
    map['token'] = _token;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Statistics {
  Statistics({int? like, int? favorite, int? send}) {
    _like = like;
    _favorite = favorite;
    _send = send;
  }

  Statistics.fromJson(dynamic json) {
    _like = json['like'];
    _favorite = json['favorite'];
    _send = json['send'];
  }
  int? _like;
  int? _favorite;
  int? _send;

  int? get like => _like;
  int? get favorite => _favorite;
  int? get send => _send;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['like'] = _like;
    map['favorite'] = _favorite;
    map['send'] = _send;
    return map;
  }
}
