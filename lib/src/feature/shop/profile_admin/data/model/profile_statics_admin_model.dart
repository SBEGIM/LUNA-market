class ProfileStaticsAdminModel {
  ProfileStaticsAdminModel({
    int? videoReview,
    int? subscribers,
    int? sales,
  }) {
    _videoReview = videoReview;
    _subscribers = subscribers;
    _sales = sales;
  }

  ProfileStaticsAdminModel.fromJson(dynamic json) {
    _videoReview = json['video_review'];
    _subscribers = json['subscribers'];
    _sales = json['sales'];
  }
  int? _videoReview;
  int? _subscribers;
  int? _sales;

  int? get videoReview => _videoReview;
  int? get subscribers => _subscribers;
  int? get sales => _sales;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['video_review'] = _videoReview;
    map['subscribers'] = _subscribers;
    map['sales'] = _sales;
    return map;
  }
}
