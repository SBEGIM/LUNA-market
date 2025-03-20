import '../data/model/cats.dart';

abstract class CatsState {}

class InitState extends CatsState {}

class LoadingState extends CatsState {}

class LoadedState extends CatsState {
  List<CatsModel> cats;
  LoadedState(this.cats);
}

class ErrorState extends CatsState {
  String message;
  ErrorState({required this.message});
}
