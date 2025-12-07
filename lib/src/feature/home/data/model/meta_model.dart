// ignore_for_file: non_constant_identifier_names

class MetaModel {
  MetaModel({
    int? id,
    String? terms_of_use,
    String? privacy_policy,
    String? contract_offer,
    String? return_warranty,
    String? shipping_payment,
    String? TTN,
    String? type,
    String? urlLink,
  }) {
    _id = id;
    _terms_of_use = terms_of_use;
    _privacy_policy = privacy_policy;
    _contract_offer = contract_offer;
    _return_warranty = return_warranty;
    _shipping_payment = shipping_payment;
    _TTN = TTN;
    _type = type;
    _urlLink = urlLink;
  }

  MetaModel.fromJson(dynamic json) {
    _id = json['id'];
    _terms_of_use = json['terms_of_use'];
    _privacy_policy = json['privacy_policy'];
    _contract_offer = json['contract_offer'];
    _return_warranty = json['return_warranty'];
    _shipping_payment = json['shipping_payment'];
    _TTN = json['TTH'];
    _type = json['type'];
    _urlLink = json['url_link'];
  }
  int? _id;
  String? _terms_of_use;
  String? _privacy_policy;
  String? _contract_offer;
  String? _return_warranty;
  String? _shipping_payment;
  String? _TTN;
  String? _type;
  String? _urlLink;

  int? get id => _id;
  String? get terms_of_use => _terms_of_use;
  String? get privacy_policy => _privacy_policy;
  String? get contract_offer => _contract_offer;
  String? get return_warranty => _return_warranty;
  String? get shipping_payment => _shipping_payment;
  String? get type => _type;
  String? get TTN => _TTN;
  String? get urlLink => _urlLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['terms_of_use'] = _terms_of_use;
    map['privacy_policy'] = _privacy_policy;
    map['contract_offer'] = _contract_offer;
    map['return_warranty'] = _return_warranty;
    map['shipping_payment'] = _shipping_payment;
    map['type'] = _type;
    map['TTN'] = _TTN;
    map['urlLink'] = _urlLink;

    return map;
  }
}
