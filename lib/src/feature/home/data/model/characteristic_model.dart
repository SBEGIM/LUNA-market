class CharacteristicsModel {
  CharacteristicsModel({
    int? id,
    String? key,
    String? value,
  }) {
    _id = id;
    _key = key;
    _value = value;
  }

  CharacteristicsModel.fromJson(dynamic json) {
    _id = json['id'];
    _key = json['key'];
    _value = json['value'];
  }
  int? _id;
  String? _key;
  String? _value;

  int? get id => _id;
  String? get key => _key;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['key'] = _key;
    map['value'] = _value;

    return map;
  }
}
