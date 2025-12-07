import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../../home/data/model/cat_model.dart';
import '../data/repository/brand_repo.dart';

class BrandCubit extends Cubit<BrandState> {
  final BrandsRepository brandRepository;

  BrandCubit({required this.brandRepository}) : super(BrandStateInitial());
  List<CatsModel> _brands = [];

  Future<void> brands({int? subCatId, bool hasNotSpecified = false}) async {
    try {
      emit(BrandStateLoading());
      final List<CatsModel> data = await brandRepository.brandApi(subCatId: subCatId);
      _brands = data;
      if (hasNotSpecified) {
        _brands.insert(0, CatsModel(name: 'Не определен'));
      }
      if (_brands.isEmpty) {
        emit(BrandStateNoData());
      } else {
        emit(BrandStateLoaded(_brands));
      }
    } catch (e) {
      log(e.toString());
      emit(BrandStateError(message: 'Ошибка сервера'));
    }
  }

  Future<List<CatsModel>> brandsList() async {
    if (_brands.isEmpty) {
      await brands();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    return _brands;
  }

  brandById(String id) async {
    if (id.isEmpty) return;
    if (_brands.isEmpty) {
      await brands();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    CatsModel brand = CatsModel(id: 0, name: '');
    for (int i = 0; i < _brands.length; i++) {
      if (_brands[i].id.toString() == id) {
        brand = _brands[i];
      }
    }

    return brand;
  }

  Future<void> searchBrand(String name) async {
    if (name.isEmpty) return;
    if (_brands.isEmpty) {
      await brands();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    List<CatsModel> temp = [];
    for (int i = 0; i < _brands.length; i++) {
      if (_brands[i].name != null && _brands[i].name!.toLowerCase().contains(name.toLowerCase())) {
        temp.add(_brands[i]);
      }
    }
    emit(BrandStateLoaded(temp));
  }
}

sealed class BrandState {
  const BrandState();
}

class BrandStateInitial extends BrandState {}

class BrandStateLoading extends BrandState {}

class BrandStateNoData extends BrandState {}

class BrandStateLoaded extends BrandState {
  final List<CatsModel> cats;

  const BrandStateLoaded(this.cats);
}

class BrandStateError extends BrandState {
  final String message;

  const BrandStateError({required this.message});
}
