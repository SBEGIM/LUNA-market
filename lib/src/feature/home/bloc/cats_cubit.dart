import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/home/data/repository/cats_repository.dart';
import '../data/model/cat_model.dart';
import 'cats_state.dart';

class CatsCubit extends Cubit<CatsState> {
  final ICatsRepository catsRepository;

  CatsCubit({required this.catsRepository}) : super(InitState());

  List<CatsModel> _cats = [];

  List<CatsModel> _catsBrand = [];

  Future<void> cats() async {
    try {
      emit(LoadingState());
      final List<CatsModel> data = await catsRepository.getCats();
      _cats = data;

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> catsByBrand(int brandId) async {
    try {
      emit(LoadingState());
      final List<CatsModel> data = await catsRepository.getBrandCats(brandId);

      if (data.length != 0) {
        _catsBrand = data;
        emit(LoadedState(_catsBrand));
      } else {
        emit(NoDataState());
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<List<CatsModel>> catsList() async {
    return _cats;
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
    List<CatsModel> temp = [];
    for (int i = 0; i < _cats.length; i++) {
      if (_cats[i].name != null && _cats[i].name!.toLowerCase().contains(name.toLowerCase())) {
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
    CatsModel cat = CatsModel(id: 0, name: '');
    for (int i = 0; i < _cats.length; i++) {
      if (_cats[i].id.toString() == id) {
        cat = _cats[i];
      }
    }

    return cat;
  }
}
