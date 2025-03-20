import '../data/model/popular_shops_model.dart';

abstract class PopularShopsState {}

class InitState extends PopularShopsState {}

class LoadingState extends PopularShopsState {}

class LoadedState extends PopularShopsState {
  List<PopularShops> popularShops;
  LoadedState(this.popularShops);
}

class ErrorState extends PopularShopsState {
  String message;
  ErrorState({required this.message});
}
