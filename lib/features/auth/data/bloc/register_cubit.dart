import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/features/auth/data/bloc/register_state.dart';
import '../../../app/presentaion/base.dart';
import '../DTO/register.dart';
import '../repository/registerRepo.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository registerRepository;

  RegisterCubit({required this.registerRepository}) : super(InitState());

  Future<void> register(RegisterDTO register) async {
    try {
      emit(LoadingState());
      final data = await registerRepository.register(register);
      if (data == 200) {
        emit(LoadedState());
        // Get.offAll(() => const Base(index: 0));
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
