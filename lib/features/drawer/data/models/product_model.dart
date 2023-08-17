class ProductModel {
  ProductModel({
    int? id,
    int? catId,
    int? brandId,
    String? name,
    int? price,
    int? product_count,
    int? compound,
    int? point,
    String? description,
    String? catName,
    String? brandName,
    String? sizeTitle,
    List<String>? size,
    List<String>? color,
    List<Bloc>? bloc,
    List<String>? path,
    String? video,
    Shop? shop,
    int? rating,
    int? count,
    bool? inBasket,
    bool? buyed,
    bool? optom,
    int? basketCount,
    bool? inFavorite,
    List<Shops>? shops,
    List<int>? review,
    int? total,
    int? bloggerPoint,
  }) {
    _id = id;
    _catId = catId;
    _brandId = brandId;
    _name = name;
    _price = price;
    _product_count = product_count;
    _compound = compound;
    _point = point;
    _description = description;
    _catName = catName;
    _brandName = brandName;
    _sizeTitle = sizeTitle;
    _size = size;
    _color = color;
    _bloc = bloc;
    _path = path;
    _video = video;
    _shop = shop;
    _rating = rating;
    _count = count;
    _inBasket = inBasket;
    _buyed = buyed;
    _optom = optom;
    _basketCount = basketCount;
    _inFavorite = inFavorite;
    _shops = shops;
    _review = review;
    _total = total;
    _bloggerPoint = bloggerPoint;
  }

  ProductModel copyWith({
    int? id,
    int? catId,
    int? brandId,
    String? name,
    int? price,
    int? product_count,
    int? compound,
    int? point,
    String? description,
    String? catName,
    String? brandName,
    String? sizeTitle,
    List<String>? size,
    List<String>? color,
    List<Bloc>? bloc,
    List<String>? path,
    String? video,
    Shop? shop,
    int? rating,
    int? count,
    bool? inBasket,
    bool? buyed,
    bool? optom,
    int? basketCount,
    bool? inFavorite,
    List<Shops>? shops,
    List<int>? review,
    int? total,
    int? bloggerPoint,
  }) {
    return ProductModel(
      id: id ?? this.id,
      catId: catId ?? this.catId,
      brandId: brandId ?? this.brandId,
      name: name ?? this.name,
      price: price ?? this.price,
      product_count: product_count ?? this.product_count,
      compound: compound ?? this.compound,
      point: point ?? this.point,
      description: description ?? this.description,
      catName: catName ?? this.catName,
      brandName: brandName ?? this.brandName,
      sizeTitle: sizeTitle ?? this.sizeTitle,
      size: size ?? this.size,
      color: color ?? this.color,
      bloc: bloc ?? this.bloc,
      path: path ?? this.path,
      video: video ?? this.video,
      shop: shop ?? this.shop,
      rating: rating ?? this.rating,
      count: count ?? this.count,
      inBasket: inBasket ?? this.inBasket,
      buyed: buyed ?? this.buyed,
      optom: optom ?? this.optom,
      basketCount: basketCount ?? this.basketCount,
      inFavorite: inFavorite ?? this.inFavorite,
      shops: shops ?? this.shops,
      review: review ?? this.review,
      total: total ?? this.total,
      bloggerPoint: bloggerPoint ?? this.bloggerPoint,
    );
  }

  ProductModel.fromJson(dynamic json) {
    _id = json['id'];
    _catId = json['cat_id'];
    _brandId = json['brand_id'];
    _name = json['name'];
    _price = json['price'];
    _product_count = json['product_count'];
    _compound = json['compound'];
    _point = json['point'];
    _description = json['description'];
    _catName = json['cat_name'];
    _brandName = json['brand_name'];
    _sizeTitle = json['size_title'];
    _size = json['size'] != null ? json['size'].cast<String>() : [];
    _color = json['color'] != null ? json['color'].cast<String>() : [];
    if (json['bloc'] != null) {
      _bloc = [];
      json['bloc'].forEach((v) {
        _bloc!.add(Bloc.fromJson(v));
      });
    }
    _path = json['path'] != null ? json['path'].cast<String>() : [];
    _video = json['video'];
    _shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    _rating = json['rating'];
    _count = json['count'];
    _total = json['total'];
    _inBasket = json['in_basket'];
    _buyed = json['buyed'];
    _optom = json['optom'];
    _basketCount = json['basket_count'];
    _inFavorite = json['in_favorite'];
    if (json['shops'] != null) {
      _shops = [];
      json['shops'].forEach((v) {
        _shops!.add(Shops.fromJson(v));
      });
    }
    _review = json['review'] != null ? json['review'].cast<int>() : [];
    _bloggerPoint = json['point_blogger'];
  }
  int? _id;
  int? _catId;
  int? _brandId;
  String? _name;
  int? _price;
  int? _product_count;
  int? _compound;
  int? _point;
  String? _description;
  String? _catName;
  String? _brandName;
  String? _sizeTitle;
  List<String>? _size;
  List<String>? _color;
  List<Bloc>? _bloc;
  List<String>? _path;
  String? _video;
  Shop? _shop;
  int? _rating;
  int? _count;
  int? _total;
  bool? _inBasket;
  bool? _buyed;
  bool? _optom;
  int? _basketCount;
  bool? _inFavorite;
  List<Shops>? _shops;
  List<int>? _review;
  int? _bloggerPoint;

  int? get id => _id;
  int? get catId => _catId;
  int? get brandId => _brandId;
  String? get name => _name;
  int? get price => _price;
  int? get product_count => _product_count;
  int? get compound => _compound;
  int? get point => _point;
  String? get description => _description;
  String? get catName => _catName;
  String? get brandName => _brandName;
  String? get sizeTitle => _sizeTitle;
  List<String>? get size => _size;
  List<String>? get color => _color;
  List<Bloc>? get bloc => _bloc;
  List<String>? get path => _path;
  String? get video => _video;
  Shop? get shop => _shop;
  int? get rating => _rating;
  int? get count => _count;
  int? get total => _total;
  bool? get inBasket => _inBasket;
  bool? get buyed => _buyed;
  bool? get optom => _optom;
  int? get basketCount => _basketCount;
  bool? get inFavorite => _inFavorite;
  List<Shops>? get shops => _shops;
  List<int>? get review => _review;
  int? get bloggerPoint => _bloggerPoint;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['catId'] = _catId;
    map['brandId'] = _brandId;
    map['name'] = _name;
    map['price'] = _price;
    map['product_count'] = _product_count;
    map['compound'] = _compound;
    map['point'] = _point;
    map['description'] = _description;
    map['catName'] = _catName;
    map['brandName'] = _brandName;
    map['size_title'] = _sizeTitle;
    map['size'] = _size;
    map['color'] = _color;
    map['bloc'] = _bloc;
    map['path'] = _path;
    if (_shop != null) {
      map['shop'] = _shop!.toJson();
    }
    map['video'] = _video;
    map['rating'] = _rating;
    map['count'] = _count;
    map['total'] = _total;
    map['in_basket'] = _inBasket;
    map['buyed'] = _buyed;
    map['optom'] = _optom;
    map['basket_count'] = _basketCount;
    map['in_favorite'] = _inFavorite;
    if (_shops != null) {
      map['shops'] = _shops!.map((v) => v.toJson()).toList();
    }
    map['review'] = _review;
    map['blogger_point'] = _bloggerPoint;
    return map;
  }
}

