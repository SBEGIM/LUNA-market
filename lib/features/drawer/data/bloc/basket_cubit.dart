import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/features/drawer/data/bloc/favorite_state.dart';
import 'package:haji_market/features/drawer/data/repository/favorite_repo.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteCubit({required this.favoriteRepository}) : super(InitState());

  Future<void> favorite(id) async {
    try {
      final data = await favoriteRepository.favorite(id);
      if(data == 200){
        Get.snackbar('Успешно', '' , backgroundColor: Colors.blueAccent);
      }else{
        Get.snackbar('Ошибка', '' , backgroundColor: Colors.redAccent);

      }


    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
