import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../home/data/model/Cats.dart';
import '../repository/SubCatsRepo.dart';
import 'sub_cats_state.dart';

class SubCatsCubit extends Cubit<SubCatsState> {
  final SubCatsRepository subCatRepository;

  SubCatsCubit({required this.subCatRepository}) : super(InitState());
  List<Cats> _subCats = [];

  Future<void> subCats(subCatId) async {
    try {
      emit(LoadingState());

      final List<Cats> data = await subCatRepository.subCatApi(subCatId);

      _subCats = data;

      _subCats.insert(
          0, Cats(id: subCatId, name: "Все товары", icon: 'cats/book.png'));

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  void subSave() {
    emit(LoadedState(_subCats));
  }

  Future<void> searchSubCats(String cats, subCatId) async {
    if (cats.isEmpty) return;
    if (_subCats.isEmpty) {
      await subCats(subCatId);
    }
    List<Cats> temp = [];
    for (int i = 0; i < _subCats.length; i++) {
      if (_subCats[i].name != null &&
          _subCats[i].name!.toLowerCase().contains(cats.toLowerCase())) {
        temp.add(_subCats[i]);
      }
    }
    emit(LoadedState(temp));
  }

  Future<Cats> subCatById(String id, String catId) async {
    if (id.isEmpty) return Cats(id: 0, name: '');
    if (_subCats.isEmpty) {
      await subCats(catId);
    }
    Cats cat = Cats(id: 0, name: 'Выберите тип');
    for (int i = 0; i < _subCats.length; i++) {
      if (_subCats[i].id.toString() == id) {
        cat = _subCats[i];
      }
    }

    return cat;
  }
}
