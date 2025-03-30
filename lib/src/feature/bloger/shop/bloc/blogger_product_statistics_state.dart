import '../data/models/blogger_product_statistics_model.dart';

abstract class BloggerProductStatisticsState {}

class InitState extends BloggerProductStatisticsState {}

class LoadingState extends BloggerProductStatisticsState {}

class LoadedState extends BloggerProductStatisticsState {
  BloggerProductStatisticsModel statistics;
  LoadedState(this.statistics);
}

class ErrorState extends BloggerProductStatisticsState {
  String message;
  ErrorState({required this.message});
}
