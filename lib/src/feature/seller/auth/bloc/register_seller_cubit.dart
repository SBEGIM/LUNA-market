import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/feature/seller/auth/bloc/register_seller_state.dart';
import 'package:haji_market/src/feature/seller/auth/data/repository/register_seller_repository.dart';

import '../data/DTO/register_seller_dto.dart';

class RegisterSellerCubit extends Cubit<RegisterSellerState> {
  final RegisterSellerRepository registerAdminRepository;

  RegisterSellerCubit({required this.registerAdminRepository})
      : super(InitState());

  Future<void> register(RegisterSellerDTO register) async {
    try {
      emit(LoadingState());
      final data = await registerAdminRepository.register(register);

      if (data == 200) {
        emit(LoadedState());
        emit(InitState());
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
}
