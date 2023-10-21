class BloggerProductStatisticsModel {
  BloggerProductStatisticsModel({
    int? clickCount,
    int? favoriteCount,
    int? basketCount,
    int? buyCount,
    int? bonus,
    int? sumPrice,
  }) {
    _clickCount = clickCount;
    _favoriteCount = favoriteCount;
    _basketCount = basketCount;
    _buyCount = buyCount;
    _bonus = bonus;
    _sumPrice = sumPrice;
  }

  BloggerProductStatisticsModel.fromJson(dynamic json) {
    _clickCount = json['click_count'];
    _favoriteCount = json['favorite_count'];
    _basketCount = json['basket_count'];
    _buyCount = json['buy_count'];
    _bonus = json['bonus'];
    _sumPrice = json['sum_price'];
  }
  int? _clickCount;
  int? _favoriteCount;
  int? _basketCount;
  int? _buyCount;
  int? _bonus;
  int? _sumPrice;

  int? get clickCount => _clickCount;
  int? get favoriteCount => _favoriteCount;
  int? get basketCount => _basketCount;
  int? get buyCount => _buyCount;
  int? get bonus => _bonus;
  int? get sumPrice => _sumPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['click_count'] = _clickCount;
    map['favorite_count'] = _favoriteCount;
    map['basket_count'] = _basketCount;
    map['buy_count'] = _buyCount;
    map['bonus'] = _bonus;
    map['sum_price'] = _sumPrice;
    return map;
  }
}
