class PopularShops {
  PopularShops({
    int? id,
    String? name,
    int? catId,
    String? catName,
    dynamic logo,
    String? image,
    int? bonus,
    int? rating,
    bool? credit,
  }) {
    _id = id;
    _name = name;
    _logo = logo;
    _image = image;
    _bonus = bonus;
    _credit = credit;
  }

  PopularShops.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _catId = json['cat_id'];
    _catName = json['cat_name'];
    _logo = json['logo'];
    _image = json['image'];
    _bonus = json['bonus'];
    _rating = json['rating'];
    _credit = json['credit'];
  }
  int? _id;
  String? _name;
  int? _catId;
  String? _catName;
  dynamic _logo;
  String? _image;
  int? _bonus;
  int? _rating;
  bool? _credit;

  int? get id => _id;
  String? get name => _name;
  int? get catId => _catId;
  String? get catName => _catName;
  dynamic get logo => _logo;
  String? get image => _image;
  int? get bonus => _bonus;
  int? get rating => _rating;
  bool? get credit => _credit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['cat_name'] = _catName;
    map['cat_id'] = _catId;
    map['logo'] = _logo;
    map['image'] = _image;
    map['bonus'] = _bonus;
    map['rating'] = _rating;
    map['credit'] = _credit;
    return map;
  }
}
