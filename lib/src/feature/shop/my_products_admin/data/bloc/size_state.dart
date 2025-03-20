import 'package:haji_market/src/feature/home/data/model/cats.dart';

abstract class SizeState {}

class InitState extends SizeState {}

class LoadingState extends SizeState {}

class LoadedState extends SizeState {
  List<CatsModel> cats;
  LoadedState(this.cats);
}

class ErrorState extends SizeState {
  String message;
  ErrorState({required this.message});
}
