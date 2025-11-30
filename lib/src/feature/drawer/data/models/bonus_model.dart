class BonusModel {
  BonusModel({int? id, String? name, String? logo, String? image, int? bonus}) {
    _id = id;
    _name = name;
    _logo = logo;
    _image = image;
    _bonus = bonus;
  }

  BonusModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _logo = json['logo'];
    _image = json['image'];
    _bonus = json['bonus'];
  }
  int? _id;
  String? _name;
  String? _logo;
  String? _image;
  int? _bonus;

  int? get id => _id;
  String? get name => _name;
  String? get logo => _logo;
  String? get image => _image;
  int? get bonus => _bonus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['logo'] = _logo;
    map['image'] = _image;
    map['bonus'] = _bonus;

    return map;
  }
}
