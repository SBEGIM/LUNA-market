class CharacteristicsModel {
  CharacteristicsModel({int? id, int? mainId, String? key, String? value}) {
    _id = id;
    _mainId = mainId;
    _key = key;
    _value = value;
  }

  CharacteristicsModel.fromJson(dynamic json) {
    _id = json['id'];
    _mainId = json['characteristic_values'];
    _key = json['key'];
    _value = json['value'];
  }
  int? _id;
  int? _mainId;
  String? _key;
  String? _value;

  int? get id => _id;
  int? get mainId => _mainId;
  String? get key => _key;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['main_id'] = _mainId;
    map['key'] = _key;
    map['value'] = _value;

    return map;
  }
}
