import 'package:haji_market/src/feature/seller/main/data/model/notification_seller_model.dart';

abstract class SellerNotificationState {}

class InitState extends SellerNotificationState {}

class LoadingState extends SellerNotificationState {}

class LoadedState extends SellerNotificationState {
  List<NotificationSellerModel> notifications;
  LoadedState(this.notifications);
}

class ErrorState extends SellerNotificationState {
  String message;
  ErrorState({required this.message});
}
