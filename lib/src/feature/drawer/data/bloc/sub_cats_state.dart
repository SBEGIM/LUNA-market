import '../../../home/data/model/cats.dart';

abstract class SubCatsState {}

class InitState extends SubCatsState {}

class LoadingState extends SubCatsState {}

class NoDataState extends SubCatsState {}

class LoadedState extends SubCatsState {
  List<CatsModel> cats;
  LoadedState(this.cats);
}

class ErrorState extends SubCatsState {
  String message;
  ErrorState({required this.message});
}
