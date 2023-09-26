class ProfileMonthStatics {
  ProfileMonthStatics({
    int? id,
    String? name,
    String? path,
    int? price,
    int? count,
    int? bonusPercent,
    int? bonus,
  }) {
    _id = id;
    _name = name;
    _path = path;
    _price = price;
    _count = count;
    _bonusPercent = bonusPercent;
    _bonus = bonus;
  }

  ProfileMonthStatics.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _path = json['path'];
    _price = json['price'];
    _count = json['count'];
    _bonusPercent = json['bonus_percent'];
    _bonus = json['bonus'];
  }
  int? _id;
  String? _name;
  String? _path;
  int? _price;
  int? _count;
  int? _bonusPercent;
  int? _bonus;

  int? get id => _id;
  String? get name => _name;
  String? get path => _path;
  int? get price => _price;
  int? get count => _count;
  int? get bonusPercent => _bonusPercent;
  int? get bonus => _bonus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['path'] = _path;
    map['price'] = _price;
    map['count'] = _count;
    map['bonus_percent'] = _bonusPercent;
    map['bonus'] = _bonus;
    return map;
  }
}
