import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/admin/auth/data/bloc/login_admin_state.dart';
import '../repository/LoginAdminRepo.dart';

class LoginAdminCubit extends Cubit<LoginAdminState> {
  final LoginAdminRepository loginAdminRepository;

  LoginAdminCubit({required this.loginAdminRepository}) : super(InitState());

  Future<void> login(String name, String password) async {
    try {
      emit(LoadingState());
      final data = await loginAdminRepository.login(name, password);

      if (data == 200) {
        emit(LoadedState());
        emit(InitState());
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
}
