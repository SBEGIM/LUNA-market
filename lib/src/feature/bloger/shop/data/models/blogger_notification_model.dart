class BloggerNotificationModel {
  BloggerNotificationModel({
    int? id,
    int? userId,
    String? notificationable,
    String? type,
    String? title,
    String? description,
    String? created_at,
  }) {
    _id = id;
    _userId = userId;
    _notificationable = notificationable;
    _type = type;
    _title = title;
    _description = description;
    _created_at = created_at;
  }

  BloggerNotificationModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _notificationable = json['notificationable'];
    _type = json['type'];
    _title = json['title'];
    _description = json['description'];
    _created_at = json['created_at'];
  }

  int? _id;
  int? _userId;
  String? _notificationable;
  String? _type;
  String? _title;
  String? _description;
  String? _created_at;

  int? get id => _id;
  int? get userId => _userId;
  String? get notificationable => _notificationable;
  String? get type => _type;
  String? get title => _title;
  String? get description => _description;
  String? get created_at => _created_at;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['notificationable'] = _notificationable;
    map['type'] = _type;
    map['title'] = _title;
    map['description'] = _description;
    map['created_at'] = _created_at;
    return map;
  }
}
