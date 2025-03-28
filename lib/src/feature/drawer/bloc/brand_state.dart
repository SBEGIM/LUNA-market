import '../../home/data/model/cat_model.dart';

abstract class BrandState {}

class InitState extends BrandState {}

class LoadingState extends BrandState {}

class NoDataState extends BrandState {}

class LoadedState extends BrandState {
  List<CatsModel> cats;
  LoadedState(this.cats);
}

class ErrorState extends BrandState {
  String message;
  ErrorState({required this.message});
}
