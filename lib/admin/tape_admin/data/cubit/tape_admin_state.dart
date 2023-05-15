import '../model/TapeAdminModel.dart';

abstract class TapeAdminState {}

class InitState extends TapeAdminState {}

class LoadingState extends TapeAdminState {}

class NoDataState extends TapeAdminState {}

class LoadedState extends TapeAdminState {
  List<TapeAdminModel> tapeModel;
  LoadedState(this.tapeModel);
}

class ErrorState extends TapeAdminState {
  String message;
  ErrorState({required this.message});
}
