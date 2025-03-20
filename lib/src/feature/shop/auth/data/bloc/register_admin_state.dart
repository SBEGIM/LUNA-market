abstract class RegisterAdminState {}

class InitState extends RegisterAdminState {}

class LoadingState extends RegisterAdminState {}

class LoadedState extends RegisterAdminState {}

class ErrorState extends RegisterAdminState {
  String message;

  ErrorState({required this.message});
}
