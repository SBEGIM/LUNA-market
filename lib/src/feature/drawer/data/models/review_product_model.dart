class ReviewProductModel {
  ReviewProductModel(
      {int? id,
      User? user,
      dynamic plus,
      dynamic minus,
      dynamic text,
      int? rating,
      dynamic date,
      List<String>? images}) {
    _id = id;
    _user = user;
    _plus = plus;
    _minus = minus;
    _text = text;
    _rating = rating;
    _date = date;
    _images = images;
  }

  ReviewProductModel.fromJson(dynamic json) {
    _id = json['id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _plus = json['plus'];
    _minus = json['minus'];
    _text = json['text'];
    _rating = json['rating'];
    _date = json['date'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  int? _id;
  User? _user;
  dynamic _plus;
  dynamic _minus;
  dynamic _text;
  int? _rating;
  dynamic _date;
  List<String>? _images;

  int? get id => _id;
  User? get user => _user;
  dynamic get plus => _plus;
  dynamic get minus => _minus;
  dynamic get text => _text;
  int? get rating => _rating;
  dynamic get date => _date;
  List<String>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['plus'] = _plus;
    map['minus'] = _minus;
    map['text'] = _text;
    map['rating'] = _rating;
    map['date'] = _date;
    map['images'] = _images;
    return map;
  }
}

class User {
  User({
    String? first_name,
    String? last_name,
    dynamic avatar,
  }) {
    _first_name = first_name;
    _last_name = last_name;
    _avatar = avatar;
  }

  User.fromJson(dynamic json) {
    _first_name = json['first_name'] ?? '';
    _last_name = json['last_name'] ?? '';

    _avatar = json['avatar'];
  }
  String? _first_name;
  String? _last_name;

  dynamic _avatar;

  String? get first_name => _first_name;
  String? get last_name => _last_name;
  dynamic get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = first_name;
    map['last_name'] = _last_name;

    map['avatar'] = _avatar;
    return map;
  }
}

class Images {
  Images({
    String? image,
  }) {
    _image = image;
  }

  Images.fromJson(dynamic json) {
    _image = json['image'] ?? '';
  }
  String? _image;

  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = image;
    return map;
  }
}
