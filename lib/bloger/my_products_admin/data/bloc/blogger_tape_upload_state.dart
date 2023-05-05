import '../models/blogger_product_statistics_model.dart';

abstract class BloggerTapeUploadState {}

class InitState extends BloggerTapeUploadState {}

class LoadingState extends BloggerTapeUploadState {}

class LoadedState extends BloggerTapeUploadState {
  BloggerProductStatisticsModel statistics;
  LoadedState(this.statistics);
}

class ErrorState extends BloggerTapeUploadState {
  String message;
  ErrorState({required this.message});
}
