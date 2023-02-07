import 'package:haji_market/features/home/data/model/Cats.dart';

abstract class ColorState {}

class InitState extends ColorState {}

class LoadingState extends ColorState {}

class LoadedState extends ColorState {
  List<Cats> cats;
  LoadedState(this.cats);
}

class ErrorState extends ColorState {
  String message;
  ErrorState({required this.message}) : assert(message != null);
}
