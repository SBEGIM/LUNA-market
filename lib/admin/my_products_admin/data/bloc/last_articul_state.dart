part of 'last_articul_cubit.dart';

abstract class LastArticulState {}

class InitState extends LastArticulState {}

class LoadingState extends LastArticulState {}

class LoadedState extends LastArticulState {
  int articul;
  LoadedState(this.articul);
}

class ErrorState extends LastArticulState {
  String message;
  ErrorState({required this.message});
}
