import 'package:haji_market/src/feature/seller/main/data/model/news_seeler_model.dart';

abstract class NewsSellerState {}

class InitState extends NewsSellerState {}

class LoadingState extends NewsSellerState {}

class LoadedState extends NewsSellerState {
  List<NewsSeelerModel> newsSeelerModel;

  LoadedState({required this.newsSeelerModel});
}

class ErrorState extends NewsSellerState {
  String message;

  ErrorState({required this.message});
}
