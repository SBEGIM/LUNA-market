import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/features/drawer/data/models/shops_drawer_model.dart';
import '../repository/shops_drawer_repo.dart';
import 'shops_drawer_state.dart';

class ShopsDrawerCubit extends Cubit<ShopsDrawerState> {
  final ShopsDrawerRepository shopsDrawerRepository;

  ShopsDrawerCubit({required this.shopsDrawerRepository}) : super(InitState());

  Future<void> shopsDrawer(int? cat_id) async {
    try {
      emit(LoadingState());
      final List<ShopsDrawerModel> data =
          await shopsDrawerRepository.shopsDrawer(cat_id);

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
