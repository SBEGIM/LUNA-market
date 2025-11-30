class ProfileStaticsAdminModel {
  ProfileStaticsAdminModel({
    int? videoReview,
    int? subscribers,
    int? sales,
    int? productCount,
    int? salesSum,
  }) {
    _videoReview = videoReview;
    _subscribers = subscribers;
    _sales = sales;
    _salesSum = salesSum;
    _productCount = productCount;
  }

  ProfileStaticsAdminModel.fromJson(dynamic json) {
    _videoReview = json['video_review'];
    _subscribers = json['subscribers'];
    _sales = json['sales'];
    _salesSum = json['sales_sum'];
    _productCount = json['product_count'];
  }
  int? _videoReview;
  int? _subscribers;
  int? _sales;
  int? _productCount;
  int? _salesSum;

  int? get videoReview => _videoReview;
  int? get subscribers => _subscribers;
  int? get sales => _sales;
  int? get salesSum => _salesSum;
  int? get productCount => _productCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['video_review'] = _videoReview;
    map['subscribers'] = _subscribers;
    map['sales'] = _sales;
    map['sales_sum'] = _salesSum;
    map['product_count'] = _productCount;
    return map;
  }
}
