class ProductModel {
  ProductModel({
    int? id,
    String? name,
    int? price,
    int? compound,
    String? description,
    String? sizeTitle,
    List<String>? size,
    List<String>? color,
    List<String>? path,
    Shop? shop,
    int? rating,
    int? count,
    bool? inBasket,
    int? basketCount,
    bool? inFavorite,
    List<Shops>? shops,
  }) {
    _id = id;
    _name = name;
    _price = price;
    _compound = compound;
    _description = description;
    _sizeTitle = sizeTitle;
    _size = size;
    _color = color;
    _path = path;
    _shop = shop;
    _rating = rating;
    _count = count;
    _inBasket = inBasket;
    _basketCount = basketCount;
    _inFavorite = inFavorite;
    _shops = shops;
  }

  ProductModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _compound = json['compound'];
    _description = json['description'];
    _sizeTitle = json['size_title'];
    _size = json['size'] != null ? json['size'].cast<String>() : [];
    _color = json['color'] != null ? json['color'].cast<String>() : [];
    _path = json['path'] != null ? json['path'].cast<String>() : [];
    _shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    _rating = json['rating'];
    _count = json['count'];
    _inBasket = json['in_basket'];
    _basketCount = json['basket_count'];
    _inFavorite = json['in_favorite'];
    if (json['shops'] != null) {
      _shops = [];
      json['shops'].forEach((v) {
        _shops!.add(Shops.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  int? _price;
  int? _compound;
  String? _description;
  String? _sizeTitle;
  List<String>? _size;
  List<String>? _color;
  List<String>? _path;
  Shop? _shop;
  int? _rating;
  int? _count;
  bool? _inBasket;
  int? _basketCount;
  bool? _inFavorite;
  List<Shops>? _shops;

  int? get id => _id;
  String? get name => _name;
  int? get price => _price;
  int? get compound => _compound;
  String? get description => _description;
  String? get sizeTitle => _sizeTitle;
  List<String>? get size => _size;
  List<String>? get color => _color;
  List<String>? get path => _path;
  Shop? get shop => _shop;
  int? get rating => _rating;
  int? get count => _count;
  bool? get inBasket => _inBasket;
  int? get basketCount => _basketCount;
  bool? get inFavorite => _inFavorite;
  List<Shops>? get shops => _shops;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['compound'] = _compound;
    map['description'] = _description;
    map['size_title'] = _sizeTitle;
    map['size'] = _size;
    map['color'] = _color;
    map['path'] = _path;
    if (_shop != null) {
      map['shop'] = _shop!.toJson();
    }
    map['rating'] = _rating;
    map['count'] = _count;
    map['in_basket'] = _inBasket;
    map['basket_count'] = _basketCount;
    map['in_favorite'] = _inFavorite;
    if (_shops != null) {
      map['shops'] = _shops!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Shops {
  Shops({
    Shop? shop,
    int? productId,
    String? sizeTitle,
    bool? inSubs,
    List<String>? size,
    List<String>? color,
  }) {
    _shop = shop;
    _inSubs = inSubs;
    _productId = productId;
    _sizeTitle = sizeTitle;
    _size = size;
    _color = color;
  }

  Shops.fromJson(dynamic json) {
    _shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    _inSubs = json['in_subscribes'];
    _productId = json['product_id'];
    _sizeTitle = json['size_title'];
    _size = json['size'] != null ? json['size'].cast<String>() : [];
    _color = json['color'] != null ? json['color'].cast<String>() : [];
  }
  Shop? _shop;
  bool? _inSubs;
  int? _productId;
  String? _sizeTitle;
  List<String>? _size;
  List<String>? _color;

  Shop? get shop => _shop;
  bool? get inSubs => _inSubs;
  int? get productId => _productId;
  String? get sizeTitle => _sizeTitle;
  List<String>? get size => _size;
  List<String>? get color => _color;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_shop != null) {
      map['shop'] = _shop!.toJson();
    }
    map['product_id'] = _inSubs;
    map['product_id'] = _productId;
    map['size_title'] = _sizeTitle;
    map['size'] = _size;
    map['color'] = _color;
    return map;
  }
}

class Shop {
  Shop({
    int? id,
    String? name,
    String? logo,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _logo = logo;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Shop.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _logo = json['logo'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _logo;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get logo => _logo;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['logo'] = _logo;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Review {
  Review({
    int? first,
    int? second,
    int? three,
    int? four,
    int? five,
    int? rating,
    int? count,
  }) {
    _first = first;
    _second = second;
    _three = three;
    _four = four;
    _five = five;
    _rating = rating;
    _count = count;
  }

  Review.fromJson(dynamic json) {
    _first = json['1'];
    _second = json['2'];
    _three = json['3'];
    _four = json['4'];
    _five = json['5'];
    _rating = json['rating'];
    _count = json['count'];
  }
  int? _first;
  int? _second;
  int? _three;
  int? _four;
  int? _five;
  int? _rating;
  int? _count;

  int? get first => _first;
  int? get second => _second;
  int? get three => _three;
  int? get four => _four;
  int? get five => _five;
  int? get rating => _rating;
  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['1'] = _first;
    map['2'] = _second;
    map['3'] = _three;
    map['4'] = _four;
    map['5'] = _five;
    map['rating'] = _rating;
    map['count'] = _count;

    return map;
  }
}
