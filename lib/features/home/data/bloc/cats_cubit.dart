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

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  void saveCats() {
    emit(LoadedState(_cats));
  }

  Future<void> searchCats(String name) async {
    if (name.isEmpty) return;
    if (_cats.isEmpty) {
      await cats();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    List<Cats> temp = [];
    for (int i = 0; i < _cats.length; i++) {
      if (_cats[i].name != null &&
          _cats[i].name!.toLowerCase().contains(name.toLowerCase())) {
        temp.add(_cats[i]);
      }
    }
    emit(LoadedState(temp));
  }

  catById(String id) async {
    if (id.isEmpty) return;
    if (_cats.isEmpty) {
      await cats();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    Cats cat = Cats(id: 0, name: '');
    for (int i = 0; i < _cats.length; i++) {
      if (_cats[i].id.toString() == id) {
        cat = _cats[i];
      }
    }

    return cat;
  }
}
