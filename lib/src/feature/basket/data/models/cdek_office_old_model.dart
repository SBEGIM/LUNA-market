class CdekOfficeOldModel {
  final String? code;
  final String? status;
  final String? postalCode;
  final String? name;
  final String? countryCode;
  final String? countryCodeIso;
  final String? countryName;
  final String? regionCode;
  final String? regionName;
  final String? cityCode;
  final String? city;
  final String? workTime;
  final String? address;
  final String? fullAddress;
  final String? phone;
  final String? note;
  final String? coordX;
  final String? coordY;
  final String? type;
  final String? ownerCode;
  final bool? isDressingRoom;
  final bool? haveCashless;
  final bool? haveCash;
  final bool? allowedCod;
  final bool? takeOnly;
  final bool? isHandout;
  final bool? isReception;
  final bool? fulfillment;
  final String? nearestStation;
  final String? metroStation;
  final String? email;
  final String? addressComment;
  final WeightLimit? weightLimit;
  final List<WorkTimeYList>? workTimeYList;
  final List<PhoneDetailList>? phoneDetailList;
  const CdekOfficeOldModel({
    this.code,
    this.status,
    this.postalCode,
    this.name,
    this.countryCode,
    this.countryCodeIso,
    this.countryName,
    this.regionCode,
    this.regionName,
    this.cityCode,
    this.city,
    this.workTime,
    this.address,
    this.fullAddress,
    this.phone,
    this.note,
    this.coordX,
    this.coordY,
    this.type,
    this.ownerCode,
    this.isDressingRoom,
    this.haveCashless,
    this.haveCash,
    this.allowedCod,
    this.takeOnly,
    this.isHandout,
    this.isReception,
    this.fulfillment,
    this.nearestStation,
    this.metroStation,
    this.email,
    this.addressComment,
    this.weightLimit,
    this.workTimeYList,
    this.phoneDetailList,
  });
  CdekOfficeOldModel copyWith({
    String? code,
    String? status,
    String? postalCode,
    String? name,
    String? countryCode,
    String? countryCodeIso,
    String? countryName,
    String? regionCode,
    String? regionName,
    String? cityCode,
    String? city,
    String? workTime,
    String? address,
    String? fullAddress,
    String? phone,
    String? note,
    String? coordX,
    String? coordY,
    String? type,
    String? ownerCode,
    bool? isDressingRoom,
    bool? haveCashless,
    bool? haveCash,
    bool? allowedCod,
    bool? takeOnly,
    bool? isHandout,
    bool? isReception,
    bool? fulfillment,
    String? nearestStation,
    String? metroStation,
    String? email,
    String? addressComment,
    WeightLimit? weightLimit,
    List<WorkTimeYList>? workTimeYList,
    List<PhoneDetailList>? phoneDetailList,
  }) {
    return CdekOfficeOldModel(
      code: code ?? this.code,
      status: status ?? this.status,
      postalCode: postalCode ?? this.postalCode,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      countryCodeIso: countryCodeIso ?? this.countryCodeIso,
      countryName: countryName ?? this.countryName,
      regionCode: regionCode ?? this.regionCode,
      regionName: regionName ?? this.regionName,
      cityCode: cityCode ?? this.cityCode,
      city: city ?? this.city,
      workTime: workTime ?? this.workTime,
      address: address ?? this.address,
      fullAddress: fullAddress ?? this.fullAddress,
      phone: phone ?? this.phone,
      note: note ?? this.note,
      coordX: coordX ?? this.coordX,
      coordY: coordY ?? this.coordY,
      type: type ?? this.type,
      ownerCode: ownerCode ?? this.ownerCode,
      isDressingRoom: isDressingRoom ?? this.isDressingRoom,
      haveCashless: haveCashless ?? this.haveCashless,
      haveCash: haveCash ?? this.haveCash,
      allowedCod: allowedCod ?? this.allowedCod,
      takeOnly: takeOnly ?? this.takeOnly,
      isHandout: isHandout ?? this.isHandout,
      isReception: isReception ?? this.isReception,
      fulfillment: fulfillment ?? this.fulfillment,
      nearestStation: nearestStation ?? this.nearestStation,
      metroStation: metroStation ?? this.metroStation,
      email: email ?? this.email,
      addressComment: addressComment ?? this.addressComment,
      weightLimit: weightLimit ?? this.weightLimit,
      workTimeYList: workTimeYList ?? this.workTimeYList,
      phoneDetailList: phoneDetailList ?? this.phoneDetailList,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'code': code,
      'status': status,
      'postalCode': postalCode,
      'name': name,
      'countryCode': countryCode,
      'countryCodeIso': countryCodeIso,
      'countryName': countryName,
      'regionCode': regionCode,
      'regionName': regionName,
      'cityCode': cityCode,
      'city': city,
      'workTime': workTime,
      'address': address,
      'fullAddress': fullAddress,
      'phone': phone,
      'note': note,
      'coordX': coordX,
      'coordY': coordY,
      'type': type,
      'ownerCode': ownerCode,
      'isDressingRoom': isDressingRoom,
      'haveCashless': haveCashless,
      'haveCash': haveCash,
      'allowedCod': allowedCod,
      'takeOnly': takeOnly,
      'isHandout': isHandout,
      'isReception': isReception,
      'fulfillment': fulfillment,
      'nearestStation': nearestStation,
      'metroStation': metroStation,
      'email': email,
      'addressComment': addressComment,
      'weightLimit': weightLimit?.toJson(),
      'workTimeYList': workTimeYList?.map<Map<String, dynamic>>((data) => data.toJson()).toList(),
      'phoneDetailList': phoneDetailList
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList(),
    };
  }

  static CdekOfficeOldModel fromJson(Map<String, Object?> json) {
    return CdekOfficeOldModel(
      code: json['code'] == null ? null : json['code'] as String,
      status: json['status'] == null ? null : json['status'] as String,
      postalCode: json['postalCode'] == null ? null : json['postalCode'] as String,
      name: json['name'] == null ? null : json['name'] as String,
      countryCode: json['countryCode'] == null ? null : json['countryCode'] as String,
      countryCodeIso: json['countryCodeIso'] == null ? null : json['countryCodeIso'] as String,
      countryName: json['countryName'] == null ? null : json['countryName'] as String,
      regionCode: json['regionCode'] == null ? null : json['regionCode'] as String,
      regionName: json['regionName'] == null ? null : json['regionName'] as String,
      cityCode: json['cityCode'] == null ? null : json['cityCode'] as String,
      city: json['city'] == null ? null : json['city'] as String,
      workTime: json['workTime'] == null ? null : json['workTime'] as String,
      address: json['address'] == null ? null : json['address'] as String,
      fullAddress: json['fullAddress'] == null ? null : json['fullAddress'] as String,
      phone: json['phone'] == null ? null : json['phone'] as String,
      note: json['note'] == null ? null : json['note'] as String,
      coordX: json['coordX'] == null ? null : json['coordX'] as String,
      coordY: json['coordY'] == null ? null : json['coordY'] as String,
      type: json['type'] == null ? null : json['type'] as String,
      ownerCode: json['ownerCode'] == null ? null : json['ownerCode'] as String,
      isDressingRoom: json['isDressingRoom'] == null ? null : json['isDressingRoom'] as bool,
      haveCashless: json['haveCashless'] == null ? null : json['haveCashless'] as bool,
      haveCash: json['haveCash'] == null ? null : json['haveCash'] as bool,
      allowedCod: json['allowedCod'] == null ? null : json['allowedCod'] as bool,
      takeOnly: json['takeOnly'] == null ? null : json['takeOnly'] as bool,
      isHandout: json['isHandout'] == null ? null : json['isHandout'] as bool,
      isReception: json['isReception'] == null ? null : json['isReception'] as bool,
      fulfillment: json['fulfillment'] == null ? null : json['fulfillment'] as bool,
      nearestStation: json['nearestStation'] == null ? null : json['nearestStation'] as String,
      metroStation: json['metroStation'] == null ? null : json['metroStation'] as String,
      email: json['email'] == null ? null : json['email'] as String,
      addressComment: json['addressComment'] == null ? null : json['addressComment'] as String,
      weightLimit: json['weightLimit'] == null
          ? null
          : WeightLimit.fromJson(json['weightLimit'] as Map<String, Object?>),
      workTimeYList: json['workTimeYList'] == null
          ? null
          : (json['workTimeYList'] as List)
                .map<WorkTimeYList>((data) => WorkTimeYList.fromJson(data as Map<String, Object?>))
                .toList(),
      phoneDetailList: json['phoneDetailList'] == null
          ? null
          : (json['phoneDetailList'] as List)
                .map<PhoneDetailList>(
                  (data) => PhoneDetailList.fromJson(data as Map<String, Object?>),
                )
                .toList(),
    );
  }

  @override
  String toString() {
    return '''CdekOfficeOldModel(
                code:$code,
status:$status,
postalCode:$postalCode,
name:$name,
countryCode:$countryCode,
countryCodeIso:$countryCodeIso,
countryName:$countryName,
regionCode:$regionCode,
regionName:$regionName,
cityCode:$cityCode,
city:$city,
workTime:$workTime,
address:$address,
fullAddress:$fullAddress,
phone:$phone,
note:$note,
coordX:$coordX,
coordY:$coordY,
type:$type,
ownerCode:$ownerCode,
isDressingRoom:$isDressingRoom,
haveCashless:$haveCashless,
haveCash:$haveCash,
allowedCod:$allowedCod,
takeOnly:$takeOnly,
isHandout:$isHandout,
isReception:$isReception,
fulfillment:$fulfillment,
nearestStation:$nearestStation,
metroStation:$metroStation,
email:$email,
addressComment:$addressComment,
weightLimit:${weightLimit.toString()},
workTimeYList:${workTimeYList.toString()},
phoneDetailList:${phoneDetailList.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is CdekOfficeOldModel &&
        other.runtimeType == runtimeType &&
        other.code == code &&
        other.status == status &&
        other.postalCode == postalCode &&
        other.name == name &&
        other.countryCode == countryCode &&
        other.countryCodeIso == countryCodeIso &&
        other.countryName == countryName &&
        other.regionCode == regionCode &&
        other.regionName == regionName &&
        other.cityCode == cityCode &&
        other.city == city &&
        other.workTime == workTime &&
        other.address == address &&
        other.fullAddress == fullAddress &&
        other.phone == phone &&
        other.note == note &&
        other.coordX == coordX &&
        other.coordY == coordY &&
        other.type == type &&
        other.ownerCode == ownerCode &&
        other.isDressingRoom == isDressingRoom &&
        other.haveCashless == haveCashless &&
        other.haveCash == haveCash &&
        other.allowedCod == allowedCod &&
        other.takeOnly == takeOnly &&
        other.isHandout == isHandout &&
        other.isReception == isReception &&
        other.fulfillment == fulfillment &&
        other.nearestStation == nearestStation &&
        other.metroStation == metroStation &&
        other.email == email &&
        other.addressComment == addressComment &&
        other.weightLimit == weightLimit &&
        other.workTimeYList == workTimeYList &&
        other.phoneDetailList == phoneDetailList;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      code,
      status,
      postalCode,
      name,
      countryCode,
      countryCodeIso,
      countryName,
      regionCode,
      regionName,
      cityCode,
      city,
      workTime,
      address,
      fullAddress,
      phone,
      note,
      coordX,
      coordY,
      type,
    );
  }
}

class PhoneDetailList {
  final String? number;
  const PhoneDetailList({this.number});
  PhoneDetailList copyWith({String? number}) {
    return PhoneDetailList(number: number ?? this.number);
  }

  Map<String, Object?> toJson() {
    return {'number': number};
  }

  static PhoneDetailList fromJson(Map<String, Object?> json) {
    return PhoneDetailList(number: json['number'] == null ? null : json['number'] as String);
  }

  @override
  String toString() {
    return '''PhoneDetailList(
                number:$number
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is PhoneDetailList && other.runtimeType == runtimeType && other.number == number;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, number);
  }
}

