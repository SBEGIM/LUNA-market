class MessageDto {
  MessageDto({
    String? type,
    dynamic role,
    int? chatId,
    String? name,
    String? text,
    String? path,
    String? createdAt,
    int? userId,
    dynamic avatar,
  }) {
    _type = type;
    _role = role;
    _chatId = chatId;
    _name = name;
    _path = path;
    _text = text;
    _createdAt = createdAt;
    _userId = userId;
    _avatar = avatar;
  }

  MessageDto.fromJson(dynamic json) {
    _type = json['type'];
    _role = json['role'];
    _chatId = json['chat_id'];
    _name = json['name'];
    _text = json['text'];
    _path = json['path'];
    _createdAt = json['created_at'];
    _userId = json['user_id'];
    _avatar = json['avatar'];
  }
  String? _type;
  dynamic _role;
  int? _chatId;
  String? _name;
  String? _text;
  String? _path;
  String? _createdAt;
  int? _userId;
  dynamic _avatar;

  String? get type => _type;
  dynamic get role => _role;
  int? get chatId => _chatId;
  String? get name => _name;
  String? get text => _text;
  String? get path => _path;
  String? get createdAt => _createdAt;
  int? get userId => _userId;
  dynamic get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['role'] = _role;
    map['chat_id'] = _chatId;
    map['name'] = _name;
    map['text'] = _text;
    map['path'] = _path;
    map['created_at'] = _createdAt;
    map['user_id'] = _userId;
    map['avatar'] = _avatar;
    return map;
  }
}
