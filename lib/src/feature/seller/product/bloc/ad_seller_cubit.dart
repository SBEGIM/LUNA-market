import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/feature/seller/product/data/models/ad_seller_model.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/product_seller_repository.dart';
part 'ad_seller_state.dart';

class AdSellerCubit extends Cubit<AdSellerState> {
  final ProductSellerRepository repository;

  AdSellerCubit({required this.repository}) : super(InitState());

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

  Future<String?> ad(int productId, int price) async {
    final data = await repository.ad(productId, price);
    return data;
  }
}
