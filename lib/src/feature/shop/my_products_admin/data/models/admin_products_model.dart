class AdminProductsModel {
  AdminProductsModel({
    int? id,
    int? catId,
    int? subCatId,
    int? brandId,
    int? shopId,
    int? count,
    int? currentCount,
    String? name,
    String? catName,
    int? price,
    int? compound,
    int? point,
    int? bonus,
    int? pre_order,
    String? fulfillment,
    String? description,
    dynamic articul,
    dynamic height,
    dynamic width,
    dynamic deep,
    dynamic massa,
    String? created_at,
    List<String>? size,
    List<String>? color,
    Path? path,
    List<String>? images,
    List<SizeDTO>? sizeV1,
    List<BlocDTO>? bloc,
    List<Characteristic>? characteristics,
    int? pointBlogger,
  }) {
    _id = id;
    _catId = catId;
    _subCatId = subCatId;
    _brandId = brandId;
    _shopId = shopId;
    _count = count;
    _currentCount = currentCount;
    _name = name;
    _catName = catName;
    _price = price;
    _compound = compound;
    _point = point;
    _bonus = bonus;
    _pre_order = pre_order;
    _fulfillment = fulfillment;
    _description = description;
    _articul = articul;
    _height = height;
    _width = width;
    _deep = deep;
    _massa = massa;
    _created_at = created_at;
    _size = size;
    _color = color;
    _path = path;
    _sizeV1 = sizeV1;
    _bloc = bloc;
    _characteristics = characteristics;
    _pointBlogger = pointBlogger;
  }

  AdminProductsModel.fromJson(dynamic json) {
    _id = json['id'];
    _catId = json['cat_id'];
    _subCatId = json['sub_cat_id'];
    _brandId = json['brand_id'];
    _shopId = json['shop_id'];
    _count = json['count'];
    _currentCount = json['current_count'];
    _name = json['name'];
    _catName = json['cat_name'];
    _price = json['price'];
    _compound = json['compound'];
    _point = json['point'];
    _bonus = json['bonus'];
    _pre_order = json['pre_order'];
    _fulfillment = json['fulfillment'];
    _description = json['description'];
    _articul = json['articul'];
    _height = json['height'];
    _width = json['width'];
    _deep = json['deep'];
    _massa = json['massa'];
    _created_at = json['created_at'];
    _size = json['size'] != null ? json['size'].cast<String>() : [];
    _color = json['color'] != null ? json['color'].cast<String>() : [];
    _path = json['path'] != null ? Path.fromJson(json['path']) : null;
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _sizeV1 = json['size_v1'] != null ? (json['size_v1'] as List).map((e) => SizeDTO.fromJson(e)).toList() : [];
    _bloc = json['bloc'] != null ? (json['bloc'] as List).map((e) => BlocDTO.fromJson(e)).toList() : [];
    _characteristics = json['characteristics'] != null
        ? (json['characteristics'] as List).map((e) => Characteristic.fromJson(e)).toList()
        : [];

    _pointBlogger = json['point_blogger'];
  }
  int? _id;
  int? _catId;
  int? _subCatId;
  dynamic _brandId;
  int? _shopId;
  int? _count;
  int? _currentCount;
  String? _name;
  String? _catName;
  int? _price;
  int? _compound;
  int? _point;
  int? _bonus;
  int? _pre_order;
  String? _fulfillment;
  String? _description;
  dynamic _articul;
  dynamic _height;
  dynamic _width;
  dynamic _deep;
  dynamic _massa;
  String? _created_at;
  List<String>? _size;
  List<String>? _color;
  Path? _path;
  List<String>? _images;
  List<SizeDTO>? _sizeV1;
  List<BlocDTO>? _bloc;
  List<Characteristic>? _characteristics;
  int? _pointBlogger;

  int? get id => _id;
  int? get catId => _catId;
  int? get subCatId => _subCatId;
  dynamic get brandId => _brandId;
  int? get shopId => _shopId;
  int? get count => _count;
  int? get currentCount => _currentCount;
  String? get name => _name;
  String? get catName => _catName;
  int? get price => _price;
  int? get compound => _compound;
  int? get point => _point;
  int? get bonus => _bonus;
  int? get pre_order => _pre_order;
  String? get fulfillment => _fulfillment;
  String? get description => _description;
  dynamic get articul => _articul;
  dynamic get height => _height;
  dynamic get width => _width;
  dynamic get deep => _deep;
  dynamic get massa => _massa;
  String? get created_at => _created_at;
  List<String>? get size => _size;
  List<String>? get color => _color;
  Path? get path => _path;
  List<String>? get images => _images;
  List<SizeDTO>? get sizeV1 => _sizeV1;
  List<BlocDTO>? get bloc => _bloc;
  List<Characteristic>? get characteristics => _characteristics;
  int? get pointBlogger => _pointBlogger;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['cat_id'] = _catId;
    map['sub_cat_id'] = _subCatId;
    map['brand_id'] = _brandId;
    map['shop_id'] = _shopId;
    map['count'] = _count;
    map['current_count'] = _currentCount;
    map['name'] = _name;
    map['catName'] = _catName;
    map['price'] = _price;
    map['compound'] = _compound;
    map['point'] = _point;
    map['bonus'] = _bonus;
    map['pre_order'] = _pre_order;
    map['fulfillment'] = _fulfillment;
    map['description'] = _description;
    map['articul'] = _articul;
    map['height'] = _height;
    map['width'] = _width;
    map['deep'] = _deep;
    map['massa'] = _massa;
    map['created_at'] = _created_at;
    map['size'] = _size;
    map['color'] = _color;
    if (_path != null) {
      map['path'] = _path?.toJson();
    }
    map['point_blogger'] = _pointBlogger;
    map['characteristics'] = _characteristics;
    return map;
  }
}

class Path {
  Path({
    String? path,
  }) {
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

class SizeDTO {
  SizeDTO({
    String? name,
    int? count,
  }) {
    _name = name;
    _count = count;
  }

  SizeDTO.fromJson(dynamic json) {
    _name = json['name'];
    _count = json['count'];
  }

  String? _name;
  int? _count;

  String? get name => _name;
  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['count'] = _count;
    return map;
  }
}

class BlocDTO {
  BlocDTO({
    int? price,
    int? count,
  }) {
    _price = price;
    _count = count;
  }

  BlocDTO.fromJson(dynamic json) {
    _price = json['price'];
    _count = json['count'];
  }

  int? _price;
  int? _count;

  int? get price => _price;
  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = _price;
    map['count'] = _count;
    return map;
  }
}

class Characteristic {
  Characteristic({
    int? id,
    String? name,
    String? value,
  }) {
    _id = id;
    _name = name;
    _value = value;
  }

  Characteristic.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _value = json['value'];
  }
  int? _id;
  String? _name;
  String? _value;

  int? get id => _id;
  String? get name => _name;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['value'] = _value;

    return map;
  }
}
