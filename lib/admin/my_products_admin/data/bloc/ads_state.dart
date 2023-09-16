part of 'ads_cubit.dart';

abstract class AdsState {}

class InitState extends AdsState {}

class LoadingState extends AdsState {}

class LoadedState extends AdsState {
  List<AdDTO> ads;
  LoadedState(this.ads);
}

class ErrorState extends AdsState {
  String message;
  ErrorState({required this.message});
}
