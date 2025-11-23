class CityModel {
  CityModel({
    int? id,
    String? name,
    String? city,
    int? code,
    dynamic long,
    dynamic lat,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    _id = id;
    _name = name;
    _city = city;
    _long = long;
    _lat = lat;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  CityModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _city = json['city'];
    _code = json['code'];
    _long = json['longitude'];
    _lat = json['latitude'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  CityModel.fromStorageJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _city = json['city'];
    _code = json['code'];
    _long = json['long'];
    _lat = json['lat'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _city;
  int? _code;
  dynamic _lat;
  dynamic _long;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get city => _city;
  int? get code => _code;
  dynamic get long => _long;
  dynamic get lat => _lat;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['city'] = _city;
    map['code'] = _code;
    map['lat'] = _lat;
    map['long'] = _long;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
