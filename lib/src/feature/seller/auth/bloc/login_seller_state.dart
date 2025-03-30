abstract class LoginSellerState {}

class InitState extends LoginSellerState {}

class LoadingState extends LoginSellerState {}

class LoadedState extends LoginSellerState {}

class ErrorState extends LoginSellerState {
  String message;

  ErrorState({required this.message});
}
