part of 'order_status_seller_cubit.dart';

abstract class OrderStatusSellerState {}

class InitState extends OrderStatusSellerState {}

class LoadingState extends OrderStatusSellerState {}

class LoadedState extends OrderStatusSellerState {
  // List<BasketAdminOrderModel> basketOrderModel;
  // LoadedState(this.basketOrderModel);
}

class CancelState extends OrderStatusSellerState {}

class ReturnState extends OrderStatusSellerState {}

class ErrorState extends OrderStatusSellerState {
  String message;
  ErrorState({required this.message});
}
