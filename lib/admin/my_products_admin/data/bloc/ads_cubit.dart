import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/admin/my_products_admin/data/models/ad_model.dart';
import 'package:haji_market/admin/my_products_admin/data/repository/ProductAdminRepo.dart';
part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  final ProductAdminRepository repository;

  AdsCubit({required this.repository}) : super(InitState());

  Future<void> getAdsList() async {
    try {
      emit(LoadingState());
      final data = await repository.getAdsList();
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      Get.snackbar('$e', '', backgroundColor: Colors.redAccent);
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
