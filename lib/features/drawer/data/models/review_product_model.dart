class ReviewProductModel {
  ReviewProductModel({
      int? id, 
      User? user, 
      dynamic plus, 
      dynamic minus, 
      dynamic text, 
      int? rating, 
      dynamic date,}){
    _id = id;
    _user = user;
    _plus = plus;
    _minus = minus;
    _text = text;
    _rating = rating;
    _date = date;
}

  ReviewProductModel.fromJson(dynamic json) {
    _id = json['id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _plus = json['plus'];
    _minus = json['minus'];
    _text = json['text'];
    _rating = json['rating'];
    _date = json['date'];
  }
  int? _id;
  User? _user;
  dynamic _plus;
  dynamic _minus;
  dynamic _text;
  int? _rating;
  dynamic _date;

  int? get id => _id;
  User? get user => _user;
  dynamic get plus => _plus;
  dynamic get minus => _minus;
  dynamic get text => _text;
  int? get rating => _rating;
  dynamic get date => _date;

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
    return map;
  }

}

class User {
  User({
      String? name, 
      dynamic avatar,}){
    _name = name;
    _avatar = avatar;
}

  User.fromJson(dynamic json) {
    _name = json['name'];
    _avatar = json['avatar'];
  }
  String? _name;
  dynamic _avatar;

  String? get name => _name;
  dynamic get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['avatar'] = _avatar;
    return map;
  }

}