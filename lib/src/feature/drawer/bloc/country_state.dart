import '../../home/data/model/country_model.dart';

abstract class CountryState {}

class InitState extends CountryState {}

class LoadingState extends CountryState {}

class LoadedState extends CountryState {
  List<CountryModel> country;
  LoadedState(this.country);
}

class ErrorState extends CountryState {
  String message;
  ErrorState({required this.message});
}
