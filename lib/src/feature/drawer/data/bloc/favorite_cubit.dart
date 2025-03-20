import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/src/feature/drawer/data/bloc/favorite_state.dart';
import 'package:haji_market/src/feature/drawer/data/repository/favorite_repo.dart';

import '../models/product_model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteCubit({required this.favoriteRepository}) : super(InitState());
  int page = 1;
  List<ProductModel> _products = [];

  Future<void> myFavorites() async {
    try {
      page = 1;
      emit(LoadingState());
      final List<ProductModel> data = await favoriteRepository.favorites(page);
      if (data.length == 0) {
        emit(NoDataState());
      } else {
        _products.clear();
        _products.addAll(data);
        emit(LoadedState(data));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> myFavoritesPagination() async {
    try {
      // emit(LoadingState());

      page++;
      final List<ProductModel> data = await favoriteRepository.favorites(page);

      for (int i = 0; i < data.length; i++) {
        _products.add(data[i]);
      }

      emit(LoadedState(_products));
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> favorite(id) async {
    try {
      await favoriteRepository.favorite(id);
    } catch (e) {
      log('${e.toString()}232');
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> favoriteTape(id) async {
    try {
      await favoriteRepository.favoriteTape(id);
    } catch (e) {
      log('${e.toString()}232');
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
