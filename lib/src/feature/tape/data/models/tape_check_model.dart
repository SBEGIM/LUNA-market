class TapeCheckModel {
  TapeCheckModel({
    bool? inBasket,
    bool? inSubs,
  }) {
    _inBasket = inBasket;
    _inSubs = inSubs;
  }

  TapeCheckModel.fromJson(dynamic json) {
    _inBasket = json['in_basket'];
    _inSubs = json['in_subscribe'];
  }
  bool? _inBasket;
  bool? _inSubs;

  bool? get inBasket => _inBasket;
  bool? get inSubs => _inSubs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['in_basket'] = _inBasket;
    map['in_subscribe'] = _inSubs;
    return map;
  }
}
