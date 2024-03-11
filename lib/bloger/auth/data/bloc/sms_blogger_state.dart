abstract class SmsBloggerState {}

class InitState extends SmsBloggerState {}

class LoadingState extends SmsBloggerState {}

class LoadedState extends SmsBloggerState {}

class ResetSuccessState extends SmsBloggerState {}

class ErrorState extends SmsBloggerState {
  String message;

  ErrorState({required this.message});
}
