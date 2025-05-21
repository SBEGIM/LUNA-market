class ProfileMonthStatics {
  ProfileMonthStatics({
    int? id,
    String? name,
    String? path,
    String? pointBlogger,
    int? price,
    int? count,
    int? bonusPercent,
    int? bonus,
    int? total,
    String? status,
  }) {
    _id = id;
    _name = name;
    _path = path;
    _price = price;
    _count = count;
    _bonusPercent = bonusPercent;
    _bonus = bonus;
    _pointBlogger = pointBlogger;
    _total = total;
    _status = status;
  }

  ProfileMonthStatics.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _path = json['path'];
    _price = json['price'];
    _count = json['count'];
    _bonusPercent = json['bonus_percent'];
    _bonus = json['bonus'];
    _pointBlogger = json['point_blogger'];
    _total = json['total'];
    _status = json['status'];
  }
  int? _id;
  String? _name;
  String? _path;
  int? _price;
  int? _count;
  int? _bonusPercent;
  int? _bonus;
  String? _pointBlogger;
  int? _total;
  String? _status;

  int? get id => _id;
  String? get name => _name;
  String? get path => _path;
  int? get price => _price;
  int? get count => _count;
  int? get bonusPercent => _bonusPercent;
  int? get bonus => _bonus;
  String? get pointBlogger => _pointBlogger;
  int? get total => _total;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['path'] = _path;
    map['price'] = _price;
    map['count'] = _count;
    map['bonus_percent'] = _bonusPercent;
    map['bonus'] = _bonus;
    map['point_blogger'] = _pointBlogger;
    map['total'] = _total;
    map['status'] = _status;
    return map;
  }
}
