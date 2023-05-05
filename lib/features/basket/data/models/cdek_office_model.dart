class CdekOfficeModel {
  CdekOfficeModel({
    String? code,
    String? name,
    String? addressComment,
    String? nearestStation,
    String? workTime,
    List<Phones>? phones,
    String? email,
    String? note,
    String? type,
    String? ownerCode,
    bool? takeOnly,
    bool? isHandout,
    bool? isReception,
    bool? isDressingRoom,
    bool? haveCashless,
    bool? haveCash,
    bool? allowedCod,
    List<OfficeImageList>? officeImageList,
    List<WorkTimeList>? workTimeList,
    double? weightMin,
    double? weightMax,
    Location? location,
    bool? fulfillment,
  }) {
    _code = code;
    _name = name;
    _addressComment = addressComment;
    _nearestStation = nearestStation;
    _workTime = workTime;
    _phones = phones;
    _email = email;
    _note = note;
    _type = type;
    _ownerCode = ownerCode;
    _takeOnly = takeOnly;
    _isHandout = isHandout;
    _isReception = isReception;
    _isDressingRoom = isDressingRoom;
    _haveCashless = haveCashless;
    _haveCash = haveCash;
    _allowedCod = allowedCod;
    _officeImageList = officeImageList;
    _workTimeList = workTimeList;
    _weightMin = weightMin;
    _weightMax = weightMax;
    _location = location;
    _fulfillment = fulfillment;
  }

  CdekOfficeModel.fromJson(dynamic json) {
    _code = json['code'];
    _name = json['name'];
    _addressComment = json['address_comment'];
    _nearestStation = json['nearest_station'];
    _workTime = json['work_time'];
    if (json['phones'] != null) {
      _phones = [];
      json['phones'].forEach((v) {
        _phones?.add(Phones.fromJson(v));
      });
    }
    _email = json['email'];
    _note = json['note'];
    _type = json['type'];
    _ownerCode = json['owner_code'];
    _takeOnly = json['take_only'];
    _isHandout = json['is_handout'];
    _isReception = json['is_reception'];
    _isDressingRoom = json['is_dressing_room'];
    _haveCashless = json['have_cashless'];
    _haveCash = json['have_cash'];
    _allowedCod = json['allowed_cod'];
    if (json['office_image_list'] != null) {
      _officeImageList = [];
      json['office_image_list'].forEach((v) {
        _officeImageList?.add(OfficeImageList.fromJson(v));
      });
    }
    if (json['work_time_list'] != null) {
      _workTimeList = [];
      json['work_time_list'].forEach((v) {
        _workTimeList?.add(WorkTimeList.fromJson(v));
      });
    }
    _weightMin = json['weight_min'];
    _weightMax = json['weight_max'];
    _location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    _fulfillment = json['fulfillment'];
  }
  String? _code;
  String? _name;
  String? _addressComment;
  String? _nearestStation;
  String? _workTime;
  List<Phones>? _phones;
  String? _email;
  String? _note;
  String? _type;
  String? _ownerCode;
  bool? _takeOnly;
  bool? _isHandout;
  bool? _isReception;
  bool? _isDressingRoom;
  bool? _haveCashless;
  bool? _haveCash;
  bool? _allowedCod;
  List<OfficeImageList>? _officeImageList;
  List<WorkTimeList>? _workTimeList;
  double? _weightMin;
  double? _weightMax;
  Location? _location;
  bool? _fulfillment;

  String? get code => _code;
  String? get name => _name;
  String? get addressComment => _addressComment;
  String? get nearestStation => _nearestStation;
  String? get workTime => _workTime;
  List<Phones>? get phones => _phones;
  String? get email => _email;
  String? get note => _note;
  String? get type => _type;
  String? get ownerCode => _ownerCode;
  bool? get takeOnly => _takeOnly;
  bool? get isHandout => _isHandout;
  bool? get isReception => _isReception;
  bool? get isDressingRoom => _isDressingRoom;
  bool? get haveCashless => _haveCashless;
  bool? get haveCash => _haveCash;
  bool? get allowedCod => _allowedCod;
  List<OfficeImageList>? get officeImageList => _officeImageList;
  List<WorkTimeList>? get workTimeList => _workTimeList;
  double? get weightMin => _weightMin;
  double? get weightMax => _weightMax;
  Location? get location => _location;
  bool? get fulfillment => _fulfillment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['name'] = _name;
    map['address_comment'] = _addressComment;
    map['nearest_station'] = _nearestStation;
    map['work_time'] = _workTime;
    if (_phones != null) {
      map['phones'] = _phones?.map((v) => v.toJson()).toList();
    }
    map['email'] = _email;
    map['note'] = _note;
    map['type'] = _type;
    map['owner_code'] = _ownerCode;
    map['take_only'] = _takeOnly;
    map['is_handout'] = _isHandout;
    map['is_reception'] = _isReception;
    map['is_dressing_room'] = _isDressingRoom;
    map['have_cashless'] = _haveCashless;
    map['have_cash'] = _haveCash;
    map['allowed_cod'] = _allowedCod;
    if (_officeImageList != null) {
      map['office_image_list'] =
          _officeImageList?.map((v) => v.toJson()).toList();
    }
    if (_workTimeList != null) {
      map['work_time_list'] = _workTimeList?.map((v) => v.toJson()).toList();
    }
    map['weight_min'] = _weightMin;
    map['weight_max'] = _weightMax;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['fulfillment'] = _fulfillment;
    return map;
  }
}

