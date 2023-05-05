
abstract class SubsState {}

class InitState extends SubsState {}

class LoadingState extends SubsState {}

class LoadedState extends SubsState {}

class ErrorState extends SubsState {
  String message;
  ErrorState({required this.message});
}
