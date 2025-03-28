part of 'tape_check_cubit.dart';


class TapeCheckState {}
class InitState extends TapeCheckState {}

class LoadingState extends TapeCheckState {}

class LoadedState extends TapeCheckState {
  final TapeCheckModel tapeCheckModel;

  LoadedState(this.tapeCheckModel);
}

class ErrorState extends TapeCheckState {
  String message;
  ErrorState({required this.message});
}
