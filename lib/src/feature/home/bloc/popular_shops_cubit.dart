import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/home/bloc/popular_shops_state.dart';
import 'package:haji_market/src/feature/home/data/model/popular_shops_model.dart';
import 'package:haji_market/src/feature/home/data/repository/popular_shops_repository.dart';

class PopularShopsCubit extends Cubit<PopularShopsState> {
  final PopularShopsRepository popularShopsRepository;

  PopularShopsCubit({required this.popularShopsRepository})
      : super(InitState());

  List<PopularShops> _shops = [];

  Future<void> popShops() async {
    try {
      emit(LoadingState());
      final List<PopularShops> data =
          await popularShopsRepository.popularShops();

      _shops = data;
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  searchShops(String name) async {
    // if (name.isEmpty) return _shops;
    if (_shops.isEmpty || name.isEmpty) {
      // print('emit');
      await popShops();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    List<PopularShops> temp = [];
    for (int i = 0; i < _shops.length; i++) {
      if (_shops[i].name != null &&
          _shops[i].name!.toLowerCase().contains(name.toLowerCase())) {
        temp.add(_shops[i]);
      }
    }
    emit(LoadedState(temp));
  }

  searchByIdShops(int id) async {
    if (id == 0) {
      emit(LoadedState(_shops));
      return;
    }
    // if (name.isEmpty) return _shops;
    if (_shops.isEmpty) {
      // print('emit');
      await popShops();
      // final List<City> data = await listRepository.cities();
      // _cities = data;
    }
    List<PopularShops> temp = [];
    for (int i = 0; i < _shops.length; i++) {
      if (_shops[i].catId != null && _shops[i].catId! == id) {
        temp.add(_shops[i]);
      }
    }
    emit(LoadedState(temp));
  }
}
