class TapeModel {
  TapeModel({
    int? id,
    String? name,
    String? catName,
    int? price,
    String? description,
    int? compound,
    String? video,
    String? image,
    bool? inBasket,
    int? chatId,
    bool? inReport,
    bool? inFavorite,
    bool? inSubscribe,
    Shop? shop,
    Blogger? blogger,
  }) {
    _id = id;
    _name = name;
    _catName = catName;
    _price = price;
    _description = description;
    _compound = compound;
    _video = video;
    _image = image;
    _inBasket = inBasket;
    _chatId = chatId;
    _inReport = inReport;
    _inFavorite = inFavorite;
    _inSubscribe = inSubscribe;
    _shop = shop;
    _blogger = blogger;
  }

  TapeModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _catName = json['cat_name'];
    _price = json['price'];
    _description = json['description'];
    _compound = json['compound'];
    _video = json['video'];
    _image = json['image'];
    _inBasket = json['in_basket'];
    _chatId = json['chat_id'];
    _inReport = json['in_report'];
    _inFavorite = json['in_favorite'];
    _inSubscribe = json['in_subscribe'];
    _shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    _blogger =
        json['blogger'] != null ? Blogger.fromJson(json['blogger']) : null;
  }
  int? _id;
  String? _name;
  String? _catName;
  int? _price;
  String? _description;
  int? _compound;
  String? _video;
  String? _image;
  bool? _inBasket;
  int? _chatId;
  bool? _inReport;
  bool? _inFavorite;
  bool? _inSubscribe;
  Shop? _shop;
  Blogger? _blogger;

  int? get id => _id;
  String? get name => _name;
  String? get catName => _catName;
  int? get price => _price;
  String? get description => _description;
  int? get compound => _compound;
  String? get video => _video;
  String? get image => _image;
  bool? get inBasket => _inBasket;
  int? get chatId => _chatId;
  bool? get inReport => _inReport;
  bool? get inFavorite => _inFavorite;
  bool? get inSubscribe => _inSubscribe;
  Shop? get shop => _shop;
  Blogger? get blogger => _blogger;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['cat_name'] = _catName;
    map['price'] = _price;
    map['description'] = _description;
    map['compound'] = _compound;
    map['video'] = _video;
    map['image'] = _image;
    map['in_basket'] = _inBasket;
    map['chat_id'] = _chatId;
    map['in_report'] = _inReport;
    map['in_favorite'] = _inFavorite;
    map['inSubscribe'] = _inSubscribe;
    if (_shop != null) {
      map['shop'] = _shop?.toJson();
    }
    if (_blogger != null) {
      map['blogger'] = _blogger?.toJson();
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

class Blogger {
  Blogger({
    int? id,
    String? name,
    String? nickName,
    String? image,
  }) {
    _id = id;
    _name = name;
    _nickName = nickName;
    _image = image;
  }

  Blogger.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _nickName = json['nick_name'];
    _image = json['avatar'];
  }
  int? _id;
  String? _name;
  String? _nickName;
  String? _image;

  int? get id => _id;
  String? get name => _name;
  String? get nickName => _nickName;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['nick_name'] = _nickName;
    map['avatar'] = _image;
    return map;
  }
}
