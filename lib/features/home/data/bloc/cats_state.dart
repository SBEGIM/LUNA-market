

import 'package:untitled/data/model/City.dart';

abstract class CityState{}


class InitState extends CityState{}

class LoadingState extends CityState{}

class LoadedState extends CityState{
  List<City> cities;
  Set<String> citiesSet;
  String dropdownCity;
  LoadedState(this.cities , this.citiesSet , this.dropdownCity);
}

class ErrorState extends CityState{
  String message;

  ErrorState({required this.message}) : assert(message != null);

}

