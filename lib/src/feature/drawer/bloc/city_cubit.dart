import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/drawer/data/repository/city_repo.dart';
import 'package:haji_market/src/feature/home/data/model/city_model.dart';

import 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  final CityRepository cityRepository;

  CityCubit({required this.cityRepository}) : super(InitState());
  List<CityModel> _cities = [];

  Future<void> cities() async {
    try {
      emit(LoadingState());
      final List<CityModel> data = await cityRepository.cityApi();
      _cities = data;

      if (_cities.length == 0) {
        emit(NodataState());
      } else {
        emit(LoadedState(data));
      }
    } catch (e) {
      log("---- ${e.toString()}");
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> citiesCdek(String? countryCode) async {
    try {
      emit(LoadingState());
      final List<CityModel> data =
          await cityRepository.cityCdekApi(countryCode);
      _cities = data;

      if (_cities.length == 0) {
        emit(NodataState());
      } else {
        emit(LoadedState(data));
      }
    } catch (e) {
      log("---!- ${e.toString()}");
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> searchCdekCity(String cats) async {
    if (cats.isEmpty) return;

    List<CityModel> temp = [];
    for (int i = 0; i < _cities.length; i++) {
      if (_cities[i].city != null &&
          _cities[i].city!.toLowerCase().contains(cats.toLowerCase())) {
        temp.add(_cities[i]);
      }
    }
    emit(LoadedState(temp));
  }

  cityById(String id) async {
    if (id.isEmpty) return;
    if (_cities.isEmpty) {
      await cities();
    }
    CityModel city = CityModel(id: 0, name: '');
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