class Location {
  Location({
    String? countryCode,
    int? regionCode,
    String? region,
    int? cityCode,
    String? city,
    String? postalCode,
    double? longitude,
    double? latitude,
    String? address,
    String? addressFull,
  }) {
    _countryCode = countryCode;
    _regionCode = regionCode;
    _region = region;
    _cityCode = cityCode;
    _city = city;
    _postalCode = postalCode;
    _longitude = longitude;
    _latitude = latitude;
    _address = address;
    _addressFull = addressFull;
  }

  Location.fromJson(dynamic json) {
    _countryCode = json['country_code'];
    _regionCode = json['region_code'];
    _region = json['region'];
    _cityCode = json['city_code'];
    _city = json['city'];
    _postalCode = json['postal_code'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _address = json['address'];
    _addressFull = json['address_full'];
  }
  String? _countryCode;
  int? _regionCode;
  String? _region;
  int? _cityCode;
  String? _city;
  String? _postalCode;
  double? _longitude;
  double? _latitude;
  String? _address;
  String? _addressFull;

  String? get countryCode => _countryCode;
  int? get regionCode => _regionCode;
  String? get region => _region;
  int? get cityCode => _cityCode;
  String? get city => _city;
  String? get postalCode => _postalCode;
  double? get longitude => _longitude;
  double? get latitude => _latitude;
  String? get address => _address;
  String? get addressFull => _addressFull;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country_code'] = _countryCode;
    map['region_code'] = _regionCode;
    map['region'] = _region;
    map['city_code'] = _cityCode;
    map['city'] = _city;
    map['postal_code'] = _postalCode;
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    map['address'] = _address;
    map['address_full'] = _addressFull;
    return map;
  }
}

class WorkTimeList {
  WorkTimeList({
    int? day,
    String? time,
  }) {
    _day = day;
    _time = time;
  }

  WorkTimeList.fromJson(dynamic json) {
    _day = json['day'];
    _time = json['time'];
  }
  int? _day;
  String? _time;

  int? get day => _day;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = _day;
    map['time'] = _time;
    return map;
  }
}

class OfficeImageList {
  OfficeImageList({
    String? url,
  }) {
    _url = url;
  }

  OfficeImageList.fromJson(dynamic json) {
    _url = json['url'];
  }
  String? _url;

  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    return map;
  }
}

class Phones {
  Phones({
    String? number,
  }) {
    _number = number;
  }

  Phones.fromJson(dynamic json) {
    _number = json['number'];
  }
  String? _number;

  String? get number => _number;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = _number;
    return map;
  }
}
