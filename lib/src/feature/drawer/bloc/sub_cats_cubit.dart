import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../../home/data/model/cat_model.dart';
import '../data/repository/sub_cats_repo.dart';
import 'sub_cats_state.dart';

class SubCatsCubit extends Cubit<SubCatsState> {
  final SubCatsRepository subCatRepository;

  SubCatsCubit({required this.subCatRepository}) : super(InitState());
  List<CatsModel> _subCats = [];

  Future<void> subCats(
    subCatId, {
    bool? isAddAllProducts,
  }) async {
    try {
      emit(LoadingState());

      final List<CatsModel> data = await subCatRepository.subCatApi(subCatId);

      _subCats = data;
      if (isAddAllProducts == false) {
      } else {
        _subCats.insert(
            0, CatsModel(id: 1, name: "Все товары", icon: 'cats/all_cats.png'));
      }

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> subCatsBrandOptions(
    subCatId,
    int? brandId,
    int? optionId, {
    bool? isAddAllProducts,
  }) async {
    try {
      emit(LoadingState());

      final List<CatsModel> data =
          await subCatRepository.subCatBrandApi(subCatId, brandId, optionId);

      _subCats = data;
      if (isAddAllProducts == false) {
      } else {
        _subCats.insert(
            0, CatsModel(id: 1, name: "Все товары", icon: 'cats/all_cats.png'));
      }

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<List<CatsModel>> subCatList(subCatId) async {
    if (_subCats.isEmpty) {
      await subCats(subCatId);
    }

    return _subCats;
  }

  void subSave() {
    emit(LoadedState(_subCats));
  }

  Future<void> searchSubCats(String cats, subCatId) async {
    if (cats.isEmpty) return;
    if (_subCats.isEmpty) {
      await subCats(subCatId);
    }
    List<CatsModel> temp = [];
    for (int i = 0; i < _subCats.length; i++) {
      if (_subCats[i].name != null &&
          _subCats[i].name!.toLowerCase().contains(cats.toLowerCase())) {
        temp.add(_subCats[i]);
      }
    }
    emit(LoadedState(temp));
  }

  Future<CatsModel> subCatById(String id, String catId) async {
    final List<CatsModel> data = await subCatRepository.subCatApi(id);

    CatsModel cat = CatsModel(id: 0, name: 'Выберите тип');
    for (int i = 0; i < data.length; i++) {
      if (data[i].id.toString() == catId) {
        cat = data[i];
      }
    }

    return cat;
  }

  Future<List<CatsModel>> subCatsList() async {
    return _subCats;
  }
}
