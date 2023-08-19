import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/admin/my_products_admin/data/DTO/optom_price_dto.dart';
import 'package:haji_market/admin/my_products_admin/data/DTO/size_count_dto.dart';
import 'package:haji_market/admin/my_products_admin/data/bloc/product_admin_state.dart';
import '../models/admin_products_model.dart';
import '../repository/ProductAdminRepo.dart';

class ProductAdminCubit extends Cubit<ProductAdminState> {
  final ProductAdminRepository productAdminRepository;

  ProductAdminCubit({required this.productAdminRepository}) : super(InitState());

  List<AdminProductsModel> productsList = [];

  int page = 1;

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
    List<dynamic> image,
    List<optomPriceDto> optom,
    List<sizeCountDto> size,
    fulfillment,
    String? video,
    String point,
    String pointBlogger,
  ) async {
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
        optom,
        size,
        fulfillment,
        video,
        point,
        pointBlogger,
      );

      if (data == 200) {
        emit(InitState());
        emit(ChangeState());
      }
      if (data == 400) {
        emit(InitState());
        Get.snackbar('Ошибка запроса!', 'Неверный телефон или пароль', backgroundColor: Colors.redAccent);
      }
      if (data == 500) {
        emit(InitState());
        Get.snackbar('500', 'Ошибка сервера', backgroundColor: Colors.redAccent);
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
      String? brandId,
      String colorId,
      String description,
      String name,
      String height,
      String width,
      String massa,
      String point,
      String pointBlogger,
      String articul,
      String currency,
      bool isSwitchedBs,
      String deep,
      List<dynamic> image,
      List<optomPriceDto> optom,
      List<sizeCountDto> size,
      fulfillment,
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
          colorId,
          description,
          name,
          height,
          width,
          massa,
          point,
          pointBlogger,
          articul,
          currency,
          isSwitchedBs,
          deep,
          image,
          optom,
          size,
          fulfillment,
          video);

      if (data == 200) {
        emit(ChangeState());
        emit(LoadedState(productsList));
      }
      if (data == 400) {
        emit(LoadedState(productsList));
        Get.snackbar('Ошибка запроса!', 'Неверный телефон или пароль', backgroundColor: Colors.redAccent);
      }
      if (data == 500) {
        emit(LoadedState(productsList));
        Get.snackbar('500', 'Ошибка сервера', backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }

  Future<void> products(String? name) async {
    try {
      page = 1;
      emit(LoadingState());
      final List<AdminProductsModel> data = await productAdminRepository.products(name, page);
      productsList.clear();
      data.forEach((element) {
        productsList.add(element);
      });
      emit(LoadedState(data));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> productsPaginate(String? name) async {
    try {
      page++;
      // emit(LoadingState());
      final List<AdminProductsModel> data = await productAdminRepository.products(name, page);
      // productsList.clear();
      // productsList.addAll(data);
      for (int i = 0; i < data.length; i++) {
        productsList.add(data[i]);
      }

      emit(LoadedState(productsList));
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
      Get.snackbar('Ошибка удаление', 'У продукта есть заказы', backgroundColor: Colors.redAccent);
    }

    return data;
  }

  Future<String?> ad(int productId, int price) async {
    final data = await productAdminRepository.ad(productId, price);
    return data;
  }
}
