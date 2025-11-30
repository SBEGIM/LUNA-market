abstract class RegisterState {}

class InitState extends RegisterState {}

class LoadingState extends RegisterState {}

class LoadedState extends RegisterState {}

class ErrorState extends RegisterState {
  String message;

  ErrorState({required this.message});
}
