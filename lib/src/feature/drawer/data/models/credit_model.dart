class CreditModel {
  CreditModel({int? id, String? title, String? description, String? url}) {
    _id = id;
    _title = title;
    _description = description;
    _url = url;
  }

  CreditModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _url = json['url'];
  }
  int? _id;
  String? _title;
  String? _description;
  String? _url;

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['url'] = _url;
    return map;
  }
}
