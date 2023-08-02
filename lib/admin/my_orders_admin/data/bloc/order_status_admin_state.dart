part of 'order_status_admin_cubit.dart';

abstract class OrderStatusAdminState{}

class InitState extends OrderStatusAdminState {}

class LoadingState extends OrderStatusAdminState {}

class LoadedState extends OrderStatusAdminState {
  // List<BasketAdminOrderModel> basketOrderModel;
  // LoadedState(this.basketOrderModel);
}

class ErrorState extends OrderStatusAdminState {
  String message;
  ErrorState({required this.message});
}
