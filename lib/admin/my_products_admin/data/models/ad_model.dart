class AdDTO {
  AdDTO({
    int? price,
    int? viewCount,
  }) {
    _price = price;
    _viewCount = viewCount;
  }

  AdDTO.fromJson(dynamic json) {
    _price = json['price'];
    _viewCount = json['view_count'];
  }

  int? _price;
  int? _viewCount;

  int? get price => _price;
  int? get viewCount => _viewCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = _price;
    map['view_count'] = _viewCount;
    return map;
  }
}
