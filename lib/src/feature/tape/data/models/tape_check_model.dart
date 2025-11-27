class TapeCheckModel {
  TapeCheckModel({bool? inBasket, bool? inSubs, bool? inFavorite, bool? isLiked}) {
    _inBasket = inBasket;
    _inSubs = inSubs;
    _inFavorite = inFavorite;
    _isLiked = isLiked;
  }

  TapeCheckModel.fromJson(dynamic json) {
    _inBasket = json['in_basket'];
    _inSubs = json['in_subscribe'];
    _inFavorite = json['in_favorite'];
    _isLiked = json['is_liked'];
  }
  bool? _inBasket;
  bool? _inSubs;
  bool? _inFavorite;
  bool? _isLiked;

  bool? get inBasket => _inBasket;
  bool? get inSubs => _inSubs;
  bool? get inFavorite => _inFavorite;
  bool? get isLiked => _isLiked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['in_basket'] = _inBasket;
    map['in_subscribe'] = _inSubs;
    map['in_favorite'] = _inFavorite;
    map['is_liked'] = _isLiked;
    return map;
  }
}
