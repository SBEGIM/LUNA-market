class Banners {
  Banners({
    int? id,
    String? title,
    String? path,
    int? bonus,
    String? date,
    String? url,
    String? description,
  }) {
    _id = id;
    _title = title;
    _path = path;
    _bonus = bonus;
    _date = date;
    _url = url;
    _description = description;
  }

  Banners.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _path = json['path'];
    _bonus = json['bonus'];
    _date = json['date'];
    _url = json['url'];
    _description = json['description'];
  }
  int? _id;
  String? _title;
  String? _path;
  int? _bonus;
  String? _date;
  String? _url;
  String? _description;

  int? get id => _id;
  String? get title => _title;
  String? get path => _path;
  int? get bonus => _bonus;
  String? get date => _date;
  String? get url => _url;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['path'] = _path;
    map['bonus'] = _bonus;
    map['date'] = _date;
    map['url'] = _url;
    map['description'] = _description;

    return map;
  }
}
