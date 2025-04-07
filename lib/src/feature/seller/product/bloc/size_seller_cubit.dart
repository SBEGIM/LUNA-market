import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/seller/product/bloc/size_seller_state.dart';
import '../../../home/data/model/cat_model.dart';
import '../data/repository/size_seller_repository.dart';

class SizeSellerCubit extends Cubit<SizeSellerState> {
  final SizeSellerRepository sizeRepository;

  SizeSellerCubit({required this.sizeRepository}) : super(InitState());

  List<CatsModel> _colors = [];

  Future<List<CatsModel>?> sizes() async {
    try {
      emit(LoadingState());
      final List<CatsModel> data = await sizeRepository.get();
      _colors = data;
      emit(LoadedState(data));
      return _colors;
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
    return null;
  }

  ColorById(
    String name,
  ) async {
    if (name.isEmpty) return;
    if (_colors.isEmpty) {
      await sizes();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    CatsModel color = CatsModel(id: 0, name: 'Выберите цвет');
    for (int i = 0; i < _colors.length; i++) {
      if (_colors[i].name == name) {
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
