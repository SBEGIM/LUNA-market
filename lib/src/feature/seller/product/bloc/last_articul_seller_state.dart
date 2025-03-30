part of 'last_articul_seller_cubit.dart';

abstract class LastArticulSellerState {}

class InitState extends LastArticulSellerState {}

class LoadingState extends LastArticulSellerState {}

class LoadedState extends LastArticulSellerState {
  int articul;
  LoadedState(this.articul);
}

class ErrorState extends LastArticulSellerState {
  String message;
  ErrorState({required this.message});
}
