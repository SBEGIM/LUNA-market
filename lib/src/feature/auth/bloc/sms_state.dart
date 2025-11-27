abstract class SmsState {}

class InitState extends SmsState {}

class LoadingState extends SmsState {}

class LoadedState extends SmsState {}

class ResetSuccessState extends SmsState {}

class ErrorState extends SmsState {
  String message;

  ErrorState({required this.message});
}
