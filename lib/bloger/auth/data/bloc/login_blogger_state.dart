abstract class LoginBloggerState {}

class InitState extends LoginBloggerState {}

class LoadingState extends LoginBloggerState {}

class LoadedState extends LoginBloggerState {}

class ErrorState extends LoginBloggerState {
  String message;

  ErrorState({required this.message}) : assert(message != null);
}