class WorkTimeYList {
  final String? day;
  final String? periods;
  const WorkTimeYList({this.day, this.periods});
  WorkTimeYList copyWith({String? day, String? periods}) {
    return WorkTimeYList(day: day ?? this.day, periods: periods ?? this.periods);
  }

  Map<String, Object?> toJson() {
    return {'day': day, 'periods': periods};
  }

  static WorkTimeYList fromJson(Map<String, Object?> json) {
    return WorkTimeYList(
      day: json['day'] == null ? null : json['day'] as String,
      periods: json['periods'] == null ? null : json['periods'] as String,
    );
  }

  @override
  String toString() {
    return '''WorkTimeYList(
                day:$day,
periods:$periods
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is WorkTimeYList &&
        other.runtimeType == runtimeType &&
        other.day == day &&
        other.periods == periods;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, day, periods);
  }
}

class WeightLimit {
  final String? WeightMin;
  final String? WeightMax;
  const WeightLimit({this.WeightMin, this.WeightMax});
  WeightLimit copyWith({String? WeightMin, String? WeightMax}) {
    return WeightLimit(
      WeightMin: WeightMin ?? this.WeightMin,
      WeightMax: WeightMax ?? this.WeightMax,
    );
  }

  Map<String, Object?> toJson() {
    return {'WeightMin': WeightMin, 'WeightMax': WeightMax};
  }

  static WeightLimit fromJson(Map<String, Object?> json) {
    return WeightLimit(
      WeightMin: json['WeightMin'] == null ? null : json['WeightMin'] as String,
      WeightMax: json['WeightMax'] == null ? null : json['WeightMax'] as String,
    );
  }

  @override
  String toString() {
    return '''WeightLimit(
                WeightMin:$WeightMin,
WeightMax:$WeightMax
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is WeightLimit &&
        other.runtimeType == runtimeType &&
        other.WeightMin == WeightMin &&
        other.WeightMax == WeightMax;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, WeightMin, WeightMax);
  }
}
