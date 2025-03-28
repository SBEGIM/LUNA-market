import 'package:haji_market/src/feature/home/data/model/cat_model.dart';

abstract class ColorState {}

class InitState extends ColorState {}

class LoadingState extends ColorState {}

class LoadedState extends ColorState {
  List<CatsModel> cats;
  LoadedState(this.cats);
}

class ErrorState extends ColorState {
  String message;
  ErrorState({required this.message});
}
