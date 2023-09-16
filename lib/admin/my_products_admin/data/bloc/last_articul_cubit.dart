import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/admin/my_products_admin/data/repository/ProductAdminRepo.dart';
part 'last_articul_state.dart';

class LastArticulCubit extends Cubit<LastArticulState> {
  final ProductAdminRepository repository;

  LastArticulCubit({required this.repository}) : super(InitState());

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
