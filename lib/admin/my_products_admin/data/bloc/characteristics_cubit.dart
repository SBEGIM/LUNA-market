import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/admin/my_products_admin/data/bloc/characteristics_state.dart';
import '../../../../features/home/data/model/Characteristics.dart';
import '../repository/CharacteristicAdminRepo.dart';

class CharacteristicsCubit extends Cubit<CharacteristicsState> {
  final CharacteristicAdminRepo characteristicRepository;

  CharacteristicsCubit({required this.characteristicRepository}) : super(InitState());

  List<Characteristics> _characteristics = [];

  Future<List<Characteristics>?> characteristic() async {
    try {
      emit(LoadingState());
      final List<Characteristics> data = await characteristicRepository.get();
      _characteristics = data;
      emit(LoadedState(data));
      return _characteristics;
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
    return null;
  }

  Future<List<Characteristics>?> subCharacteristic({id}) async {
    try {
      emit(LoadingState());
      final List<Characteristics> data = await characteristicRepository.subGet(id);
      _characteristics = data;
      emit(LoadedState(data));
      return _characteristics;
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
    return null;
  }

  ColorById(
    String name,
  ) async {
    if (name.isEmpty) return;
    if (_characteristics.isEmpty) {
      await characteristic();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    Characteristics color = Characteristics(id: 0, key: 'Выберите характеристику');
    for (int i = 0; i < _characteristics.length; i++) {
      if (_characteristics[i].key == name) {
        color = _characteristics[i];
      }
    }

    return color;
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
