import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../../../../features/home/data/model/Cats.dart';
import '../repository/CharacteristicAdminRepo.dart';
import 'color_state.dart';

class CharacteristicsCubit extends Cubit<ColorState> {
  final CharacteristicAdminRepo characteristicRepository;

  CharacteristicsCubit({required this.characteristicRepository}) : super(InitState());

  List<Cats> _characteristics = [];

  Future<List<Cats>?> characteristic() async {
    try {
      emit(LoadingState());
      final List<Cats> data = await characteristicRepository.get();
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
    Cats color = Cats(id: 0, name: 'Выберите характеристику');
    for (int i = 0; i < _characteristics.length; i++) {
      if (_characteristics[i].name == name) {
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
