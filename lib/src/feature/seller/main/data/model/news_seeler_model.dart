class NewsSeelerModel {
  NewsSeelerModel({
    int? id,
    String? title,
    String? description,
    String? image,
    int? views,
    int? like,
    bool? isLiked,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _title = title;
    _description = description;
    _image = image;
    _views = views;
    _like = like;
    _isLiked = isLiked;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }
  NewsSeelerModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _views = json['views'];
    _like = json['like'];
    _isLiked = json['is_liked'] ?? false;
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _title;
  String? _description;
  int? _views;
  int? _like;
  bool? _isLiked;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  int? get views => _views;
  int? get like => _like;
  bool? get isLiked => _isLiked ?? false;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['like'] = _like;
    map['views'] = _views;
    map['is_liked'] = _isLiked;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

  NewsSeelerModel copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
    int? views,
    int? like,
    bool? isLiked,
    String? createdAt,
    String? updatedAt,
  }) {
    return NewsSeelerModel(
      id: id ?? _id,
      title: title ?? _title,
      description: description ?? _description,
      image: image ?? _image,
      views: views ?? _views,
      like: like ?? _like,
      isLiked: isLiked ?? _isLiked,
      createdAt: createdAt ?? _createdAt,
      updatedAt: updatedAt ?? _updatedAt,
    );
  }
}
