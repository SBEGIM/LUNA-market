import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/admin/my_products_admin/data/bloc/product_admin_state.dart';
import '../models/admin_products_model.dart';
import '../repository/ProductAdminRepo.dart';

class ProductAdminCubit extends Cubit<ProductAdminState> {
  final ProductAdminRepository productAdminRepository;

  ProductAdminCubit({required this.productAdminRepository})
      : super(InitState());

  Future<void> update(
    String price,
    String count,
    String compound,
    String cat_id,
    String brand_id,
    String description,
    String name,
    String height,
    String width,
    String massa,
    String product_id,
    String articul,
  ) async {
    try {
      emit(LoadingState());
      final data = await productAdminRepository.update(
          price,
          count,
          compound,
          cat_id,
          brand_id,
          description,
          name,
          height,
          width,
          massa,
          product_id,
          articul);

      if (data == 200) {
        emit(InitState());
        emit(ChangeState());
      }
      if (data == 400) {
        emit(InitState());
        Get.snackbar('Ошибка запроса!', 'Неверный телефон или пароль',
            backgroundColor: Colors.redAccent);
      }
      if (data == 500) {
        emit(InitState());
        Get.snackbar('500', 'Ошибка сервера',
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }

  Future<void> store(
      String price,
      String count,
      String compound,
      String cat_id,
      String brand_id,
      String description,
      String name,
      String height,
      String width,
      String massa,
      String articul) async {
    try {
      emit(LoadingState());
      final data = await productAdminRepository.store(price, count, compound,
          cat_id, brand_id, description, name, height, width, massa, articul);

      if (data == 200) {
        emit(InitState());
        emit(ChangeState());
      }
      if (data == 400) {
        emit(InitState());
        Get.snackbar('Ошибка запроса!', 'Неверный телефон или пароль',
            backgroundColor: Colors.redAccent);
      }
      if (data == 500) {
        emit(InitState());
        Get.snackbar('500', 'Ошибка сервера',
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }

  Future<void> products(String? name) async {
    try {
      emit(LoadingState());
      final List<AdminProductsModel> data =
          await productAdminRepository.products(name);

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
