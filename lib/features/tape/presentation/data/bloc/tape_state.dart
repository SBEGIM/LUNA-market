import 'package:haji_market/features/tape/presentation/data/models/TapeModel.dart';

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
