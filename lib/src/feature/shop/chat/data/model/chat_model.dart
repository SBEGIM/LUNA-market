class ChatAdminModel {
  ChatAdminModel({
    int? chatId,
    int? userId,
    String? name,
    dynamic avatar,
    String? createdAt,
    String? updatedAt,
    int? countNewMessages,
    LastMessage? lastMessage,
  }) {
    _chatId = chatId;
    _userId = userId;
    _name = name;
    _avatar = avatar;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _countNewMessages = countNewMessages;
    _lastMessage = lastMessage;
  }

  ChatAdminModel.fromJson(dynamic json) {
    _chatId = json['chat_id'];
    _userId = json['user_id'];
    _name = json['name'];
    _avatar = json['avatar'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _countNewMessages = json['count_new_messages'];
    _lastMessage = json['last_message'] != null
        ? LastMessage.fromJson(json['last_message'] as Map<String, dynamic>)
        : null;
  }
  int? _chatId;
  int? _userId;
  String? _name;
  dynamic _avatar;
  String? _createdAt;
  String? _updatedAt;
  int? _countNewMessages;
  LastMessage? _lastMessage;

  int? get chatId => _chatId;
  int? get userId => _userId;
  String? get name => _name;
  dynamic get avatar => _avatar;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get countNewMessages => _countNewMessages;
  LastMessage? get lastMessage => _lastMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chat_id'] = _chatId;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['avatar'] = _avatar;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['count_new_messages'] = _countNewMessages;
    if (_lastMessage != null) {
      map['last_message'] = _lastMessage?.toJson();
    }
    return map;
  }
}

class LastMessage {
  LastMessage({
    int? id,
    String? type,
    int? read,
    String? text,
    String? date,
  }) {
    _id = id;
    _type = type;
    _read = read;
    _text = text;
    _date = date;
  }

  LastMessage.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _read = json['read'];
    _text = json['text'];
    _date = json['date'];
  }
  int? _id;
  String? _type;
  int? _read;
  String? _text;
  String? _date;

  int? get id => _id;
  String? get type => _type;
  int? get read => _read;
  String? get text => _text;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['read'] = _read;
    map['text'] = _text;
    map['date'] = _date;
    return map;
  }
}
