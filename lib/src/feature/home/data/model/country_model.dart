class CountryModel {
  CountryModel({
    int? id,
    String? name,
    String? code,
    String? path,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    _id = id;
    _name = name;
    _code = code;
    _path = path;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  CountryModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _code = json['code'];
    _path = json['path'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _code;
  String? _path;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get code => _code;
  String? get path => _path;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['code'] = _code;
    map['path'] = _path;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
