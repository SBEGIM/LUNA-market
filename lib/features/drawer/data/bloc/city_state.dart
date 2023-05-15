import '../../../home/data/model/Cats.dart';
import '../../../home/data/model/City.dart';

abstract class CityState {}

class InitState extends CityState {}

class LoadingState extends CityState {}

class NodataState extends CityState {}

class LoadedState extends CityState {
  List<City> city;
  LoadedState(this.city);
}

class ErrorState extends CityState {
  String message;
  ErrorState({required this.message});
}
