import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../../../home/data/model/cats.dart';
import '../repository/BrandRepo.dart';
import 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  final BrandsRepository brandRepository;

  BrandCubit({required this.brandRepository}) : super(InitState());
  List<CatsModel> _brands = [];

  Future<void> brands({
    int? subCatId,
    bool hasNotSpecified = false,
  }) async {
    try {
      emit(LoadingState());
      final List<CatsModel> data =
          await brandRepository.brandApi(subCatId: subCatId);
      _brands = data;
      if (hasNotSpecified) {
        _brands.insert(0, CatsModel(name: 'Не определен'));
      }
      if (_brands.isEmpty) {
        emit(NoDataState());
      } else {
        emit(LoadedState(_brands));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
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
