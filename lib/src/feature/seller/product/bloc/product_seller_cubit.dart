import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/feature/seller/product/data/DTO/optom_price_seller_dto.dart';
import 'package:haji_market/src/feature/seller/product/data/DTO/size_count_seller_dto.dart';
import 'package:haji_market/src/feature/seller/product/bloc/product_seller_state.dart';
import '../data/models/product_seller_model.dart';
import '../data/repository/product_seller_repository.dart';

class ProductSellerCubit extends Cubit<ProductAdminState> {
  final ProductSellerRepository productAdminRepository;

  ProductSellerCubit({required this.productAdminRepository})
      : super(InitState());

  List<ProductSellerModel> productsList = [];

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
    bool isSwitchedBs,
    String deep,
    List<dynamic> image,
    List<OptomPriceSellerDto> optom,
    List<SizeCountSellerDto> size,
    fulfillment,
    String? video,
    String point,
    String pointBlogger,
    List<int>? subIds,
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
          isSwitchedBs,
          deep,
          image,
          optom,
          size,
          fulfillment,
          video,
          point,
          pointBlogger,
          subIds);

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
      String? subCatId,
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
      List<OptomPriceSellerDto> optom,
      List<SizeCountSellerDto> size,
      fulfillment,
      List<int>? subIds,
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
          subIds,
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
      emit(InitState());
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }

  Future<void> products(String? name) async {
    try {
      page = 1;
      emit(LoadingState());
      final List<ProductSellerModel> data =
          await productAdminRepository.products(name, page);
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
      final List<ProductSellerModel> data =
          await productAdminRepository.products(name, page);
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
