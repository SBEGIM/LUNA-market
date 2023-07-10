class ProfileMonthStatics {
  ProfileMonthStatics({
    int? id,
    String? name,
    int? price,
    int? count,
    int? bonusPercent,
    int? bonus,
    int? total,
  }) {
    _id = id;
    _name = name;
    _price = price;
    _count = count;
    _bonusPercent = bonusPercent;
    _bonus = bonus;
    _total = total;
  }

  ProfileMonthStatics.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _count = json['count'];
    _bonusPercent = json['bonus_percent'];
    _bonus = json['bonus'];
    _total = json['total'];
  }
  int? _id;
  String? _name;
  int? _price;
  int? _count;
  int? _bonusPercent;
  int? _bonus;
  int? _total;

  int? get id => _id;
  String? get name => _name;
  int? get price => _price;
  int? get count => _count;
  int? get bonusPercent => _bonusPercent;
  int? get bonus => _bonus;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['count'] = _count;
    map['bonus_percent'] = _bonusPercent;
    map['bonus'] = _bonus;
    map['total'] = _total;
    return map;
  }
}
