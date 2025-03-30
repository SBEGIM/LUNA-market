import 'package:haji_market/src/feature/home/data/model/cat_model.dart';

abstract class ColorSellerState {}

class InitState extends ColorSellerState {}

class LoadingState extends ColorSellerState {}

class LoadedState extends ColorSellerState {
  List<CatsModel> cats;
  LoadedState(this.cats);
}

class ErrorState extends ColorSellerState {
  String message;
  ErrorState({required this.message});
}
