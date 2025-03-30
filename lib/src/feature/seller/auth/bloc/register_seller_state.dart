abstract class RegisterSellerState {}

class InitState extends RegisterSellerState {}

class LoadingState extends RegisterSellerState {}

class LoadedState extends RegisterSellerState {}

class ErrorState extends RegisterSellerState {
  String message;

  ErrorState({required this.message});
}
