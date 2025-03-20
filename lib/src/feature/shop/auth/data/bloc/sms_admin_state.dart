abstract class SmsAdminState {}

class InitState extends SmsAdminState {}

class LoadingState extends SmsAdminState {}

class LoadedState extends SmsAdminState {}

class ResetSuccessState extends SmsAdminState {}

class ErrorState extends SmsAdminState {
  String message;

  ErrorState({required this.message});
}
