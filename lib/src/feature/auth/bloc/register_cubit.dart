import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/auth/bloc/register_state.dart';
import '../data/DTO/register.dart';
import '../data/repository/register_repo.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository registerRepository;

  RegisterCubit({required this.registerRepository}) : super(InitState());

  Future<void> register(BuildContext context, RegisterDTO register) async {
    try {
      emit(LoadingState());
      final data = await registerRepository.register(register);
      if (data == 200) {
        emit(LoadedState());
        // Get.offAll(() => const Base(index: 0));
      }
      if (data == 400) {
        emit(InitState());

        AppSnackBar.show(context, 'Номер телефона занят', type: AppSnackType.error);
      }

      if (data == 500) {
        emit(InitState());

        AppSnackBar.show(context, 'Ошибка сервера', type: AppSnackType.error);
      }
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }
}
