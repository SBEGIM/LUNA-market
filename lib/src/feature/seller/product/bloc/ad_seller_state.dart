part of 'ad_seller_cubit.dart';

abstract class AdSellerState {}

class InitState extends AdSellerState {}

class LoadingState extends AdSellerState {}

class LoadedState extends AdSellerState {
  List<AdSellerDto> ads;
  LoadedState(this.ads);
}

class ErrorState extends AdSellerState {
  String message;
  ErrorState({required this.message});
}
