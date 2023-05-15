import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/features/drawer/data/bloc/country_state.dart';
import 'package:haji_market/features/drawer/data/repository/CityRepo.dart';

import '../../../home/data/model/Country.dart';
import '../repository/CountryRepo.dart';

class CountryCubit extends Cubit<CountryState> {
  final CountryRepository countryRepository;

  CountryCubit({required this.countryRepository}) : super(InitState());
  List<Country> _cities = [];

  Future<void> country() async {
    try {
      emit(LoadingState());
      final List<Country> data = await countryRepository.countryApi();
      _cities = data;
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  cityById(String id) async {
    if (id.isEmpty) return;
    if (_cities.isEmpty) {
      await country();
    }
    Country city = Country(id: 0, name: '');
    for (int i = 0; i < _cities.length; i++) {
      if (_cities[i].id.toString() == id) {
        city = _cities[i];
      }
    }

    return city;
  }

  // Future<void> searchCity(String city) async {
  //   if(city.isEmpty) return;
  //   if(_cities.isEmpty) {
  //     await cities();
  //     // final List<City> data = await listRepository.cities();
  //     // _cities = data;
  //   }
  //   List<City> temp = [];
  //   Set<String> citiesSet = {};
  //   for(int i = 0 ; i < _cities.length; i++) {
  //     if(_cities[i].name != null && _cities[i].name!.contains(city)) {
  //       temp.add(_cities[i]);
  //       citiesSet.add(_cities[i].name.toString());
  //     }
  //   }
  //   emit(LoadedState(temp, citiesSet, ''));
  // }
}
