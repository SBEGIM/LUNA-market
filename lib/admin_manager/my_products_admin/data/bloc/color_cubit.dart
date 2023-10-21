import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../../../../features/home/data/model/Cats.dart';
import '../repository/ColorAdminRepo.dart';
import 'color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  final ColorAdminRepository colorRepository;

  ColorCubit({required this.colorRepository}) : super(InitState());

  List<Cats> _colors = [];

  Future<void> brands() async {
    try {
      emit(LoadingState());
      final List<Cats> data = await colorRepository.get();
      _colors = data;
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  ColorById(
    String id,
  ) async {
    if (id.isEmpty) return;
    if (_colors.isEmpty) {
      await brands();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    Cats color = Cats(id: 0, name: 'Выберите цвет');

    for (int i = 0; i < _colors.length; i++) {
      if (_colors[i].name != null &&
          _colors[i].name!.toLowerCase().contains(id)) {
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
