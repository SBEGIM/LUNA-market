import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/auth/bloc/sms_state.dart';

import '../data/repository/register_repo.dart';

class SmsCubit extends Cubit<SmsState> {
  final RegisterRepository registerRepository;

  SmsCubit({required this.registerRepository}) : super(InitState());

  Future<void> smsSend(String phone) async {
    try {
      emit(LoadingState());
      final data = await registerRepository.smsSend(phone);
      if (data == 200) {
        Get.snackbar('Успешно!', 'Код отправлен на ваш номер!',
            backgroundColor: Colors.blueAccent);
        emit(LoadedState());
      }
      if (data == 400) {
        emit(InitState());
        Get.snackbar('Ошибка запроса!', 'Номер занят',
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

  Future<void> smsResend(String phone) async {
    try {
      emit(LoadingState());
      final data = await registerRepository.smsSend(phone);
      if (data == 200) {
        Get.snackbar('Успешно!', 'Код отправлен на ваш номер!',
            backgroundColor: Colors.blueAccent);
        emit(InitState());
      }
      if (data == 400) {
        emit(InitState());
        Get.snackbar('Ошибка запроса!', 'Номер занят',
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

  Future<void> smsCheck(String phone, String code) async {
    try {
      emit(LoadingState());
      final data = await registerRepository.smsCheck(phone, code);
      if (data == 200) {
        emit(LoadedState());
        emit(InitState());
      }
      if (data == 400) {
        emit(InitState());
        Get.snackbar('Ошибка запроса!', 'Неверный код',
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

  Future<void> resetSend(BuildContext context, String phone) async {
    try {
      emit(LoadingState());
      final data = await registerRepository.resetSend(phone);
      if (data == 200) {
        AppSnackBar.show(
          context,
          'Код отправлен на ваш номер',
          type: AppSnackType.success,
        );
        emit(LoadedState());
        // Get.to(PasswordResetPage(phone: phone));
      }
      if (data == 400) {
        emit(InitState());

        AppSnackBar.show(
          context,
          'Номер не существует или набран неправильно',
          type: AppSnackType.error,
        );
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

  Future<void> resetCheck(String phone, String code) async {
    try {
      emit(LoadingState());
      final data = await registerRepository.resetCheck(phone, code);
      if (data == 200) {
        emit(LoadedState());
        emit(InitState());
      }
      if (data == 400) {
        emit(InitState());
        Get.snackbar('Ошибка запроса!', 'Неверный код',
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

  Future<void> passwordReset(String phone, String password) async {
    try {
      emit(LoadingState());
      final data = await registerRepository.passwordReset(phone, password);
      if (data == 200) {
        emit(ResetSuccessState());
        emit(InitState());
      }
      if (data == 400) {
        emit(InitState());
        Get.snackbar('Ошибка запроса!', 'Неверный код',
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
