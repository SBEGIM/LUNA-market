import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../home/data/model/Cats.dart';
import '../repository/SubCatsRepo.dart';
import 'sub_cats_state.dart';


class SubCatsCubit extends Cubit<SubCatsState> {
  final SubCatsRepository subCatRepository;

  SubCatsCubit({required this.subCatRepository}) : super(InitState());

  Future<void> subCats(sub_cat_id) async {
    try {
      emit(LoadingState());
      final List<Cats> data = await subCatRepository.subCatApi(sub_cat_id);

      emit(LoadedState(data));
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
