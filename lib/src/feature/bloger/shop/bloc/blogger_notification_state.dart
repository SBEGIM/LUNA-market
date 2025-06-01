import 'package:haji_market/src/feature/bloger/shop/data/models/blogger_notification_model.dart';

abstract class BloggerNotificationState {}

class InitState extends BloggerNotificationState {}

class LoadingState extends BloggerNotificationState {}

class LoadedState extends BloggerNotificationState {
  List<BloggerNotificationModel> notifications;
  LoadedState(this.notifications);
}

class ErrorState extends BloggerNotificationState {
  String message;
  ErrorState({required this.message});
}
