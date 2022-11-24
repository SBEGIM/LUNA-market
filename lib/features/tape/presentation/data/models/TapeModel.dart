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
      Review? review, 
      bool? inBasket, 
      bool? inFavorite, 
      Shop? shop,}){
    _id = id;
    _name = name;
    _catName = catName;
    _price = price;
    _description = description;
    _compound = compound;
    _video = video;
    _image = image;
    _review = review;
    _inBasket = inBasket;
    _inFavorite = inFavorite;
    _shop = shop;
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
    _review = json['review'] != null ? Review.fromJson(json['review']) : null;
    _inBasket = json['in_basket'];
    _inFavorite = json['in_favorite'];
    _shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
  }
  int? _id;
  String? _name;
  String? _catName;
  int? _price;
  String? _description;
  int? _compound;
  String? _video;
  String? _image;
  Review? _review;
  bool? _inBasket;
  bool? _inFavorite;
  Shop? _shop;

  int? get id => _id;
  String? get name => _name;
  String? get catName => _catName;
  int? get price => _price;
  String? get description => _description;
  int? get compound => _compound;
  String? get video => _video;
  String? get image => _image;
  Review? get review => _review;
  bool? get inBasket => _inBasket;
  bool? get inFavorite => _inFavorite;
  Shop? get shop => _shop;

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
    if (_review != null) {
      map['review'] = _review?.toJson();
    }
    map['in_basket'] = _inBasket;
    map['in_favorite'] = _inFavorite;
    if (_shop != null) {
      map['shop'] = _shop?.toJson();
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
      String? updatedAt,}){
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

class Review {
  Review({
      int? rating, 
      int? count, 
      int? , 
      int? , 
      int? , 
      int? , 
      int? ,}){
    _rating = rating;
    _count = count;
    _ = ;
    _ = ;
    _ = ;
    _ = ;
    _ = ;
}

  Review.fromJson(dynamic json) {
    _rating = json['rating'];
    _count = json['count'];
    _ = json['5'];
    _ = json['4'];
    _ = json['3'];
    _ = json['2'];
    _ = json['1'];
  }
  int? _rating;
  int? _count;
  int? _;
  int? _;
  int? _;
  int? _;
  int? _;

  int? get rating => _rating;
  int? get count => _count;
  int? get  => _;
  int? get  => _;
  int? get  => _;
  int? get  => _;
  int? get  => _;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rating'] = _rating;
    map['count'] = _count;
    map['5'] = _;
    map['4'] = _;
    map['3'] = _;
    map['2'] = _;
    map['1'] = _;
    return map;
  }

}