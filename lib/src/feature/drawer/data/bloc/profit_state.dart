abstract class ProfitState {}

class InitState extends ProfitState {}

class LoadingState extends ProfitState {}

class NoDataState extends ProfitState {}

class LoadedState extends ProfitState {
  String path;
  LoadedState({required this.path});
}

class ErrorState extends ProfitState {
  String message;
  ErrorState({required this.message});
}
