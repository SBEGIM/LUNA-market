class NewsSeelerModel {
  NewsSeelerModel({
    int? id,
    String? title,
    String? description,
    String? image,
    int? view,
    int? like,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _title = title;
    _description = description;
    _image = image;
    _view = view;
    _like = like;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }
  NewsSeelerModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _view = json['view'];
    _like = json['like'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _title;
  String? _description;
  int? _view;
  int? _like;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  int? get view => _view;
  int? get like => _like;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['like'] = _like;
    map['view'] = _view;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
