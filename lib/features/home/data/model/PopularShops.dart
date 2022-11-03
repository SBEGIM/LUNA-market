class PopularShops {
  PopularShops({
      int? name, 
      dynamic logo, 
      String? image, 
      bool? bonus, 
      bool? credit,}){
    _name = name;
    _logo = logo;
    _image = image;
    _bonus = bonus;
    _credit = credit;
}

  PopularShops.fromJson(dynamic json) {
    _name = json['name'];
    _logo = json['logo'];
    _image = json['image'];
    _bonus = json['bonus'];
    _credit = json['credit'];
  }
  int? _name;
  dynamic _logo;
  String? _image;
  bool? _bonus;
  bool? _credit;

  int? get name => _name;
  dynamic get logo => _logo;
  String? get image => _image;
  bool? get bonus => _bonus;
  bool? get credit => _credit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['logo'] = _logo;
    map['image'] = _image;
    map['bonus'] = _bonus;
    map['credit'] = _credit;
    return map;
  }

}