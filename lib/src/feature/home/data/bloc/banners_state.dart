import '../model/banners.dart';

abstract class BannersState {}

class InitState extends BannersState {}

class LoadingState extends BannersState {}

class LoadedState extends BannersState {
  List<Banners> banners;
  LoadedState(this.banners);
}

class ErrorState extends BannersState {
  String message;
  ErrorState({required this.message});
}
