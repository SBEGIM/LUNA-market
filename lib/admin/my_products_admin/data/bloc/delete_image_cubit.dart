import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/admin/my_products_admin/data/repository/ProductAdminRepo.dart';

class DeleteImageCubit extends Cubit<DeleteImageState> {
  final ProductAdminRepository _repository;

  DeleteImageCubit({required ProductAdminRepository colorRepository})
      : _repository = colorRepository,
        super(InitState());

  Future<void> deleteImage({
    required int productId,
    required String imagePath,
  }) async {
    try {
      emit(LoadingState());
      final data = await _repository.deleteImage(productId: productId, imagePath: imagePath);
      if (data == 200) {
        emit(LoadedState(deletingImagePath: imagePath));
      }else{
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
      Get.snackbar('Ошибка при удаление продукта!', '', backgroundColor: Colors.redAccent);
    }
  }

  void toInit() {
    emit(InitState());
  }
}

abstract class DeleteImageState {}

class InitState extends DeleteImageState {}

class LoadingState extends DeleteImageState {}

class LoadedState extends DeleteImageState {
  String deletingImagePath;

  LoadedState({required this.deletingImagePath});
}

class ErrorState extends DeleteImageState {
  String message;
  ErrorState({required this.message});
}
