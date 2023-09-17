import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haji_market/features/auth/data/bloc/login_state.dart';

import '../repository/LoginRepo.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  LoginCubit({required this.loginRepository}) : super(InitState());

  Future<void> login(String phone, String password) async {
    try {
      emit(LoadingState());
      final data = await loginRepository.login(phone, password);

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

  Future<void> lateAuth() async {
    try {
      emit(LoadingState());
      final data = await loginRepository.lateAuth();

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

  Future<void> edit(String name, String phone, String avatar, String gender, String birthday, String country,
      String city, String street, String home, String porch, String floor, String room, String email) async {
    try {
      emit(LoadingState());
      await loginRepository.edit(
          name, phone, avatar, gender, birthday, country, city, street, home, porch, floor, room, email);
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> editPush(int pushStatus) async {
    try {
      emit(LoadingState());
      await loginRepository.editPush(pushStatus);
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> cityCode(code) async {
    try {
      await loginRepository.code(code);
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }

  Future<void> delete() async {
    try {
      await loginRepository.delete();
    } catch (e) {
      log(e.toString());
      // emit(ErrorState(message: 'Ошибка'));
    }
  }
}
