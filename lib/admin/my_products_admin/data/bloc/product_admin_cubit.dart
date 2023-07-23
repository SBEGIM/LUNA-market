import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/admin/my_products_admin/data/DTO/optom_price_dto.dart';
import 'package:haji_market/admin/my_products_admin/data/bloc/product_admin_state.dart';
import '../models/admin_products_model.dart';
import '../repository/ProductAdminRepo.dart';

class ProductAdminCubit extends Cubit<ProductAdminState> {
  final ProductAdminRepository productAdminRepository;

  ProductAdminCubit({required this.productAdminRepository})
      : super(InitState());

  List<AdminProductsModel> productsList = [];

  Future<void> update(
      String price,
      String count,
      String compound,
      String catId,
      String subCatId,
      String brandId,
      String colorId,
      String description,
      String name,
      String height,
      String width,
      String massa,
      String productId,
      String articul,
      String currency,
      String deep,
      List<dynamic> image) async {
    try {
      emit(LoadingState());
      final data = await productAdminRepository.update(
        price,
        count,
        compound,
        catId,
        subCatId,
        brandId,
        colorId,
        description,
        name,
        height,
        width,
        massa,
        productId,
        articul,
        currency,
        deep,
        image,
      );

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
      String catId,
      String subCatId,
      String brandId,
      String description,
      String name,
      String height,
      String width,
      String massa,
      String articul,
      String currency,
      String deep,
      List<dynamic> image,
      List<optomPriceDto> optom,
      String? video) async {
    try {
      emit(LoadingState());
      final data = await productAdminRepository.store(
          price,
          count,
          compound,
          catId,
          subCatId,
          brandId,
          description,
          name,
          height,
          width,
          massa,
          articul,
          currency,
          deep,
          image,
          optom,
          video);

      if (data == 200) {
        emit(ChangeState());
        emit(LoadedState(productsList));
      }
      if (data == 400) {
        emit(LoadedState(productsList));
        Get.snackbar('Ошибка запроса!', 'Неверный телефон или пароль',
            backgroundColor: Colors.redAccent);
      }
      if (data == 500) {
        emit(LoadedState(productsList));
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
      productsList.clear();
      productsList.addAll(data);
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> delete(String productId) async {
    emit(LoadingState());

    final data = await productAdminRepository.delete(productId);

    if (data == 200) {
      emit(InitState());
      emit(ChangeState());
    }

    if (data == 500) {
      emit(InitState());
      Get.snackbar('Ошибка удаление', 'У продукта есть заказы',
          backgroundColor: Colors.redAccent);
    }

    return data;
  }

  Future<String?> ad(int productId, int price) async {
    final data = await productAdminRepository.ad(productId, price);
    return data;
  }
}
