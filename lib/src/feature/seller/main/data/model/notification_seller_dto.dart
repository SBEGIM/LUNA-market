// notification_ui_model.dart
import 'package:flutter/material.dart';

class NotificationUiModel {
  final int id;
  final String title;
  final String message;
  final IconData icon;
  final bool isRead;

  NotificationUiModel({
    required this.id,
    required this.title,
    required this.message,
    required this.icon,
    required this.isRead,
  });

  NotificationUiModel copyWith({
    int? id,
    String? title,
    String? message,
    IconData? icon,
    bool? isRead,
  }) {
    return NotificationUiModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      icon: icon ?? this.icon,
      isRead: isRead ?? this.isRead,
    );
  }
}
