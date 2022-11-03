class Banners {
  Banners({
      int? id, 
      String? title, 
      String? path, 
      int? bonus, 
      String? date,}){
    _id = id;
    _title = title;
    _path = path;
    _bonus = bonus;
    _date = date;
}

  Banners.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _path = json['path'];
    _bonus = json['bonus'];
    _date = json['date'];
  }
  int? _id;
  String? _title;
  String? _path;
  int? _bonus;
  String? _date;

  int? get id => _id;
  String? get title => _title;
  String? get path => _path;
  int? get bonus => _bonus;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['path'] = _path;
    map['bonus'] = _bonus;
    map['date'] = _date;
    return map;
  }

}