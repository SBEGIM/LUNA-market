import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../home/data/model/Cats.dart';
import '../repository/SubCatsRepo.dart';
import 'sub_cats_state.dart';


class SubCatsCubit extends Cubit<SubCatsState> {
  final SubCatsRepository subCatRepository;

  SubCatsCubit({required this.subCatRepository}) : super(InitState());
  List<Cats> _subCats = [];


  Future<void> subCats(sub_cat_id) async {
    try {
      emit(LoadingState());
      final List<Cats> data = await subCatRepository.subCatApi(sub_cat_id);
      _subCats = data;

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  void subSave() {
    emit(LoadedState(_subCats));
  }

  Future<void> searchSubCats(String cats ,sub_cat_id ) async {
    if(cats.isEmpty) return;
    if(_subCats.isEmpty) {
      await subCats(sub_cat_id);
    }
    List<Cats> temp = [];
    for(int i = 0 ; i < _subCats.length; i++) {
      if(_subCats[i].name != null && _subCats[i].name!.toLowerCase().contains(cats.toLowerCase())) {
        temp.add(_subCats[i]);
      }
    }
    emit(LoadedState(temp));
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
