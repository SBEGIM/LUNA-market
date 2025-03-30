abstract class SmsSellerState {}

class InitState extends SmsSellerState {}

class LoadingState extends SmsSellerState {}

class LoadedState extends SmsSellerState {}

class ResetSuccessState extends SmsSellerState {}

class ErrorState extends SmsSellerState {
  String message;

  ErrorState({required this.message});
}
