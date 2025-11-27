class PartnerModel {
  PartnerModel({int? id, String? name, String? url}) {
    _id = id;
    _name = name;
    _url = url;
  }

  PartnerModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _url = json['url'];
  }
  int? _id;
  String? _name;
  String? _url;

  int? get id => _id;
  String? get name => _name;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['url'] = _url;
    return map;
  }
}
