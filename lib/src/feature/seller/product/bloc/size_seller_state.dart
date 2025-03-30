import 'package:haji_market/src/feature/home/data/model/cat_model.dart';

abstract class SizeSellerState {}

class InitState extends SizeSellerState {}

class LoadingState extends SizeSellerState {}

class LoadedState extends SizeSellerState {
  List<CatsModel> cats;
  LoadedState(this.cats);
}

class ErrorState extends SizeSellerState {
  String message;
  ErrorState({required this.message});
}
