import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../model/Cats.dart';
import '../repository/CatsRepo.dart';
import 'cats_state.dart';


class CatsCubit extends Cubit<CatsState> {
  final ListRepository listRepository;

  CatsCubit({required this.listRepository}) : super(InitState());

  List<Cats> _cats = [];
  Future<void> cats() async {
    try {
      emit(LoadingState());
      final List<Cats> data = await listRepository.cats();
      _cats = data;
      // data.insert(0, City(id: -1, name: city));
      Set<String> citiesSet = {};
      // data.contains('Ал');

      for (int i = 0; i < data.length; i++) {
        // data[i].name.contains('Ал');
        citiesSet.add(data[i].name.toString());
      }

      emit(LoadedState(data, citiesSet, data.first.name!));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
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