class Shops {
  Shops({
    Shop? shop,
    int? productId,
    int? chatId,
    String? sizeTitle,
    bool? inSubs,
    List<String>? size,
    List<String>? color,
  }) {
    _shop = shop;
    _inSubs = inSubs;
    _productId = productId;
    _chatId = chatId;
    _sizeTitle = sizeTitle;
    _size = size;
    _color = color;
  }

  Shops.fromJson(dynamic json) {
    _shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    _inSubs = json['in_subscribes'];
    _productId = json['product_id'];
    _chatId = json['chat_id'];
    _sizeTitle = json['size_title'];
    _size = json['size'] != null ? json['size'].cast<String>() : [];
    _color = json['color'] != null ? json['color'].cast<String>() : [];
  }
  Shop? _shop;
  bool? _inSubs;
  int? _productId;
  int? _chatId;
  String? _sizeTitle;
  List<String>? _size;
  List<String>? _color;

  Shop? get shop => _shop;
  bool? get inSubs => _inSubs;
  int? get productId => _productId;
  int? get chatId => _chatId;
  String? get sizeTitle => _sizeTitle;
  List<String>? get size => _size;
  List<String>? get color => _color;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_shop != null) {
      map['shop'] = _shop!.toJson();
    }
    map['in_subscribes'] = _inSubs;
    map['product_id'] = _productId;
    map['chat_id'] = _chatId;
    map['size_title'] = _sizeTitle;
    map['size'] = _size;
    map['color'] = _color;
    return map;
  }
}

class Shop {
  Shop({
    int? id,
    int? chat_id,
    String? name,
    String? logo,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _chat_id = chat_id;
    _name = name;
    _logo = logo;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Shop.fromJson(dynamic json) {
    _id = json['id'];
    _chat_id = json['chat_id'];
    _name = json['name'];
    _logo = json['logo'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _chat_id;
  String? _name;
  String? _logo;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get chat_id => _chat_id;
  String? get name => _name;
  String? get logo => _logo;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['chat_id'] = _chat_id;
    map['name'] = _name;
    map['logo'] = _logo;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Bloc {
  Bloc({
    int? count,
    int? price,
  }) {
    _count = count;
    _price = price;
  }

  Bloc.fromJson(dynamic json) {
    _count = json['count'];
    _price = json['price'];
  }
  int? _count;
  int? _price;

  int? get count => _count;
  int? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['price'] = _price;

    return map;
  }
}
