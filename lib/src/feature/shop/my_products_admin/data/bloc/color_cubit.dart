import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../../../../home/data/model/cats.dart';
import '../repository/ColorAdminRepo.dart';
import 'color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  final ColorAdminRepository colorRepository;

  ColorCubit({required this.colorRepository}) : super(InitState());

  List<CatsModel> _colors = [];

  Future<List<CatsModel>?> brands() async {
    try {
      emit(LoadingState());
      final List<CatsModel> data = await colorRepository.get();
      _colors = data;
      emit(LoadedState(data));
      return _colors;
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
    if (_colors.isEmpty) {
      await brands();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    CatsModel color = CatsModel(id: 0, name: 'Выберите цвет');
    for (int i = 0; i < _colors.length; i++) {
      if (_colors[i].name == name) {
        color = _colors[i];
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
