import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/features/drawer/data/bloc/favorite_state.dart';
import 'package:haji_market/features/drawer/data/repository/favorite_repo.dart';

import '../models/product_model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteCubit({required this.favoriteRepository}) : super(InitState());



  Future<void> myFavorites() async {
    try {
      emit(LoadingState());
      final List<ProductModel> data = await favoriteRepository.favorites();

      emit(LoadedState(data));

    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }



  Future<void> favorite(id) async {
    try {
      await favoriteRepository.favorite(id);
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
