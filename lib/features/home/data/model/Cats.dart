class Cats {
  Cats({
    int? id,
    String? name,
    String? icon,
    String? image,
    int? bonus,
    int? credit,
    dynamic createdAt,
    dynamic updatedAt,}){
    _id = id;
    _name = name;
    _icon = icon;
    _image = image;
    _bonus = bonus;
    _credit = credit;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Cats.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _icon = json['icon'];
    _image = json['image'];
    _bonus = json['bonus'];
    _credit = json['credit'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _icon;
  String? _image;
  int? _bonus;
  int? _credit;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get icon => _icon;
  String? get image => _image;
  int? get bonus => _bonus;
  int? get credit => _credit;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['icon'] = _icon;
    map['image'] = _image;
    map['bonus'] = _bonus;
    map['credit'] = _credit;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}