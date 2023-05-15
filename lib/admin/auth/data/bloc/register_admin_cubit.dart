import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/admin/auth/data/bloc/register_admin_state.dart';
import 'package:haji_market/admin/auth/data/repository/registerAdminRepo.dart';

import '../DTO/register_admin_dto.dart';

class RegisterAdminCubit extends Cubit<RegisterAdminState> {
  final RegisterAdminRepository registerAdminRepository;

  RegisterAdminCubit({required this.registerAdminRepository})
      : super(InitState());

  Future<void> register(RegisterAdminDTO register) async {
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
