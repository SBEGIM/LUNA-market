import 'package:flutter/material.dart';

class NotificationSellerModel {
  NotificationSellerModel({
    int? id,
    int? userId,
    String? notificationable,
    String? type,
    String? title,
    String? description,
    String? created_at,
    bool isRead = false,
    IconData? icon, // ✅ Добавлено поле
  }) {
    _id = id;
    _userId = userId;
    _notificationable = notificationable;
    _type = type;
    _title = title;
    _description = description;
    _created_at = created_at;
    _isRead = isRead;
    _icon = icon; // ✅ Установка
  }

  NotificationSellerModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _notificationable = json['notificationable'];
    _type = json['type'];
    _title = json['title'];
    _description = json['description'];
    _created_at = json['created_at'];
    _isRead = json['read'] ?? false;
    // ⚠️ icon из JSON не загружается, т.к. IconData нельзя сериализовать напрямую
    _icon = null;
  }

  int? _id;
  int? _userId;
  String? _notificationable;
  String? _type;
  String? _title;
  String? _description;
  String? _created_at;
  bool _isRead = false;
  IconData? _icon; // ✅ Приватное поле

  // Геттеры
  int? get id => _id;
  int? get userId => _userId;
  String? get notificationable => _notificationable;
  String? get type => _type;
  String? get title => _title;
  String? get description => _description;
  String? get created_at => _created_at;
  bool get isRead => _isRead;
  IconData? get icon => _icon; // ✅ Геттер

  // Копирование
  NotificationSellerModel copyWith({
    int? id,
    int? userId,
    String? notificationable,
    String? type,
    String? title,
    String? description,
    String? created_at,
    bool? isRead,
    IconData? icon, // ✅ Добавлено
  }) {
    return NotificationSellerModel(
      id: id ?? _id,
      userId: userId ?? _userId,
      notificationable: notificationable ?? _notificationable,
      type: type ?? _type,
      title: title ?? _title,
      description: description ?? _description,
      created_at: created_at ?? _created_at,
      isRead: isRead ?? _isRead,
      icon: icon ?? _icon, // ✅ Установка
    );
  }

  // Сериализация
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['notificationable'] = _notificationable;
    map['type'] = _type;
    map['title'] = _title;
    map['description'] = _description;
    map['created_at'] = _created_at;
    map['is_read'] = _isRead;
    // ⚠️ icon не сериализуется, так как IconData нельзя напрямую сохранить в JSON
    return map;
  }
}
