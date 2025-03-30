import '../data/model/tape_blogger_model.dart';

abstract class TapeBloggerState {}

class InitState extends TapeBloggerState {}

class LoadingState extends TapeBloggerState {}

class NoDataState extends TapeBloggerState {}

class LoadedState extends TapeBloggerState {
  List<TapeBloggerModel> tapeModel;
  LoadedState(this.tapeModel);
}

class ErrorState extends TapeBloggerState {
  String message;
  ErrorState({required this.message});
}
