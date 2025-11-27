class BloggerShopProductModel {
  BloggerShopProductModel({
    int? id,
    int? catId,
    int? brandId,
    int? shopId,
    int? count,
    int? currentCount,
    String? name,
    String? catName,
    int? price,
    int? compound,
    int? bonus,
    int? bloggerPoint,
    String? description,
    dynamic articul,
    dynamic height,
    dynamic width,
    dynamic deep,
    dynamic massa,
    List<String>? size,
    List<String>? color,
    Path? path,
  }) {
    _id = id;
    _catId = catId;
    _brandId = brandId;
    _shopId = shopId;
    _count = count;
    _currentCount = currentCount;
    _name = name;
    _catName = catName;
    _price = price;
    _compound = compound;
    _bonus = bonus;
    _bloggerPoint = bloggerPoint;
    _description = description;
    _articul = articul;
    _height = height;
    _width = width;
    _deep = deep;
    _massa = massa;
    _size = size;
    _color = color;
    _path = path;
  }

  BloggerShopProductModel.fromJson(dynamic json) {
    _id = json['id'];
    _catId = json['cat_id'];
    _brandId = json['brand_id'];
    _shopId = json['shop_id'];
    _count = json['count'];
    _currentCount = json['current_count'];
    _name = json['name'];
    _catName = json['cat_name'];
    _price = json['price'];
    _compound = json['compound'];
    _bonus = json['bonus'];
    _bloggerPoint = json['point_blogger'];
    _description = json['description'];
    _articul = json['articul'];
    _height = json['height'];
    _width = json['width'];
    _deep = json['deep'];
    _massa = json['massa'];
    _size = json['size'] != null ? json['size'].cast<String>() : [];
    _color = json['color'] != null ? json['color'].cast<String>() : [];
    _path = json['path'] != null ? Path.fromJson(json['path']) : null;
  }
  int? _id;
  int? _catId;
  int? _brandId;
  int? _shopId;
  int? _count;
  int? _currentCount;
  String? _name;
  String? _catName;
  int? _price;
  int? _compound;
  int? _bonus;
  int? _bloggerPoint;
  String? _description;
  dynamic _articul;
  dynamic _height;
  dynamic _width;
  dynamic _deep;
  dynamic _massa;
  List<String>? _size;
  List<String>? _color;
  Path? _path;

  int? get id => _id;
  int? get catId => _catId;
  int? get brandId => _brandId;
  int? get shopId => _shopId;
  int? get count => _count;
  int? get currentCount => _currentCount;
  String? get name => _name;
  String? get catName => _catName;
  int? get price => _price;
  int? get compound => _compound;
  int? get bonus => _bonus;
  int? get bloggerPoint => _bloggerPoint;
  String? get description => _description;
  dynamic get articul => _articul;
  dynamic get height => _height;
  dynamic get width => _width;
  dynamic get deep => _deep;
  dynamic get massa => _massa;
  List<String>? get size => _size;
  List<String>? get color => _color;
  Path? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['cat_id'] = _catId;
    map['brand_id'] = _brandId;
    map['shop_id'] = _shopId;
    map['count'] = _count;
    map['current_count'] = _currentCount;
    map['name'] = _name;
    map['catName'] = _catName;
    map['price'] = _price;
    map['compound'] = _compound;
    map['bonus'] = _bonus;
    map['bloggerPoint'] = _bloggerPoint;
    map['description'] = _description;
    map['articul'] = _articul;
    map['height'] = _height;
    map['width'] = _width;
    map['deep'] = _deep;
    map['massa'] = _massa;
    map['size'] = _size;
    map['color'] = _color;
    if (_path != null) {
      map['path'] = _path?.toJson();
    }
    return map;
  }
}

class Path {
  Path({String? path}) {
    _path = path;
  }

  Path.fromJson(dynamic json) {
    _path = json['path'];
  }
  String? _path;

  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = _path;
    return map;
  }
}
