abstract class LoginAdminState {}

class InitState extends LoginAdminState {}

class LoadingState extends LoginAdminState {}

class LoadedState extends LoginAdminState {}

class ErrorState extends LoginAdminState {
  String message;

  ErrorState({required this.message}) : assert(message != null);
}
