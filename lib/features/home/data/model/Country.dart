class Country {
  Country({
    int? id,
    String? name,
    String? path,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    _id = id;
    _name = name;
    _path = path;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Country.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _path = json['path'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _path;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get path => _path;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['path'] = _path;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
