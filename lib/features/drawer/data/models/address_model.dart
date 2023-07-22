class AddressModel {
  AddressModel({
    int? id,
    String? country,
    String? city,
    String? street,
    String? home,
    String? porch,
    String? floor,
    String? room,
  }) {
    _id = id;
    _country = country;
    _city = city;
    _street = street;
    _porch = porch;
    _floor = floor;
    _room = room;
  }

  AddressModel.fromJson(dynamic json) {
    _id = json['id'];
    _country = json['country'];
    _city = json['city'];
    _street = json['street'];
    _porch = json['porch'];
    _floor = json['floor'];
    _room = json['room'];
  }
  int? _id;
  String? _country;
  String? _city;
  String? _street;
  String? _porch;
  String? _floor;
  String? _room;

  int? get id => _id;
  String? get country => _country;
  String? get city => _city;
  String? get street => _street;
  String? get porch => _porch;
  String? get floor => _floor;
  String? get room => _room;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['country'] = _country;
    map['city'] = _city;
    map['street'] = _street;
    map['porch'] = _porch;
    map['floor'] = _floor;
    map['room'] = _room;

    return map;
  }
}
