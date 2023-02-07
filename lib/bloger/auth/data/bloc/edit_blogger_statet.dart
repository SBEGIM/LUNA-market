abstract class EditBloggerState {}

class InitState extends EditBloggerState {}

class LoadingState extends EditBloggerState {}

class LoadedState extends EditBloggerState {}

class ErrorState extends EditBloggerState {
  String message;

  ErrorState({required this.message}) : assert(message != null);
}
