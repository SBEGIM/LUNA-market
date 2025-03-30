import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/product_seller_repository.dart';

class DeleteImageSellerCubit extends Cubit<DeleteImageSellerState> {
  final ProductSellerRepository _repository;

  DeleteImageSellerCubit({required ProductSellerRepository colorRepository})
      : _repository = colorRepository,
        super(InitState());

  Future<void> deleteImage({
    required int productId,
    required String imagePath,
  }) async {
    try {
      emit(LoadingState());
      final data = await _repository.deleteImage(
          productId: productId, imagePath: imagePath);
      if (data == 200) {
        emit(LoadedState(deletingImagePath: imagePath));
      } else {
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
      Get.snackbar('Ошибка при удаление продукта!', '',
          backgroundColor: Colors.redAccent);
    }
  }

  void toInit() {
    emit(InitState());
  }
}

abstract class DeleteImageSellerState {}

class InitState extends DeleteImageSellerState {}

class LoadingState extends DeleteImageSellerState {}

class LoadedState extends DeleteImageSellerState {
  String deletingImagePath;

  LoadedState({required this.deletingImagePath});
}

class ErrorState extends DeleteImageSellerState {
  String message;
  ErrorState({required this.message});
}
