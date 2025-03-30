class StatisticProductSellerModel {
  StatisticProductSellerModel({
    int? count_click,
    int? count_favorite,
    int? count_basket,
    int? count_buy,
  }) {
    _count_click = count_click;
    _count_favorite = count_favorite;
    _count_basket = count_basket;
    _count_buy = count_buy;
  }

  StatisticProductSellerModel.fromJson(dynamic json) {
    _count_click = json['count_click'];
    _count_favorite = json['count_favorite'];
    _count_basket = json['count_basket'];
    _count_buy = json['count_buy'];
  }
  int? _count_click;
  int? _count_favorite;
  int? _count_basket;
  int? _count_buy;

  int? get count_click => _count_click;
  int? get count_favorite => _count_favorite;
  int? get count_basket => _count_basket;
  int? get count_buy => _count_buy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count_click'] = _count_click;
    map['count_favorite'] = _count_favorite;
    map['count_basket'] = _count_basket;
    map['count_buy'] = _count_buy;
    return map;
  }
}
