class AddressModel {
  AddressModel({
    int? id,
    String? country,
    String? city,
    String? home,
    String? street,
    String? entrance,
    String? porch,
    String? floor,
    String? room,
    String? apartament,
    String? phone,
    String? comment,
  }) {
    _id = id;
    _country = country;
    _city = city;
    _street = street;
    _entrance = entrance;
    _home = home;
    _porch = porch;
    _floor = floor;
    _room = room;
    _apartament = apartament;
    _phone = phone;
    _comment = comment;
  }

  AddressModel.fromJson(dynamic json) {
    _id = json['id'];
    _country = json['country'];
    _city = json['city'];
    _home = json['home'];
    _street = json['street'];
    _entrance = json['entrance'];
    _porch = json['porch'];
    _floor = json['floor'];
    _room = json['room'];
    _apartament = json['apartament'];
    _phone = json['phone'];
    _comment = json['comment'];
  }
  int? _id;
  String? _country;
  String? _city;
  String? _street;
  String? _entrance;
  String? _home;
  String? _porch;
  String? _floor;
  String? _room;
  String? _apartament;
  String? _phone;
  String? _comment;

  int? get id => _id;
  String? get country => _country;
  String? get home => _home;
  String? get city => _city;
  String? get street => _street;
  String? get entrance => _entrance;
  String? get porch => _porch;
  String? get floor => _floor;
  String? get room => _room;
  String? get apartament => _apartament;
  String? get phone => _phone;
  String? get comment => _comment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['country'] = _country;
    map['home'] = _home;
    map['city'] = _city;
    map['street'] = _street;
    map['entrance'] = _entrance;
    map['porch'] = _porch;
    map['floor'] = _floor;
    map['room'] = _room;
    map['apartament'] = _apartament;
    map['phone'] = _phone;
    map['comment'] = _comment;

    return map;
  }
}
