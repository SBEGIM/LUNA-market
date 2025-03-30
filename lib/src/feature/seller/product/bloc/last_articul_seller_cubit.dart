import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/product_seller_repository.dart';
part 'last_articul_seller_state.dart';

class LastArticulSellerCubit extends Cubit<LastArticulSellerState> {
  final ProductSellerRepository repository;

  LastArticulSellerCubit({required this.repository}) : super(InitState());

  Future<void> getLastArticul() async {
    try {
      emit(LoadingState());
      final int data = await repository.getLastArticul();
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      Get.snackbar('$e', '', backgroundColor: Colors.redAccent);
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
