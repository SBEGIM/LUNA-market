import 'package:haji_market/src/feature/tape/data/models/tape_model.dart';

abstract class TapeState {}

class InitState extends TapeState {}

class LoadingState extends TapeState {}

class NoDataState extends TapeState {}

class LoadedState extends TapeState {
  List<TapeModel> tapeModel;
  LoadedState(this.tapeModel);
}

class BloggerLoadedState extends TapeState {
  List<TapeModel> tapeModel;
  BloggerLoadedState(this.tapeModel);
}

class ErrorState extends TapeState {
  String message;
  ErrorState({required this.message});
}
